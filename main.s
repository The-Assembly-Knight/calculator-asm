	.section .bss
calculation_line:
	.skip 50		# max size for calculation line is 50
	.byte 0

calculation_line_tokens:
	.skip 50*4		# max size for calculation line * size of token structure
	.byte 0

	.section .data
	.set MAX_CALCULATION_LINE_LENGTH, 50

	.section .text
	.global _start
	.extern read_input
	.extern print_prompt
	.extern tokenize_string
_start:

calculation_loop:
	call print_prompt			# print prompt (Please enter mathematical expressions..)

	leaq calculation_line(%rip), %rax	 
	push $50				# pass the max size for calculation line (amount that the function should read) as second argument to read_input
	push %rax				# pass calculation_line buffer as first argument to read_input
	call read_input
	addq $16, %rsp				# set the stack back to before the arguments were pushed to the stack

	leaq calculation_line_tokens(%rip), %rax
	pushq %rax				# pass tokens' buffer as second argument to tokenize_string
	leaq calculation_line(%rip), %rax
	pushq %rax				# pass calculation_line buffer as first argument to tokenize_string
	call tokenize_string
	addq $16, %rsp				# set the stack back to before the arguments were pushed to the stack.

	jmp exit

exit:
	movq $60, %rax
	movq $0, %rdi
	syscall

