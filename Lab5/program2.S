SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0

ARRAY_SIZE = 7
ARRAY_ELEMENTS = ARRAY_SIZE * ARRAY_SIZE
ARRAY_ROWBYTES = ARRAY_SIZE * 4

.data
array1: .space ARRAY_SIZE * ARRAY_SIZE * 4
array2: .space ARRAY_SIZE * ARRAY_SIZE * 4
format2: .ascii "Czas wypelnienia tablicy kolumnami %llu\n"
format1: .ascii "Czas wypelnienia tablicy wierszami %llu\n"
.text
.global main

main:
#Wypelnienie tablicy wierszami
movl $ARRAY_ELEMENTS, %ecx
mov $array1, %edi
sub $4, %edi

rdtscp
movl %eax, %ebx
movl %edx, %esi

wypelnienie_zerami1:
add $4, %edi
movl $0, (%edi)
loop wypelnienie_zerami1

rdtscp
 sub %ebx, %eax
sbb %esi, %edx

push %ebp
mov %esp, %ebp
pushl %edx
pushl %eax
push $format1
call printf
mov %ebp, %esp
pop %ebp


#Wypelnienie tablicy kolumnami
movl $ARRAY_SIZE, %ecx
 
rdtscp
movl %eax, %ebx
movl %edx, %esi
movl $0, %eax
sub $1, %eax
wypelnienie_zerami2:
mov $array2, %edi
add $1, %eax
add %eax, %edi
mov $0, %edx
petla:
movl $0, (%edi)
add $ARRAY_ROWBYTES, %edi
add $1, %edx
cmp $ARRAY_SIZE, %edx
jl petla
loop wypelnienie_zerami2

rdtscp
sub %ebx, %eax
sbb %esi, %edx

push %ebp
mov %esp, %ebp
pushl %edx
pushl %eax
pushl $format2
call printf
mov %ebp, %esp
pop %ebp


mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %ebx
int $0x80

