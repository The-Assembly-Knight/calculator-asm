	.section .data

	.section .text
	.global handle_end_of_line_byte
# PURPOSE: TO HANDLE REGULAR BYTES FOUND IN THE CALCULATION_LINE BUFFER THROUGH THE TOKENIZER
#
# PARAMETERS:
# 1- current token pointer		16(%rbp)
#
# RETURNS:
#		0 - NOTHING ELSE MOST BE DONE
#		1 - THE CURRENT TOKEN MUST BE ENDED AND THE FUNCTION MUST BE RECALLED
#
handle_end_of_line_byte:
	pushq %rbp
	movq %rsp, %rbp

	movq 16(%rbp), %rbx		# get current token pointer into rbx
	
	cmpq $0, LENGTH(%rbx)		# check if the length of the token is 0.
	je token_has_not_started	# if it is 0 that means it hasnt started.
	jg token_already_started	# if it is > 0 then the token has already already started.
	jne invalid_token_length	# if it is < 0 then it is invalid and there must had been an error somewhere in the code.

token_has_not_started:
	movb $TYPE_END_OF_LINE, TYPE(%rbx)	# make the current token's type TYPE_END_OF_LINE.
	
	movq $0, %rax			# return that nothing else must be done to the current byte
	popq %rbp
	ret

token_already_started:
	movq $1, %rax			# return that the current byte has a token anexed to it so it must be ended and then call again this function
	popq %rbp
	ret

invalid_token_length:
	movq $60, %rax
	movq $1, %rdi
	syscall
