.data
# INPUTS de 32 bits
num1: .word 2366
num2: .word 273

# PRINTS
result: .asciiz "El MCD de ambos numeros es: "

.text
# MAIN
main:
	lw $a0, num1			# Guardar valores
	lw $a1, num2
	slt $t0, $a0, $a1		# Verificar menor
	bne $t0, $zero, mcd 	# Saltar a mcd

swap:						# Dejar menor en a0
	add $t0, $a0, $zero
	add $a0, $a1, $zero
	add $a1, $t0, $zero

mcd:
	div $a1, $a0			# Dividir por el menor
	mfhi $s0				# Guardar resto
	beq $s0, $zero, end		# Verificar comun divisor
	add $a1, $a0, $zero		# Actualizar valores siguientes
	add $a0, $s0, $zero
	j mcd

end:
	add $t0, $a0, $zero			# Auxiliar
	la $a0, result				# Imprimir string
	li $v0, 4
	syscall
	add $a0, $t0, $zero			# Imprimir resultado
	li $v0, 1
	syscall
	li $v0, 10
	syscall


