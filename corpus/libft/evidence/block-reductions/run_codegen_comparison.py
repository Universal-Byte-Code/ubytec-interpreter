#!/usr/bin/env python3
"""Measure current Ubytec, scalar/auto-vectorized C and native reduction prototypes."""
import argparse,hashlib,json,math,platform,statistics,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parent
REPO=ROOT.parents[1]
def command(args):
 p=subprocess.run([str(a) for a in args],capture_output=True,text=True,timeout=240)
 if p.returncode:raise RuntimeError(str(args)+'\n'+p.stdout+p.stderr)
 return p.stdout
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 p=argparse.ArgumentParser();p.add_argument('--ubytec-assembly',type=Path,required=True);p.add_argument('--loop-reduction-assembly',type=Path);p.add_argument('--block-reduction-assembly',type=Path);p.add_argument('--large-working-sets',action='store_true');p.add_argument('--output',type=Path,default=ROOT/'build/codegen-comparison');a=p.parse_args()
 out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
 paths=[ROOT/n for n in ('run_codegen_comparison.py','reduction-compare.c','reduction-candidates.nasm','reduction-intrinsics.c','diagnose-kernels.c')]
 report={'accepted':False,'scope':'RAM byte-reduction prototypes; not a new Ubytec optimizer','platform':platform.platform(),'warmup':5,'samples':40,'order':'rotating interleaved in one process','sources':{p.name:sha(p) for p in paths},'ubytec_assembly_sha256':sha(a.ubytec_assembly),'compilers':{},'results':{}}
 if a.loop_reduction_assembly:
  report['scope']='Compiler scalar reduction plus ordinary-RAM SIMD prototypes'
  report['loop_reduction_assembly_sha256']=sha(a.loop_reduction_assembly)
 if a.block_reduction_assembly:
  report['scope']='Compiler scalar and page-bounded SSE2 reductions plus RAM prototypes'
  report['block_reduction_assembly_sha256']=sha(a.block_reduction_assembly)
 sizes=(256,4096,65536,262144,1048576,16777216) if a.large_working_sets else (256,4096,65536)
 report['working_set_sizes']=sizes
 try:
  report['cpu']=command(['lscpu']);report['cpu_flags']=next(line for line in Path('/proc/cpuinfo').read_text().splitlines() if line.startswith('flags'))
  report['cache_geometry_cpu0']={}
  for cache in sorted(Path('/sys/devices/system/cpu/cpu0/cache').glob('index*')):
   report['cache_geometry_cpu0'][cache.name]={name:(cache/name).read_text().strip() for name in ('level','type','size','coherency_line_size','shared_cpu_list')}
  objects=[]
  for cc in ('gcc','clang'):
   report['compilers'][cc]=command([cc,'--version']).splitlines()[0]
   for mode,flags in (('scalar',['-O2',*(['-fno-tree-vectorize'] if cc=='gcc' else ['-fno-vectorize','-fno-slp-vectorize'])]),('native',['-O3','-march=native'])):
    obj=out/(cc+'-'+mode+'.o');prefix='c_'+cc+'_'+mode+'_'
    renames=['-Dc_Diag'+name+'='+prefix+name.lower() for name in ('Identity','Bytes','Records','Lookup')]
    command([cc,*flags,'-Wall','-Wextra','-Werror',*renames,'-c',ROOT/'diagnose-kernels.c','-o',obj]);objects.append(obj)
    (out/(cc+'-'+mode+'.disasm')).write_text(command(['objdump','-dr','-Mintel',obj]))
    report['compilers'][cc+'_'+mode+'_flags']=flags
   obj=out/(cc+'-intrinsics.o');command([cc,'-O3','-march=native','-Wall','-Wextra','-Werror','-DREDUCE_NAME=c_'+cc+'_intrinsic_bytes','-c',ROOT/'reduction-intrinsics.c','-o',obj]);objects.append(obj)
   (out/(cc+'-intrinsics.disasm')).write_text(command(['objdump','-dr','-Mintel',obj]))
  for source,name in ((a.ubytec_assembly,'ubytec'),(ROOT/'reduction-candidates.nasm','candidates')):
   obj=out/(name+'.o');command(['nasm','-f','elf64',source,'-o',obj]);objects.append(obj)
   (out/(name+'.disasm')).write_text(command(['objdump','-dr','-Mintel',obj]))
  if a.loop_reduction_assembly:
   obj=out/'ubytec-loop.o';command(['nasm','-f','elf64',a.loop_reduction_assembly,'-o',obj]);objects.append(obj)
   (out/'ubytec-loop.disasm').write_text(command(['objdump','-dr','-Mintel',obj]))
  if a.block_reduction_assembly:
   obj=out/'ubytec-block.o';command(['nasm','-f','elf64',a.block_reduction_assembly,'-o',obj]);objects.append(obj)
   (out/'ubytec-block.disasm').write_text(command(['objdump','-dr','-Mintel',obj]))
  extra_flags=['-DWITH_LOOP_REDUCTION'] if a.loop_reduction_assembly else []
  if a.block_reduction_assembly:extra_flags+=['-DWITH_BLOCK_REDUCTION']
  if a.large_working_sets:extra_flags+=['-DWITH_LARGE_WORKING_SETS']
  exe=out/'compare';command(['gcc','-O2',*extra_flags,'-D_GNU_SOURCE','-Wall','-Wextra','-Werror','-no-pie',ROOT/'reduction-compare.c',*objects,'-o',exe])
  raw=command([exe]);(out/'samples.jsonl').write_text(raw);rows=[json.loads(line) for line in raw.splitlines()]
  report['validation']=rows[0];assert report['validation']['event']=='validation'
  data=rows[1:];assert len(data)==len(sizes)*40*report['validation']['variants']
  for size in sizes:
   case={};group=[r for r in data if r['size']==size]
   assert len({r['result'] for r in group})==1
   for variant in sorted({r['variant'] for r in group}):
    records=[r for r in group if r['variant']==variant];assert {r['sample'] for r in records}==set(range(40))
    timings=sorted(r['ns']/r['batch'] for r in records)
    case[variant]={'median_ns':statistics.median(timings),'p95_ns':timings[math.ceil(.95*len(timings))-1],'samples':timings}
   report['results'][str(size)]=case
  report['accepted']=True
 finally:(out/'report.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main()
