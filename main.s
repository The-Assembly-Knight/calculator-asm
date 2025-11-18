	.section .bss
calculation_line:
	.skip 50		# max size for calculation line is 50
	.byte 0

	.section .data
	.set MAX_CALCULATION_LINE_LENGTH, 50

	.section .text
	.global _start
	.extern read_input
_start:
	leaq calculation_line(%rip), %rax 
	push $50
	push %rax
	call read_input
	addq $16, %rsp

	jmp exit

exit:
	movq $60, %rax
	movq $0, %rdi
	syscall

