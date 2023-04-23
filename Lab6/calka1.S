SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0

n_const = 100
.data
format: .ascii "%f\n"
a: .float 1
b: .float 4
n: .float 100
dwa: .float 2
h: .float 0
suma: .float 0
f1: .float 0
f2: .float 0
x: .float 0
.text

.global main

main:

pxor %xmm0, %xmm0

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
mov $n_const, %ecx
sumowanie_trapezow:
#obliczanie f1
finit
fld x
fsin
fdiv x
fstp f1
fwait

#zwiekszanie x o h
finit
fld x
fadd h
fstp x

#obliczanie f2
finit
fld x
fsin
fdiv x
fstp f2
fwait

#pole trapezu bez mnozenia razy h
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


loop sumowanie_trapezow

cvtss2sd suma, %xmm0
cvtss2sd h, %xmm1
mulsd %xmm1, %xmm0
#fld suma
#fstp (%esp)

#cvtss2sd x, %xmm0
#wyswietlanie wyniku
subl $24, %esp
movsd %xmm0, (%esp)
pushl $format
call printf
addl $28, %esp

#koniec
mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %ebx
int $0x80

