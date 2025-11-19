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

	subq 8, %rsp			# make space for a local variable into the stack
	movq $0, -8(%rbp)		# set local variable 1 to 0.
	
	movq 16(%rbp), %rax		# get calculation_line pointer into rax

	jmp get_next_token

get_next_token:
	pushq (%rax)
	call get_byte_type		# the type will be stored in %rax
	addq $8, %rsp			# restore stack pointer to before the get_byte_type argument was pushed

	jmp end_tokenize_string
 

standalone_byte:
	
end_byte:


end_tokenize_string:
	movq %rbp, %rsp			# discard local variables

	popq %rbp
	ret
