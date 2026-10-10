#!/usr/bin/env python3
"""Compile ordinary Ubytec lists and contrast native callbacks with a C model."""
import argparse
import hashlib
import json
import platform
import shutil
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parent
REPO = ROOT.parents[1]
EXPORTS = ('ArenaInit', 'ArenaAlloc', 'ArenaFree', 'ArenaFind', 'ArenaPin',
           'ArenaUnpin', 'ft_lstnew_arena', 'ft_lstsize', 'ft_lstlast',
           'ft_lstadd_front_arena', 'ft_lstadd_back_arena', 'ListMap',
           'ListClear', 'ListDelete', 'ListIter', 'ListCheck', 'ListCallRaw')

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def command(args, timeout=180):
    result = subprocess.run([str(a) for a in args], capture_output=True,
                            text=True, timeout=timeout)
    if result.returncode:
        raise RuntimeError(str(args) + '\n' + result.stdout + '\n' + result.stderr)
    return result.stdout

def composed():
    bodies = []
    for name in ('arena', 'lists', 'lists-fixtures'):
        source = (ROOT / (name + '.ubc')).read_text(encoding='utf-8')
        bodies.append(source.split('{', 1)[1].rsplit('}', 1)[0])
    return 'module (name:"lists_native",version:"0.1",author:"Ubytec") {\n' + ''.join(bodies) + '\n}\n'

def manifest():
    paths = [REPO / 'Ubytec/Ubytec.csproj', REPO / 'Ubytec.Tests/Ubytec.Tests.csproj']
    paths += list((REPO / 'Ubytec/Language').rglob('*.cs'))
    paths += [REPO / 'Ubytec/Program.cs', REPO / 'Ubytec/Language/Grammar/ubytec.tmLanguage.json']
    paths += [ROOT / n for n in ('arena.ubc', 'lists.ubc', 'lists-fixtures.ubc', 'lists-reference.c', 'run_lists.py')]
    paths += [REPO / 'Ubytec.Tests' / n for n in ('ListTests.cs', 'IndirectCallTests.cs')]
    return {p.relative_to(REPO).as_posix(): digest(p) for p in sorted(paths)}

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--prepare-only', action='store_true')
    parser.add_argument('--compile-only', action='store_true')
    parser.add_argument('--assembly-directory', type=Path)
    parser.add_argument('--dotnet', default='dotnet')
    parser.add_argument('--output', type=Path, default=ROOT / 'build/lists')
    args = parser.parse_args()
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    source = out / 'lists-composed.ubc'
    asm = out / 'lists-composed.nasm'
    source.write_text(composed(), encoding='utf-8')
    if args.prepare_only:
        print('Sources prepared; no compilation or tests executed.')
        return
    report = {'schema': 1, 'accepted': False, 'platform': platform.platform(),
              'source_sha256': manifest(), 'native': {}}
    try:
        if args.assembly_directory:
            previous = args.assembly_directory
            if (previous / source.name).read_text(encoding='utf-8') != source.read_text(encoding='utf-8'):
                raise RuntimeError('Staged source disagrees with canonical library')
            shutil.copyfile(previous / source.name, source)
            shutil.copyfile(previous / asm.name, asm)
            proof = json.loads((previous / 'lists-provenance.json').read_text(encoding='utf-8-sig'))
            for key, value in (('source_sha256', report['source_sha256']),
                               ('composed_source_sha256', digest(source)),
                               ('assembly_sha256', digest(asm))):
                if proof[key] != value:
                    raise RuntimeError('Staged compiler provenance mismatch: ' + key)
            report['compiler_sha256'] = proof['compiler_sha256']
        else:
            command([args.dotnet, 'build', REPO / 'Ubytec/Ubytec.csproj', '-c', 'Release',
                     '-p:EnableDocFxOnBuild=false', '-p:GenerateDocumentationFile=false', '--nologo'])
            dll = REPO / 'Ubytec/bin/Release/net9.0/Ubytec.dll'
            exports = []
            for name in EXPORTS:
                exports += ['--host-export', name + '=ubytec_host_' + name]
            command([args.dotnet, dll, source, '--library', *exports, '-o', asm])
            report['compiler_sha256'] = digest(dll)
        report['composed_source_sha256'] = digest(source)
        report['assembly_sha256'] = digest(asm)
        proof = {k: report[k] for k in ('source_sha256', 'compiler_sha256',
                                       'composed_source_sha256', 'assembly_sha256')}
        (out / 'lists-provenance.json').write_text(json.dumps(proof, indent=2) + '\n', encoding='utf-8')
        if args.compile_only:
            print('Ubytec compiled; native C model not executed.')
            return
        obj = out / 'lists-composed.o'
        command(['nasm', '-f', 'elf64', asm, '-o', obj])
        report['environment'] = {cc: command([cc, '--version']).splitlines()[0] for cc in ('gcc', 'clang')}
        report['environment']['nasm'] = command(['nasm', '-v']).strip()
        for variant in ('gcc', 'clang', 'sanitized'):
            exe = out / ('lists-' + variant)
            flags = ['-O2'] if variant != 'sanitized' else [
                '-O1', '-g', '-fsanitize=address,undefined', '-fno-sanitize-recover=all',
                '-fno-omit-frame-pointer']
            command([variant if variant != 'sanitized' else 'gcc', '-std=c11', *flags,
                     '-Wall', '-Wextra', '-Werror', '-no-pie', ROOT / 'lists-reference.c', obj, '-o', exe])
            raw = command([exe])
            (out / ('native-' + variant + '.jsonl')).write_text(raw, encoding='utf-8')
            row = json.loads(raw)
            if not row['accepted'] or row['random_steps'] != 10000 or row['invalid_target_faults'] != 2 or not row['failed_maps'] or not row['pin_rejections']:
                raise RuntimeError('Incomplete native corpus: ' + variant)
            if variant != 'gcc' and row != report['native']['gcc']:
                raise RuntimeError('Native clients disagree')
            report['native'][variant] = row
            print(variant + ': PASS ' + str(row['random_steps']) + ' random steps, ' + str(row['checks']) + ' model checks', flush=True)
        report['sanitizer_scope'] = 'C model/client instrumented; generated NASM checked by model bytes, counts, allocation accounting and guards.'
        report['invalid_target_scope'] = 'Native child faults validate null/NX targets, not a new isolation mechanism.'
        report['accepted'] = True
    finally:
        (out / 'lists-report.json').write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')

if __name__ == '__main__':
    main()
