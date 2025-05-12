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
	
	# load address
	la $t0, plaintext	
	lb $t1, 0($t0)		# MSB
	lb $t2, 1($t0)
	lb $t3, 2($t0)
	lb $t4, 3($t0)		# LSB
	
	# save 32 bits plaintext in $s0
	sll $t1, $t1, 24
	sll $t2, $t2, 16
	sll $t3, $t3, 8
	or $t5, $t1, $t2
	or $t6, $t3, $t4
	or $s0, $t5, $t6	
	
	# separate plaintext to L, R
	srl $s1, $s0, 16	# upper 16 bits
	andi $s2, $s0, 0xFFFF	# lower 16 bits
	
	# load address of key string
	la $t0, key
	lb $t1, 0($t0)        # MSB
	lb $t2, 1($t0)
	lb $t3, 2($t0)
	lb $t4, 3($t0)        # LSB
	
	# save 32-bit key in $s3
	sll $t1, $t1, 24
	sll $t2, $t2, 16
	sll $t3, $t3, 8
	or $t5, $t1, $t2
	or $t6, $t3, $t4
	or $s3, $t5, $t6      # $s3 = 32-bit key

	# separate key to K1 (upper 16 bits), K2 (lower 16 bits)
	srl $s4, $s3, 16      # $s4 = K1
	andi $s5, $s3, 0xFFFF # $s5 = K2

	# program exit
	li $v0, 10
	syscall
	
# define F function
# F(R, K) = ((R xor K) <<< 3) & 0xFFFF
F_function:
	xor $t0, $a0, $a1    # R xor K
	sll $t1, $t0, 3
	srl $t2, $t0, 13
	or $t3, $t1, $t2     # rotation
	andi $v0, $t3, 0xFFFF
	jr $ra
	
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
