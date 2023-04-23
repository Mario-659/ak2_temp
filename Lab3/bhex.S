SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0

.data
liczba: .long 4422331
.bss
wynik: .space 9
.text
.global _start

_start:

mov liczba, %eax

movb $10, (wynik+8)

mov $wynik, %edi #adres napisu

mov $8, %ecx #licznik petli
add $7, %edi

petla:
mov %eax, %ebx
andb $0xF, %bl
call check
movb %bl, (%edi)
dec %edi
shr $4, %eax
loop petla

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $wynik, %ecx
mov $9, %edx
int $0x80

mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %ebx
int $0x80


check:
cmpb $9, %bl
jg more

addb $'0', %bl
ret

more:
addb $'A', %bl
ret

