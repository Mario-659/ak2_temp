SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0

msgLen = 80
.align 32
.data
msg: .space msgLen
.text
.global _start
_start:

petla:
mov $SYSREAD, %eax
mov $STDIN, %ebx
mov $msg, %ecx
mov $msgLen, %edx
int $0x80

mov %eax, %edx
mov $msg, %eax
cmpb $81, (%eax)
jz if2

wypisz:
mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $msg, %ecx
mov %edx, %edx
int $0x80
jmp petla

if2:
inc %eax
cmpb $10, (%eax)
jz koniec
jmp wypisz

koniec:
mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %ebx
int $0x80

