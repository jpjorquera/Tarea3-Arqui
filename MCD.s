.data
# OUTPUT
resultado: .word 0

# PRINTS
str_entrada1: .asciiz "Ingrese primer número para calcular MCD: "
str_entrada2: .asciiz "\nIngrese segundo número para calcular MCD: "
str: .asciiz "\nEl MCD de ambos numeros es: "
salto: .asciiz "\n"

.text
# MAIN
main:
	la $a0, str_entrada1		# Imprimir str primer numero
	li $v0, 4
	syscall
	li $v0, 5					# Guardar valor
	syscall						# en temporal
	add $t0, $v0, $zero
	la $a0, str_entrada2		# Imprimir str segundo numero
	li $v0, 4
	syscall
	li $v0, 5					# Guardar valor
	syscall
	add $a1, $v0, $zero			# Guardar ambos en entradas de funcion
	add $a0, $t0, $zero
	jal mcd 					# Llamar funcion

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

# Funcion principal
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