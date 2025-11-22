	.section .data
	
	.section .text
	.global handle_delimiter_byte
# PURPOSE: TO HANDLE DELIMITER BYTES FOUND IN THE CALCULATION_LINE BUFFER THROUGH THE TOKENIZER
#
# PARAMETERS:
# 1- current token pointer		16(%rbp)
#
# RETURNS: IT THROUGH %RAX EITHER:
#	0 - (NOTHING) 
#	1 - (THE CURRENT TOKEN MUST BE ENDED)

handle_delimiter_byte:
	pushq %rbp
	movq %rsp, %rbp

	movq 16(%rbp), %rbx		# move current pointer token to rbx

	cmpb $0, LENGTH(%rbx)		# check if current token's length is equal to 0.
	je token_has_not_started	# if it is == 0 then the token has not yet started.
	jge token_already_started	# if it is >  0 then the token already started.
	jne invalid_token_length	# if it is <  0 then the token length is invalid and an error must have been produced somewhere in the code.

token_already_started:
	movq $1, %rax			# return 1 through rax to symbolize that the current token must be ended
	popq %rbp
	ret

token_has_not_started:
	movq $0, %rax			# return 0 through rax to symbolize that nothing must be done
	popq %rbp
	ret

invalid_token_length:
	movq $60, %rax
	movq $1, %rdi
	syscall
