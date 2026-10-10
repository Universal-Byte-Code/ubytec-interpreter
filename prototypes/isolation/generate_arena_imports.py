#!/usr/bin/env python3
"""Emit reviewable source wrappers for existing typed module imports.

Each loan becomes (arena, allocation, offset, length); scalars keep their type.
Budget and native-result pointer follow the declared arguments. Wrapper result
is the existing bridge status. No monitor authority resides in this generator.
"""
import argparse,re
from pathlib import Path
IMPORT=re.compile(r'^\s*import\s+(\w+)\s+from\s+\w+\.\w+\s*\(([^)]*)\)\s*->\s*(\w+)\s*$',re.M)
def emit_wrappers(source):
    if '// BEGIN GENERATED ARENA IMPORTS' in source:raise ValueError('Source already contains generated wrappers')
    out=[];names=set(re.findall(r'\bfunc\s+(\w+)',source))|{m.group(1) for m in IMPORT.finditer(source)}
    for match in IMPORT.finditer(source):
        alias,types,result=match.groups();args=[s.strip() for s in types.split(',') if s.strip()]
        loans=[i for i,t in enumerate(args) if t in ('t_loan_rw','t_loan_ro')]
        if len(args)>6 or len(loans)>2 or result not in ('t_int64','t_uint64') or any(t not in ('t_loan_rw','t_loan_ro','t_int64','t_uint64') for t in args):raise ValueError('Unsupported typed import: '+alias)
        if args==['t_uint64']*4 and result=='t_int64':raise ValueError('Reserved legacy buffer ABI: '+alias)
        name='Arena_'+alias
        if name in names:raise ValueError('Wrapper name collision: '+name)
        names.add(name);params=[];locals=[];body=[]
        def load(v):body.append('load @'+v)
        def zero_result():load('resultcell');body.extend(('push 0','store t_int64'))
        def rejected(clean=()):
            for j in reversed(tuple(clean)):
                load(f'a{j}_arena');load(f'a{j}_pointer');body.extend(('call ArenaUnpin', 'store @ignored'))
            body.extend(('push 1','return'))
        for i,t in enumerate(args):
            if i in loans:
                params += ['t_uint64 a'+str(i)+'_'+s for s in ('arena','pointer','offset','length')]
                locals += ['t_uint64 node'+str(i)+' 0','t_uint64 size'+str(i)+' 0']
            else:params.append(t+' a'+str(i))
        params += ['t_uint64 budget','t_uint64 resultcell'];locals += ['t_uint64 ignored 0','t_int64 status 1']
        zero_result()
        # Validate all spans before pinning. Subtraction avoids overflow, including
        # offsets/lengths with their high bit set. Never lend allocator headers.
        for i in loans:
            load(f'a{i}_arena');load(f'a{i}_pointer');body += ['call ArenaFind','store @node'+str(i),f'if @node{i} == 0'];rejected();body+=['end']
            load('node'+str(i));body += ['push 8','add','load t_uint64','store @size'+str(i),f'if @a{i}_offset > @size{i}'];rejected();body += ['end']
            load('size'+str(i));load(f'a{i}_offset');body+=['sub','store @size'+str(i),f'if @a{i}_length > @size{i}'];rejected();body+=['end']
        pinned=[]
        for i in loans:
            load(f'a{i}_arena');load(f'a{i}_pointer');body+=['call ArenaPin','store @ignored','if @ignored == 0'];rejected(pinned);body+=['end'];pinned.append(i)
        for i in range(len(args)):
            if i in loans:load(f'a{i}_pointer');load(f'a{i}_offset');body+=['add'];load(f'a{i}_length')
            else:load('a'+str(i))
        load('budget');load('resultcell');body += ['call '+alias,'store @status']
        for i in reversed(loans):load(f'a{i}_arena');load(f'a{i}_pointer');body+=['call ArenaUnpin','store @ignored']
        load('status');body+=['return']
        out.append('func '+name+'('+','.join(params)+') -> t_int64 {\nlocal { '+' '.join(locals)+' }\n'+'\n'.join(body)+'\n}\n')
    if not out:raise ValueError('No supported imports found')
    return '// BEGIN GENERATED ARENA IMPORTS\n'+''.join(out)+'// END GENERATED ARENA IMPORTS\n'
def generate(source,arena_library=None):
    wrappers=emit_wrappers(source)
    if not source.rstrip().endswith('}'):raise ValueError('Expected a module ending with }')
    if arena_library:
        body=arena_library.split('{',1)[1].rsplit('}',1)[0]
        for name in ('ArenaFind','ArenaPin','ArenaUnpin'):
            if re.search(r'\bfunc\s+'+name+r'\b',source):raise ValueError('Arena already defined in source')
        wrappers=body+'\n'+wrappers
    return source.rstrip()[:-1]+wrappers+'}\n'
def main():
    p=argparse.ArgumentParser();p.add_argument('source',type=Path);p.add_argument('-o','--output',type=Path,required=True);p.add_argument('--arena-library',type=Path);a=p.parse_args()
    try:result=generate(a.source.read_text(encoding='utf-8'),a.arena_library.read_text(encoding='utf-8') if a.arena_library else None)
    except ValueError as e:p.error(str(e))
    a.output.write_text(result,encoding='utf-8')
if __name__=='__main__':main()
