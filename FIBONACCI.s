.data
# INPUT
ENESIMO: .word 46

# PRINTS
RESULTADO: .asciiz "El término enésimo de la sucesión de Fibonacci es: "

.text
# MAIN
main:
	lw $a0, ENESIMO				# Guardar enesimo para comparar
	add $s0, $zero, $zero		# Alacenar primeros valores en s0 y s1
	addi $s1, $zero, 1
	beq $s0, $a0, PRIMERO 		# Casos bases
	beq $s1, $a0, SEGUNDO
	addi $t0, $zero, 1			# Iterador
	j LOOP

PRIMERO:
	add $a0, $s0, $zero			# Almacenar el termino correspondiente
	j EXIT

SEGUNDO:
	add $a0, $s1, $zero
	j EXIT

LOOP:
	addi $t0, $t0, 1			# Avanzar iterador
	add $t1, $s0, $s1			# Calcular siguiente
	add $s0, $s1, $zero			# Actualizar valores
	add $s1, $t1, $zero
	bne $t0, $a0, LOOP			# Si no ha terminado de iterar
	add $a0, $s1, $zero			# Si termino: guardar actual

EXIT:
	add $t0, $a0, $zero			# Auxiliar
	la $a0, RESULTADO			# Imprimir string
	li $v0, 4
	syscall
	add $a0, $t0, $zero			# Imprimir resultado
	li $v0, 1
	syscall
	li $v0, 10
	syscall