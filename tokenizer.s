	.section .data
	.include "byte_type.inc"

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
	.set TOKEN_TYPE_OFFSET, 0				# get type mem offset from the start of token
	.set TOKEN_START_OFFSET, 1				# get start mem offset from the start of token
	.set TOKEN_LENGTH_OFFSET, 2				# get length mem offset from the start of token
	.set TOKEN_STRUCT_SIZE, token_struct_size - token	# get size of token structure by substracting addresses

	.section .text
	.global tokenize_string
	.extern get_byte_type

# first argument: calculation_line pointer (input buffer) 16
# second argument: calculation_line_tokens pointer (tokens' buffer) 24
tokenize_string:
	push %rbp		
	movq %rsp, %rbp

	subq $8, %rsp			# allocate enough space for a new local variable
	movb $0, -8(%rbp)		# initiliaze local variable 1 with 0
					# local variable 1 is the calculation_line buffer's offset

	jmp get_next_token

get_next_token:
	movq 16(%rbp), %rax		# get calculation_line pointer into rax
	
	movq -8(%rbp), %rbx		# get buffer's offset into %rbx
	movq (%rax, %rbx), %rax		# load the byte #rbx in calculation_line string (%rax) and save it into rax
	movzbq %al, %rax


identify_byte:
	pushq %rax
	call get_byte_type		# get_byte's type and save it into rax
	addq $8, %rsp			# move stack pointer to before the function arg was pushed

	movq 24(%rbp), %rbx		# get token's buffer into %rbx

	cmpb $REGULAR_BYTE, %al
	je handle_regular_byte
	cmpb $DELIMITER_BYTE, %al
	je  handle_delimiter_byte
	cmpb $STANDALONE_BYTE, %al
	je handle_standalone_byte
	cmpb $END_OF_LINE_BYTE, %al
	je handle_end_of_line_byte
	jne handle_invalid_byte

handle_regular_byte:

	cmpb $0, TOKEN_LENGTH_OFFSET(%rbx) 
	jg regular_token_already_started
							# if the current token hasnt been started (its length is less than 1) then identify the current byte as its starting point
	movb $REGULAR_BYTE, TOKEN_TYPE_OFFSET(%rbx)	# assign regular_type as the token's type

	movq -8(%rbp), %rcx				# use rcx temporarily to hold the current offset in the buffer
	movzbq %cl, %rcx
	movb %cl, TOKEN_START_OFFSET(%rbx)		# move current offset to start_offste member in current token struct
	jmp regular_token_already_started
	
regular_token_already_started:
	addb $1, TOKEN_LENGTH_OFFSET(%rbx)
	incb %cl				# increase buffer's offset
	jmp end_tokenize_string			# TEMPLATE!! here it is supposed to go to next_byte which will get repeat the process until the token is done or the string has been read

handle_delimiter_byte:
	incb %cl				# increase buffer's offset
	cmpb $0, TOKEN_LENGTH_OFFSET(%rbx)	# check if the token has already started
	jg end_current_token			# SUBSTITUTE FOR A LABEL COMMON FOR IT AND END_OF_LINE_BYTE FROM WHERE END_CURRENT_TOKEN WILL BE CALLED AND THEN IT WILL JMP TO THE NEXT BYTE
	jmp end_tokenize_string			# TEMPLATE!! here it is supposed to go to next_byte which will get repeat the process until the token is done or the string has been read

handle_standalone_byte:
	cmpb $0, TOKEN_LENGTH_OFFSET(%rbx)
	jg end_current_token			# SUBSTITUTE FOR ITS OWN LABEL, AND THEN FROM THAT LABEL CALL (call instruction) END_CURRENT_TOKEN
	# TODO: ADD MORE RBX reloading of buffer because the buffer will now be a token ahead in case there was a token before standalone byte was found.
	
	jmp end_current_token			# SUBSTITUTE FOR A LABEL COMMON FOR IT AND END_OF_LINE_BYTE FROM WHERE END_CURRENT_TOKEN WILL BE CALLED AND THEN IT WILL JMP TO THE ENXT BYTE
	
	
handle_end_of_line_byte:
						# IT WILL JMP TO END_TOKENIZE_STRING SINCE THERE ARE NO MORE STRINGS TO BE FOUND AND 
						# IN CASE THERE IS A TOKEN BEFORE IT, THE TOKEN WILL BE ENDED BY CALLING END CURRENT TOKEN FUNCTION
handle_invalid_byte:
	jmp error_exit

end_current_token:
	# END THE CURRENT TOKEN BY INCREMENTING THE OFFSET OF TOKENS BUFFER TODO: (GOTTA ADD A NEW LOCAL VARIABLE FOR THIS)
	# THIS LABEL MUST BE A CALLABLE FUNCTION SO IT MUST END WITH RET
	

end_tokenize_string:
	movq %rbp, %rsp			# discard local variables

	popq %rbp
	ret

error_exit:
	movq $60, %rax
	movq $1, %rdi
	syscall
