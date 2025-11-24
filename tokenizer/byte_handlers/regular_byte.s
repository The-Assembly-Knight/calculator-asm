	.section .data
	.include "include/token_type.inc"
	.include "include/token_struct_offset.inc"

	.section .text
	.global handle_regular_byte
# PURPOSE: TO HANDLE REGULAR BYTES FOUND IN THE CALCULATION_LINE BUFFER THROUGH THE TOKENIZER
#
# PARAMETERS:
# 1- calculation_line buffer's offset	16(%rbp)
# 2- current token pointer		24(%rbp)
#
#
#
#
handle_regular_byte:
	pushq %rbp
	movq %rsp, %rbp

	movq 24(%rbp), %rbx
	
	cmpq $0, TOKEN_LENGTH_OFFSET(%rbx)		# check if the length of the token is 0.
	je token_has_not_started	# if it is 0 that means it hasnt started.
	jg token_already_started	# if it is > 0 then the token has already already started.
	jne invalid_token_length	# if it is < 0 then it is invalid and there must had been an error somewhere in the code.

token_has_not_started:
	movb $TOKEN_TYPE_NUMBER, TOKEN_TYPE_OFFSET(%rbx)	# make the current token's type type_number because since it started with a regular byte it will be a number.

	movq 16(%rbp), %rcx		# move current buffer offsett to rcx.
	movb %cl, TOKEN_START_OFFSET(%rbx)		# so only the 8-bit portion can be stored as the start of the current token in calculation_line buffer.

token_already_started:
	addb $1, TOKEN_LENGTH_OFFSET(%rbx)		# increment the length of the current token by 1.
	popq %rbp
	ret

invalid_token_length:
	movq $60, %rax
	movq $1, %rdi
	syscall
		

