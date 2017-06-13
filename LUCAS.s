.data
# INPUT
ENESIMO: .word 4

# OUTPUT
RESULTADO: .word 0

# PRINTS
STR: .asciiz "El término enésimo de la sucesión de Fibonacci es: "
SALTO: .asciiz "\n"

.text
# MAIN
main:
	lw $a0, ENESIMO				# Guardar enesimo para comparar
	jal LUCAS 				# LLamar funcion

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
LUCAS:
	add  $s0, $zero, 2	# Alacenar primeros valores en s0 y s1
	addi $s1, $zero, 1
	beq $zero $a0, PRIMERO 		# Casos bases
	beq $a0, 1, SEGUNDO
	addi $t0, $zero, 1			# Iterador
	addi $s2, $zero, 3			#Sumatoria
	j LOOP

PRIMERO:
	add $a0, $s0, $zero			# Almacenar el termino correspondiente

	j EXIT

SEGUNDO:
	add $a0, $s1, $s0
	j EXIT

LOOP:
	addi $t0, $t0, 1			# Avanzar iterador
	add $t1, $s0, $zero			# Recordar el s0 actual
	add $s0, $s0, $s1			# Calcular siguiente
	add $t1, $s0, $zero			# Recordar el s0 actual
	add $s0, $s1, $zero			# Actualizar s0 con s1
	add $s1, $zero, $t1			# Mover t1 a s1 para recordar los ultimos 
	add $s2, $s2, $s1			# Aumentar la suma

	bne $t0, $a0, LOOP			# Si no ha terminado de iterar

	add $v0, $zero, $s2			# Si termino: guardar actual



EXIT:							# Retornar
	jr $ra



