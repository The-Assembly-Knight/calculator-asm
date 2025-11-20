	.section .data
	.set INVALID_BYTE,	-1
	.set REGULAR_BYTE,	0
	.set DELIMITER_BYTE,	1
	.set STANDALONE_BYTE,	2
	.set END_OF_LINE_BYTE,	3

	.section .rodata
byte_type_look_up_table:
	.byte END_OF_LINE_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte END_OF_LINE_BYTE		# \n
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte DELIMITER_BYTE		# ' '
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte STANDALONE_BYTE		# '('
	.byte STANDALONE_BYTE		# ')'
	.byte STANDALONE_BYTE		# '*'
	.byte STANDALONE_BYTE		# '+'
	.byte INVALID_BYTE
	.byte STANDALONE_BYTE		# '-'
	.byte INVALID_BYTE
	.byte STANDALONE_BYTE		# '/'
	.byte REGULAR_BYTE		# '0'
	.byte REGULAR_BYTE		# '1'
	.byte REGULAR_BYTE		# '2'
	.byte REGULAR_BYTE		# '3'
	.byte REGULAR_BYTE		# '4'
	.byte REGULAR_BYTE		# '5'
	.byte REGULAR_BYTE		# '6'
	.byte REGULAR_BYTE		# '7'
	.byte REGULAR_BYTE		# '8'
	.byte REGULAR_BYTE		# '9'
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE
	.byte INVALID_BYTE

	.section .text
	.global get_byte_type
# first argument: byte of which the type will be identified
# returns type in %rax
get_byte_type:
	push %rbp
	movq %rsp, %rbp

	leaq byte_type_look_up_table(%rip), %rax	# get a pointer to look-up table

	movq 16(%rbp), %rbx				# get first argument (byte to be identified) into %rbx
	movzbq %bl, %rbx				# zero-extend %rbx to make sure there is no junk in it
check_rbx:
	movq (%rax, %rbx), %rax				# get %rbx index in look-up table and store it in %rax
	movzbq %al, %rax
check_rcx:

	popq %rbp					# restore base pointer
	ret
