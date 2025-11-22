	.section .data

	.section .text
	.global handle_invalid_byte
handle_invalid_byte:
	movq $60, %rax
	movq $1, %rdi
	syscall
