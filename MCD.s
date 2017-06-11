.data
# INPUTS de 32 bits
num1: .word 2366
num2: .word 273

# OUTPUT
resultado: .word 0

# PRINTS
str: .asciiz "El MCD de ambos numeros es: "
salto: .asciiz "\n"

.text
# MAIN
main:
	lw $a0, num1			# Guardar valores
	lw $a1, num2
	jal mcd
	
	# Imprimir valor
	add $t0, $v0, $zero			# Aux
	la $a0, str					# Imprimir string
	li $v0, 4
	syscall
	add $a0, $t0, $zero			# Imprimir resultado
	sw $a0, resultado			# Guardar resultado
	li $v0, 1
	syscall
	la $a0, salto				# Imprimir salto
	li $v0, 4
	syscall
	li $v0, 10					# Salir
	syscall



mcd:
	add $s0, $a0, $zero			# Guardar valores
	add $s1, $a1, $zero
	slt $t0, $s0, $s1			# Verificar menor
	bne $t0, $zero, calculo 	# Saltar a mcd

swap:						# Dejar menor en s0
	add $t0, $s0, $zero
	add $s0, $s1, $zero
	add $s1, $t0, $zero

calculo:
	div $s1, $s0			# Dividir por el menor
	mfhi $t0				# Guardar resto
	beq $t0, $zero, end		# Verificar comun divisor
	add $s1, $s0, $zero		# Actualizar valores siguientes
	add $s0, $t0, $zero
	j calculo

end:						# Retornar
	add $v0, $s0, $zero
	jr $ra