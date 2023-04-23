.data
.text

.global my_rdtsc

my_rdtsc:

push %ebp
mov %esp, %ebp

xor %eax, %eax
cmpb %al, 8(%ebp)
je equal_to_zero

push %ebx
cpuid
rdtsc
pop %ebx
pop %ebp
ret

equal_to_zero:
rdtscp

pop %ebp
ret

