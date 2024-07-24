```
bonus0@RainFall:~$ gdb ./bonus0 
GNU gdb (Ubuntu/Linaro 7.4-2012.04-0ubuntu2.1) 7.4-2012.04
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i686-linux-gnu".
For bug reporting instructions, please see:
<http://bugs.launchpad.net/gdb-linaro/>...
Reading symbols from /home/user/bonus0/bonus0...(no debugging symbols found)...done.

(gdb) info function
All defined functions:

Non-debugging symbols:
0x08048334  _init
0x08048380  read
0x08048380  read@plt
0x08048390  strcat
0x08048390  strcat@plt
0x080483a0  strcpy
0x080483a0  strcpy@plt
0x080483b0  puts
0x080483b0  puts@plt
0x080483c0  __gmon_start__
0x080483c0  __gmon_start__@plt
0x080483d0  strchr
0x080483d0  strchr@plt
0x080483e0  __libc_start_main
0x080483e0  __libc_start_main@plt
0x080483f0  strncpy
0x080483f0  strncpy@plt
0x08048400  _start
0x08048430  __do_global_dtors_aux
0x08048490  frame_dummy
0x080484b4  p
0x0804851e  pp
0x080485a4  main
0x080485d0  __libc_csu_init
0x08048640  __libc_csu_fini
0x08048642  __i686.get_pc_thunk.bx
0x08048650  __do_global_ctors_aux
0x0804867c  _fini


(gdb) disas main
Dump of assembler code for function main:
   0x080485a4 <+0>:	push   %ebp
   0x080485a5 <+1>:	mov    %esp,%ebp
   0x080485a7 <+3>:	and    $0xfffffff0,%esp
   0x080485aa <+6>:	sub    $0x40,%esp
   0x080485ad <+9>:	lea    0x16(%esp),%eax
   0x080485b1 <+13>:	mov    %eax,(%esp)
   0x080485b4 <+16>:	call   0x804851e <pp>
   0x080485b9 <+21>:	lea    0x16(%esp),%eax
   0x080485bd <+25>:	mov    %eax,(%esp)
   0x080485c0 <+28>:	call   0x80483b0 <puts@plt>
   0x080485c5 <+33>:	mov    $0x0,%eax
   0x080485ca <+38>:	leave  
   0x080485cb <+39>:	ret    
End of assembler dump.


(gdb) disas p
Dump of assembler code for function p:
   0x080484b4 <+0>:	push   %ebp
   0x080484b5 <+1>:	mov    %esp,%ebp
   0x080484b7 <+3>:	sub    $0x1018,%esp
   0x080484bd <+9>:	mov    0xc(%ebp),%eax
   0x080484c0 <+12>:	mov    %eax,(%esp)
   0x080484c3 <+15>:	call   0x80483b0 <puts@plt>
   0x080484c8 <+20>:	movl   $0x1000,0x8(%esp)
   0x080484d0 <+28>:	lea    -0x1008(%ebp),%eax
   0x080484d6 <+34>:	mov    %eax,0x4(%esp)
   0x080484da <+38>:	movl   $0x0,(%esp)
   0x080484e1 <+45>:	call   0x8048380 <read@plt>
   0x080484e6 <+50>:	movl   $0xa,0x4(%esp)
   0x080484ee <+58>:	lea    -0x1008(%ebp),%eax
   0x080484f4 <+64>:	mov    %eax,(%esp)
   0x080484f7 <+67>:	call   0x80483d0 <strchr@plt>
   0x080484fc <+72>:	movb   $0x0,(%eax)
   0x080484ff <+75>:	lea    -0x1008(%ebp),%eax
   0x08048505 <+81>:	movl   $0x14,0x8(%esp)
   0x0804850d <+89>:	mov    %eax,0x4(%esp)
   0x08048511 <+93>:	mov    0x8(%ebp),%eax
   0x08048514 <+96>:	mov    %eax,(%esp)
   0x08048517 <+99>:	call   0x80483f0 <strncpy@plt>
   0x0804851c <+104>:	leave  
   0x0804851d <+105>:	ret    
End of assembler dump.


(gdb) disas pp
Dump of assembler code for function pp:
   0x0804851e <+0>:	push   %ebp
   0x0804851f <+1>:	mov    %esp,%ebp
   0x08048521 <+3>:	push   %edi
   0x08048522 <+4>:	push   %ebx
   0x08048523 <+5>:	sub    $0x50,%esp
   0x08048526 <+8>:	movl   $0x80486a0,0x4(%esp)
   0x0804852e <+16>:	lea    -0x30(%ebp),%eax
   0x08048531 <+19>:	mov    %eax,(%esp)
   0x08048534 <+22>:	call   0x80484b4 <p>
   0x08048539 <+27>:	movl   $0x80486a0,0x4(%esp)
   0x08048541 <+35>:	lea    -0x1c(%ebp),%eax
   0x08048544 <+38>:	mov    %eax,(%esp)
   0x08048547 <+41>:	call   0x80484b4 <p>
   0x0804854c <+46>:	lea    -0x30(%ebp),%eax
   0x0804854f <+49>:	mov    %eax,0x4(%esp)
   0x08048553 <+53>:	mov    0x8(%ebp),%eax
   0x08048556 <+56>:	mov    %eax,(%esp)
   0x08048559 <+59>:	call   0x80483a0 <strcpy@plt>
   0x0804855e <+64>:	mov    $0x80486a4,%ebx
   0x08048563 <+69>:	mov    0x8(%ebp),%eax
   0x08048566 <+72>:	movl   $0xffffffff,-0x3c(%ebp)
   0x0804856d <+79>:	mov    %eax,%edx
   0x0804856f <+81>:	mov    $0x0,%eax
   0x08048574 <+86>:	mov    -0x3c(%ebp),%ecx
   0x08048577 <+89>:	mov    %edx,%edi
   0x08048579 <+91>:	repnz scas %es:(%edi),%al
   0x0804857b <+93>:	mov    %ecx,%eax
   0x0804857d <+95>:	not    %eax
   0x0804857f <+97>:	sub    $0x1,%eax
   0x08048582 <+100>:	add    0x8(%ebp),%eax
   0x08048585 <+103>:	movzwl (%ebx),%edx
   0x08048588 <+106>:	mov    %dx,(%eax)
   0x0804858b <+109>:	lea    -0x1c(%ebp),%eax
   0x0804858e <+112>:	mov    %eax,0x4(%esp)
   0x08048592 <+116>:	mov    0x8(%ebp),%eax
   0x08048595 <+119>:	mov    %eax,(%esp)
   0x08048598 <+122>:	call   0x8048390 <strcat@plt>
   0x0804859d <+127>:	add    $0x50,%esp
   0x080485a0 <+130>:	pop    %ebx
   0x080485a1 <+131>:	pop    %edi
   0x080485a2 <+132>:	pop    %ebp
   0x080485a3 <+133>:	ret    
End of assembler dump.

```