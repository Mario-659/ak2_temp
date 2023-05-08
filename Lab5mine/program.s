SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0

num_intervals = 100
.data
format: .ascii "%f\n"
a: .float 0
b: .float 1
n: .float 100
dwa: .float 2
jeden: .float 1
h: .float 0
suma: .float 0
f1: .float 0
f2: .float 0
x: .float 0
.text

.global main

main:

pxor %xmm0, %xmm0

# obliczenie h
finit
fld b
fsub a
fdiv n
fstp h
fwait


finit
fld a
fstp x
fwait
mov $num_intervals, %ecx

sumowanie_trapezow:

# obliczanie f1
finit
fld x
fmul x
fadd jeden
fsqrt
fstp f1
fwait

# zwiekszanie x o h
finit
fld x
fadd h
fstp x

# obliczanie f2
finit
fld x
fmul x
fadd jeden
fsqrt
fstp f2
fwait

# pole trapezu bez mnozenia razy h
finit
fld f1
fadd f2
fdiv dwa
fstp f1
fwait

finit
fld suma
fadd f1
fstp suma
fwait

# Dekrementacja %ecx i skok, jeśli niezerowy
sub $1, %ecx
jnz sumowanie_trapezow

cvtss2sd suma, %xmm0
cvtss2sd h, %xmm1
mulsd %xmm1, %xmm0

# wypisanie wyniku
subl $28, %esp
movsd %xmm0, (%esp)
pushl $format
call printf
addl $32, %esp

# koniec
mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %ebx
int $0x80
