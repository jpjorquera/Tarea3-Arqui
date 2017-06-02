main:
	addi $a0, $zero, 15
	addi $a1, $zero, 10
	slt $t0, $a0, $a1
	beq $a0, $a1, end
	bne $t0, $zero, mitad

swap:
	add $t0, $a0, $zero
	add $a0, $a1, $zero
	add $a1, $t0, $zero

mitad:
	add $s0, $a0, $zero
	addi $t0, $zero, 2
	div $s0, $t0
	mfhi $t0
	mflo $s0
	bne $t0, $zero, impar
	j mcd1

impar:
	addi $s0, $s0, 1

mcd1:
	div $a0, $s0
	mfhi $t0
	mflo $s1
	beq $t0, $zero, mcd2
	addi $s0, $s0, -1
	j mcd1

mcd2:
	div $a1, $s0
	mfhi $t0
	mflo $s1
	beq $t0, $zero, save
	addi $s0, $s0, -1
	j mcd1

save:
	add $a0, $s0, $zero

end:
	addi $v0, $zero, 1
	syscall
	addi $v0, $zero, 10
	syscall


