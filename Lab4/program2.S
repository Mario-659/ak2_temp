.data
format: .ascii "%llu\n"

.text
.global main

main:

rdtscp

pushl %edx
pushl %eax
push $format
call printf

mov $1, %eax
mov $0, %ebx

int $0x80

