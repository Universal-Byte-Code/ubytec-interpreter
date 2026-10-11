#!/usr/bin/env python3
"""Run source-level incremental uppercase with a bounded private arena."""
import argparse,struct,subprocess,tempfile
from pathlib import Path
from run import records
def main():
    p=argparse.ArgumentParser();p.add_argument('--artifacts',required=True,type=Path)
    p.add_argument('--input',required=True,type=Path);p.add_argument('--output',required=True,type=Path)
    p.add_argument('--chunk',type=int,default=64);p.add_argument('--capacity',type=int,default=32768);a=p.parse_args()
    if not 1<=a.chunk<=256 or not 0<=a.capacity<=32768:p.error('chunk: 1..256; capacity: 0..32768')
    with a.input.open('rb') as f:text=f.read(16385)
    if len(text)>16384:p.error('input limit: 16384 bytes')
    payload=bytearray([0xa5])*(64+len(text)+a.capacity)
    struct.pack_into('<4Q',payload,0,len(text),a.capacity,a.chunk,0);payload[32:32+len(text)]=text
    with tempfile.TemporaryDirectory(prefix='ubytec-arena-text-') as t:
        inp=Path(t)/'input.bin';out=Path(t)/'output.bin';inp.write_bytes(payload)
        proc=subprocess.run([str((a.artifacts/'arena-gcc').resolve()),'--contracts',str((a.artifacts/'arena.elf').resolve()),'TextGrow','--input',str(inp),'--output',str(out)],capture_output=True,text=True,timeout=10)
        r=next((r for r in records(proc.stdout) if r.get('case')=='program'),{})
        if proc.returncode or not r.get('pass') or r.get('value')!=len(text):p.error('allocation or execution failed; output was not published')
        data=out.read_bytes()
        if len(data)!=len(payload) or data[:24]!=payload[:24] or struct.unpack_from('<q',data,24)[0]!=len(text) or data[-16:]!=payload[-16:]:p.error('invalid output packet')
        a.output.write_bytes(data[32:32+len(text)])
    print(f'{len(text)} bytes transformed; arena limit {a.capacity} bytes')
if __name__=='__main__':main()
