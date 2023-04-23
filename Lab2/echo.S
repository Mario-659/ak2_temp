SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0

msgLen = 80
.data
msg: .space msgLen
.text
.global _start
_start:

mov $SYSREAD, %eax
mov $STDIN, %ebx
mov $msg, %ecx
mov $msgLen, %edx
int $0x80

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $msg, %ecx
mov $msgLen, %edx
int $0x80

mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %ebx
int $0x80

