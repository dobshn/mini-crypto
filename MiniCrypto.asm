.text
main:
	# input plaintext
	li $v0, 4
	la $a0, promptPlaintext
	syscall
	
	li $v0, 8
	la $a0, plaintext
	li $a1, 5
	syscall
	
	# input key
	li $v0, 4
	la $a0, promptKey
	syscall
	
	li $v0, 8
	la $a0, key
	li $a1, 5
	syscall
	
	# input mode
	li $v0, 4
	la $a0, promptMode
	syscall
	
	li $v0, 8
	la $a0, mode
	li $a1, 2
	syscall
	
	# print plaintext
	li $v0, 4
	la $a0, outputPlaintext
	syscall
	
	li $v0, 4
	la $a0, plaintext
	syscall
	
	# print key
	li $v0, 4
	la $a0, outputKey
	syscall
	
	li $v0, 4
	la $a0, key
	syscall
	
	# print mode
	li $v0, 4
	la $a0, outputMode
	syscall
	
	li $v0, 4
	la $a0, mode
	syscall
	
	# program exit
	li $v0, 10
	syscall

.data
plaintext:		.space 5
key:			.space 5
mode:			.space 2
promptPlaintext:	.asciiz "Please enter your plaintext (4 bytes): "
promptKey:		.asciiz "\nPlease enter your key (4 bytes): "
promptMode:		.asciiz "\nPlease enter cipher mode (e/d): "
outputPlaintext:	.asciiz "\nYou typed plaintext: "
outputKey:		.asciiz "\nYou typed key: "
outputMode:		.asciiz "\nYou typed mode: "