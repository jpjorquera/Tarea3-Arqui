
.data
# INPUT
ENESIMO: .word 9

# OUTPUT
RESULTADO: .word 0

# PRINTS
STR: .asciiz "El factorial del n-ésimo término es : "
SALTO: .asciiz "\n"

.text
# MAIN
main:
	lw $a0, ENESIMO				# Guardar enesimo para comparar
	jal FACTORIAL 				# LLamar funcion

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
FACTORIAL:
	add  $s0, $zero, 1	# Alacenar primeros valores en s0
	beq $zero $a0, PRIMERO 		# Casos bases
	beq $a0, 1, SEGUNDO
	addi $t0, $zero, 1			# Iterador
	j LOOP

PRIMERO:
	add $a0, $s0, $zero			# Almacenar el termino correspondiente
	j EXIT

SEGUNDO:
	add $a0, $s0, $zero
	j EXIT

LOOP:
	addi $t0, $t0, 1			# Avanzar iterador
	mult $s0, $t0			# Segundo resultado
	mflo $s0

	bne $t0, $a0, LOOP			# Si no ha terminado de iterar
	
	add $v0, $zero, $s0		# Si termino: guardar actual

EXIT:							# Retornar
	jr $ra




