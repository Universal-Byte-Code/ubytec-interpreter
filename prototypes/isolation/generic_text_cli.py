#!/usr/bin/env python3
"""Three isolated text stages with generic arena wrappers and file publication."""
import argparse,struct,subprocess,tempfile
from pathlib import Path
from run import records
def main():
    p=argparse.ArgumentParser();p.add_argument('--artifacts',required=True,type=Path)
    p.add_argument('--input',required=True,type=Path);p.add_argument('--output',required=True,type=Path)
    p.add_argument('--capacity',type=int,default=32768);p.add_argument('--fields',type=int,default=256);a=p.parse_args()
    if not 0<=a.capacity<=32768 or not 0<=a.fields<=256:p.error('capacity: 0..32768; fields: 0..256')
    with a.input.open('rb') as f:text=f.read(8193)
    if len(text)>8192:p.error('input limit: 8192 bytes')
    outcap=len(text)+1;data=bytearray([0xa5])*(96+len(text)+a.capacity+outcap)
    struct.pack_into('<8Q',data,0,len(text),a.capacity,a.fields,outcap,0,0,0,0);data[64:64+len(text)]=text
    art=a.artifacts.resolve()
    with tempfile.TemporaryDirectory(prefix='ubytec-generic-text-') as t:
        inp=Path(t)/'input.bin';out=Path(t)/'output.bin';inp.write_bytes(data)
        argv=[str(art/'generic-gcc'),'--contracts',str(art/'dynamic-text.elf'),'DynamicText']
        for module in ('lexer','mapper','writer'):argv+=['--module',module,str(art/(module+'.elf'))]
        for alias,target in (('Tokenize','lexer.ParseFields'),('Normalize','mapper.UpperText'),('Render','writer.BuildText')):argv+=['--grant-many',alias,target,'3','65536','1','65536','1000']
        argv+=['--input',str(inp),'--output',str(out)];proc=subprocess.run(argv,capture_output=True,text=True,timeout=10)
        r=next((x for x in records(proc.stdout) if x.get('case')=='program'),{})
        if proc.returncode or not r.get('pass') or r.get('value',-1)<0:p.error('allocation or application failed; output was not published')
        got=out.read_bytes();length=r['value'];base=64+len(text);published=base+16+a.capacity
        if len(got)!=len(data) or got[:32]!=data[:32] or got[64:base]!=text or got[-16:]!=data[-16:] or not 0<=length<outcap or struct.unpack_from('<Q',got,32)[0]!=length or struct.unpack_from('<Q',got,base+8)[0]!=0 or got[published+length]!=0:p.error('invalid output packet')
        a.output.write_bytes(got[published:published+length])
    print(f'{len(text)} input bytes -> {length} output bytes; three isolated stages')
if __name__=='__main__':main()
