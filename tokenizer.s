	.section .rodata

	.set ADD_SIGN, '+'
	.set SUB_SIGN, '-'
	.set MUL_SIGN, '*'
	.set DIV_SIGN, '/'
	.set LEFT_PARENTHESIS, '('
	.set RIGHT_PARENTHESIS, ')'
	.set NEW_LINE, '\n'
	.set EOF, '\0'

	.section .data
token:
	.space 1			# type
	.space 1			# offset in buffer
	.space 1			# length
	.space 1			# padding for alignment
.global token_struct_size
token_struct_size:
	.quad token_struct_size - token # get size of token structure by substracting addresses

	.section .text
	.global tokenize_string
	.extern get_byte_type

# first argument: calculation_line pointer (input buffer) 16
# second argument: calculation_line_tokens pointer (tokens' buffer) 24
tokenize_string:
	push %rbp		
	movq %rsp, %rbp

	movq 16(%rbp), %rax		# get calculation_line pointer into rax

	jmp get_next_token

get_next_token:
	movq (%rax), %rax
	movzbq %al, %rax

	pushq %rax
	call get_byte_type
	addq $8, %rsp			# move stack pointer to before the function arg was pushed

	jmp end_tokenize_string

end_tokenize_string:
	movq %rbp, %rsp			# discard local variables

	popq %rbp
	ret
