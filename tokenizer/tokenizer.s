	.section .data
	.include "include/byte_type.inc"
	.include "include/token_struct_offset.inc"

	.set ADD_SIGN, '+'
	.set SUB_SIGN, '-'
	.set MUL_SIGN, '*'
	.set DIV_SIGN, '/'
	.set LEFT_PARENTHESIS, '('
	.set RIGHT_PARENTHESIS, ')'
	.set NEW_LINE, '\n'
	.set EOF, '\0'

token:
	.space 1			# type
	.space 1			# start in buffer
	.space 1			# length
	.space 1			# padding for alignment

token_greater_than_0:
	.asciz "token greater than 0\n"

	.global token_struct_size
token_struct_size:
	.set TOKEN_STRUCT_SIZE, token_struct_size - token	# get size of token structure by substracting addresses

	.section .text
	.global tokenize_string
	.extern get_byte_type
	.extern handle_regular_byte
	.extern handle_delimiter_byte
	.extern handle_standalone_byte
	.extern handle_end_of_line_byte
	.extern handle_invalid_byte

# first argument: calculation_line pointer (input buffer) 16
# second argument: calculation_line_tokens pointer (tokens' buffer) 24
tokenize_string:
	push %rbp		
	movq %rsp, %rbp

	subq $16, %rsp			# allocate enough space for a new local variable
	movb $0, -8(%rbp)		# initiliaze local variable 1 with 0
					# local variable 1 is the calculation_line buffer's offset
	movb $0, -16(%rbp)		# lcaol variable 2 will calculation_line_tokens buffer's offset

	jmp get_next_byte

get_next_byte:
	movq 16(%rbp), %rax		# get calculation_line pointer into rax
	
	movq -8(%rbp), %rbx		# get buffer's offset into %rbx
	movq (%rax, %rbx), %rax		# load the byte #rbx in calculation_line string (%rax) and save it into rax
	movzbq %al, %rax
	jmp identify_byte

identify_byte:
	pushq %rax
	call get_byte_type		# get_byte's type and save it into rax
	addq $8, %rsp			# move stack pointer to before the function arg was pushed
	
	movq -16(%rbp), %rcx		# move local variable 2 to rcx (move the token's buffer offset)
	movzbq %cl, %rcx		
	movq 24(%rbp), %rbx		# get token's buffer into %rbx
	addq %rcx, %rbx			# add token's buffer offset to rbx (which holds the current token buffer)

	cmpb $REGULAR_BYTE, %al
	je found_regular_byte
	cmpb $DELIMITER_BYTE, %al
	je  found_delimiter_byte
	cmpb $STANDALONE_BYTE, %al
	je found_standalone_byte
	cmpb $END_OF_LINE_BYTE, %al
	je found_end_of_line_byte
	jne found_invalid_byte

found_regular_byte:
	pushq %rbx			# pass as second argument the current token's pointer
	pushq -8(%rbp)			# pass as first argument the calculation line buffer's offset
	call handle_regular_byte	# handle the regular byte that was just found
	addq $16, %rsp			# reset stack pointer to before the arguments were passed to the function
	jmp increase_buffer_offset_and_next_byte

found_delimiter_byte:
	pushq %rbx			# pass as first argument the current token's pointer
	call handle_delimiter_byte	# handle the delimiter byte that was just found
	addq $8, %rsp			# reset stack pointer to before the argument was passed to the function
	cmpq $0, %rax			# if rax == 0 that means the handle_delimiter_byte function reported that nothing must be done but to end the current token.
	je increase_buffer_offset_and_next_byte

	call end_current_token		# but if rax == 1, then that means the function reported that the current token must be ended and the function must be recalled.
	jmp increase_buffer_offset_and_next_byte

found_standalone_byte:
	pushq %rbx			# pass as second argument the current token's pointer
	pushq -8(%rbp)			# pass as first argument the calculation line buffer's offset
	call handle_standalone_byte
	addq $16, %rsp			# reset stack pointer to before the arguments were passed to the function

	cmpq $0, %rax			# if rax == 0 that means the handle_standalone_byte function repoted that nothing must be done but to end the current token.
	je no_token_found_next_to_standalone_byte

	call end_current_token		# but if rax == 1, then that means the function reported that the current token must be ended and the funcion must be recalled

	pushq TOKEN_STRUCT_SIZE(%rbx)	# pass as second argument the token pointer next to the current token's pointer
	pushq -8(%rbp)			# pass as first argument the calculation line buffer's offset
	call handle_standalone_byte
	addq $16, %rsp			# reset stack pointer to before the arguments were passed to the function

	jmp no_token_found_next_to_standalone_byte

no_token_found_next_to_standalone_byte:
	call end_current_token
	jmp increase_buffer_offset_and_next_byte

found_end_of_line_byte:
	pushq %rbx			# pass as first argument the current token's pointer
	call handle_end_of_line_byte
	addq $8, %rsp			# reset stack pointer to before the arguments were passed to the function

	cmpq $0, %rax			# if rax == 0 that means the handle_end_of_line_byte function reported that nothing must be done but to end the current token.
	je no_token_found_next_to_end_of_line_byte
	
	call end_current_token		# but if rax == 1, then that means the function reported that the current token must be ended and the function must be recalled.

	pushq TOKEN_STRUCT_SIZE(%rbx)
	call handle_end_of_line_byte

	jmp no_token_found_next_to_end_of_line_byte

no_token_found_next_to_end_of_line_byte:
	call end_current_token
	jmp end_tokenize_string

found_invalid_byte:
	call handle_invalid_byte
	jmp end_tokenize_string

increase_buffer_offset_and_next_byte:
	addb $1, -8(%rbp)		# increase by 1 the offset of the calculation_line buffer
	jmp get_next_byte

end_current_token:
	addb $TOKEN_STRUCT_SIZE, -16(%rbp)	# increase the token buffer's offset by the size of a token struct (4)
	ret
	

end_tokenize_string:
	movq %rbp, %rsp			# discard local variables

	popq %rbp
	ret

error_exit:
	movq $60, %rax
	movq $1, %rdi
	syscall
