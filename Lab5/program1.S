SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0

ARRAY_SIZE = 7

.data
format1: .ascii "Czas wypelniania tabeli zerami %llu\n"
format2: .ascii "Pobranie jednego elementu %llu\n"

array1: .space ARRAY_SIZE * 4
.text

.global main

main:
mov $array1, %edi

rdtscp
movl %eax, %ebx
movl %edx, %esi

movl $ARRAY_SIZE, %ecx
sub $4, %edi
wypelnienie_zerami:
add $4, %edi
movl $0, (%edi)
loop wypelnienie_zerami
rdtscp

sub %ebx, %eax
sbb %esi, %edx

sub $12, %esp
push %ebp
mov %esp, %ebp
pushl %edx
pushl %eax
push $format1
call printf
mov %ebp, %esp
add $12, %esp
pop %ebp


#czas pobrania jednego elementu
mov $array1, %edi
mov $ARRAY_SIZE, %ecx
sub $4, %edi
pobranie_elementu:
add $4, %edi
push %ecx
rdtscp
pop %ecx
movl %eax, %ebx
movl %edx, %esi

movl (%edi), %eax

push %ecx
rdtscp
pop %ecx

sub %ebx, %eax
sbb %esi, %edx

push %ecx
push %ebp
mov %esp, %ebp
pushl %edx
pushl %eax
push $format2
call printf
mov %ebp, %esp
add $12, %esp
pop %ebp
pop %ecx
loop pobranie_elementu


mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %ebx
int $0x80

