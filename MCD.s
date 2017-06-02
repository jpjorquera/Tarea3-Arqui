main:
	addi $a0, $zero, 30000
	addi $a1, $zero, 30000
	slt $t0, $a0, $a1
	bne $t0, $zero, mcd

swap:					# Dejar menor en a0
	add $t0, $a0, $zero
	add $a0, $a1, $zero
	add $a1, $t0, $zero

mcd:
	div $a1, $a0
	mfhi $s0
	beq $s0, $zero, end
	add $a1, $a0, $zero
	add $a0, $s0, $zero
	j mcd

end:
	li $v0, 1
	syscall
	li $v0, 10
	syscall


