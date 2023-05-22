EXIT_NR  = 1
READ_NR  = 3
WRITE_NR = 4
STDOUT = 1
STDIN = 0
EXIT_CODE_SUCCESS = 0

num_intervals = 100

.data
# ctrlWord: .byte 
format: .ascii "%f\n"
a: .float -2
b: .float 2
x: .float 0
h: .float 0
n: .float 100
siedem: .float 7
dwa: .float 2
y: .float 0
suma: .float 0

.text
.global main

main:

# zaladowanie control word
# fstcw 

# obliczenie h
fld b
fsub a
fdiv n
fstp h


# x = a
fld a
fstp x


mov $num_intervals, %ecx

sumowanie_kwadratow:

# obliczanie y = f(x)
fld x
fmul x
fmul dwa
fsub siedem
fstp y


# suma += y * h
fld y
fmul h
fadd suma
fstp suma

# x += h
fld x
fadd h
fstp x

# Dekrementacja %ecx i skok, jeśli niezerowy
sub $1, %ecx
jnz sumowanie_kwadratow

# float na double dla printf
cvtss2sd suma, %xmm0


sub $8, %esp
movsd %xmm0, (%esp)
push $format
call printf

pop %ebx
add $8, %esp

mov $EXIT_NR          , %eax
mov $EXIT_CODE_SUCCESS, %ebx 
int $0x80
