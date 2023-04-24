.data
.text

.global my_rdtsc

my_rdtsc:

push %ebp
mov %esp, %ebp
push %ebx
push %esi

mov 8(%ebp), %esi        # iter -> esi
mov 12(%ebp), %ebx       # p -> ebx

cmp $0, %ebx
jne use_rdtscp           # If p != 0, use rdtscp

loop_cpuid_rdtsc:
    xor %eax, %eax
    cpuid
    rdtsc
    dec %esi
    jnz loop_cpuid_rdtsc
    jmp end

use_rdtscp:
    loop_rdtscp:
        xor %eax, %eax
        rdtscp
        dec %esi
        jnz loop_rdtscp

end:
pop %esi
pop %ebx
mov %ebp, %esp
pop %ebp
ret
