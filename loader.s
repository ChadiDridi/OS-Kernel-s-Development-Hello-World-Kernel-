.set MAGIC, 0x1badb002
.set FLAGS, (1<<0 | 1<<1)
.set CHECKSUM, -(MAGIC + FLAGS)

.section .multiboot
    .long MAGIC
    .long CHECKSUM
    .long FLAGS
.section .note.GNU-stack,"",@progbits

.section .text
.extern kernelMain
.global loader

loader:
    mov $kernel_stack, %esp
    pushq %eax
    pushq %ebx
    call kernelMain

_stop:
    cli
    hlt
    jmp _stop

.section .bss
.space 2*1024*1024 #2 MiB
kernel_stack:
