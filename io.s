	.section .data
PROMPT:
	.asciz "Please enter a mathematical express that does not include variables\n"
	
	.section .text
	# PARAMETERS: buffer, amount_to_read

.global print_prompt
print_prompt:
	movq $1, %rax
	movq $1, %rdi
	leaq PROMPT(%rip), %rsi
	movq $68, %rdx
	syscall

	ret

.global read_input
read_input:
	pushq %rbp
	movq %rsp, %rbp

	movq $0, %rax
	movq $0, %rdi
	movq 16(%rbp), %rsi		# dereference pointer into rsi
	movq 24(%rbp), %rdx		# get amount_to_read arg
	syscall

	test %rax, %rax
	js error_exit

	popq %rbp
	ret

error_exit:
	movq $60, %rax
	movq $1, %rdi
	syscall
	
