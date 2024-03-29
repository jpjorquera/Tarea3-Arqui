.data
# OUTPUT
RESULTADO: .word 0

# PRINTS
STR_ENTRADA: .asciiz "Ingrese el enésimo que desea calcular: "
STR: .asciiz "\nEl término enésimo de la sucesión de Fibonacci es: "
SALTO: .asciiz "\n"

.text
# MAIN
main:
	la $a0, STR_ENTRADA			# Imprimir entrada
	li $v0, 4
	syscall
	li $v0, 5					# Guardar valor
	syscall
	add $a0, $v0, $zero			# Pasar a input de funcion
	jal FIBONACCI 				# Llamar funcion

	# Imprimir valor
	add $t0, $v0, $zero			# Auxiliar
	la $a0, STR					# Imprimir string
	li $v0, 4
	syscall
	add $a0, $t0, $zero			# Imprimir resultado
	sw $a0, RESULTADO			# Guardar resultado
	li $v0, 1
	syscall
	la $a0, SALTO				# Imprimir salto
	li $v0, 4
	syscall
	li $v0, 10					# Salir
	syscall

# Funcion principal
FIBONACCI:
	add $s0, $zero, $zero		# Alacenar primeros valores en s0 y s1
	addi $s1, $zero, 1
	beq $s0, $a0, PRIMERO 		# Casos bases
	beq $s1, $a0, SEGUNDO
	addi $t0, $zero, 1			# Iterador
	j LOOP

PRIMERO:
	add $v0, $s0, $zero			# Almacenar el termino correspondiente
	j EXIT

SEGUNDO:
	add $v0, $s1, $zero
	j EXIT

LOOP:
	addi $t0, $t0, 1			# Avanzar iterador
	add $t1, $s0, $s1			# Calcular siguiente
	add $s0, $s1, $zero			# Actualizar valores
	add $s1, $t1, $zero
	bne $t0, $a0, LOOP			# Si no ha terminado de iterar
	add $v0, $s1, $zero			# Si termino: guardar actual

EXIT:							# Retornar
	jr $ra