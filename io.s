	.section .text
	# PARAMETERS: buffer, amount_to_read
.global read_input
read_input:
	pushq %rbp
	movq %rsp, %rbp

	movq $0, %rax
	movq $0, %rdi
	movq 16(%rbp), %rsi		# dereference pointer into rsi
	leaq (%rsi), %rsi		# get address of pointer into rsi
	movq 24(%rbp), %rdx
	syscall

	test %rax, %rax
	js error_exit

	popq %rbp
	ret

error_exit:
	movq $60, %rax
	movq $1, %rdi
	syscall
	
