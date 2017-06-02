.data
ENESIMO: .word 46

.text
main:
	lw $a0, ENESIMO			# Muere en el 47
	add $s0, $zero, $zero
	addi $s1, $zero, 1
	beq $s0, $a0, PRIMERO
	beq $s1, $a0, SEGUNDO
	addi $t0, $zero, 1
	j LOOP

PRIMERO:
	add $a0, $s0, $zero
	j EXIT

SEGUNDO:
	add $a0, $s1, $zero
	j EXIT

LOOP:
	addi $t0, $t0, 1
	add $t1, $s0, $s1
	add $s0, $s1, $zero
	add $s1, $t1, $zero
	bne $t0, $a0, LOOP
	add $a0, $s1, $zero
	j EXIT

EXIT:
	li $v0, 1
	syscall
	li $v0, 10
	syscall