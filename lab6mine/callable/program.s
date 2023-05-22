EXIT_NR  = 1
READ_NR  = 3
WRITE_NR = 4
STDOUT = 1
STDIN = 0
EXIT_CODE_SUCCESS = 0

num_intervals = 100

.data
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
.global calculateSum

calculateSum:

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
movss x, %xmm0
mulss %xmm0, %xmm0
mulss dwa, %xmm0
subss siedem, %xmm0
movss %xmm0, y

# suma += y * h
movss y, %xmm1
mulss h, %xmm1
addss suma, %xmm1
movss %xmm1, suma

# x += h
movss x, %xmm2
addss h, %xmm2
movss %xmm2, x

# Dekrementacja %ecx i skok, jeśli niezerowy
sub $1, %ecx
jnz sumowanie_kwadratow

# float na double dla wynik
cvtss2sd suma, %xmm0

# Load the floating point value from XMM0 register to ST(0) for returning the result
subl $8, %esp
movsd %xmm0, (%esp)
fldl (%esp)
addl $8, %esp

# Return from function
ret
