main:
	addi $a0, $zero, 0xB2
	addi $a1, $zero, 0x03
	addi $a2, $zero, 4

	addi $s0, $zero, 1
	addi $s1, $zero, 0x2
	addi $s2, $zero, 0x2
	
potencia:
	beq $s0, $a2, extra
	mult $s1, $s2
	addi $s0, 1
	mflo $s1
	j potencia

extra:
	div $a0, $s1
	mflo $t0
	mfhi $t1
	div $a1, $s1
	mflo $t2
	mfhi $t3

	addi $t4, $zero, 0x00

	mult $t3, $s1
	mflo $a0
	add $a0, $a0, $t4
	add $a0, $a0, $t1

	mult $t2, $s1
	mflo $a1
	add $a1, $a1, $t4
	add $a1, $a1, $t0

end:
	li $v0, 1
	syscall
	add $a0, $a1, $zero
	syscall
	li $v0, 10
	syscall