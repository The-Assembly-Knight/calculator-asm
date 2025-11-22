	.section .data

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
	
	cmpq $0, LENGTH(%rbx)		# check if the length of the token is 0.
	je token_has_not_started	# if it is 0 that means it hasnt started.
	jg token_already_started	# if it is > 0 then the token has already already started.
	jne invalid_token_length	# if it is < 0 then it is invalid and there must had been an error somewhere in the code.

token_has_not_started:
	movb $TYPE_NUMBER, TYPE(%rbx)	# make the current token's type type_number because since it started with a regular byte it will be a number.

	movq 16(%rbp), %rcx		# move current buffer offsett to rcx.
	movb %cl, START(%rbx)		# so only the 8-bit portion can be stored as the start of the current token in calculation_line buffer.

token_already_started:
	addb $1, LENGTH(%rbx)		# increment the length of the current token by 1.
	popq %rbp
	ret

invalid_token_length:
	movq $60, %rax
	movq $1, %rdi
	syscall
		

