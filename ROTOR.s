.data
# INPUTS en Hexadecimal
reg1: .word 0xF0
reg2: .word 0xF0
cantidad: .word 4

# OUTPUTS
out1: .word 0
out2: .word 0

.text
# MAIN
main:
	lw $a0, reg1			# Cargar inputs
	lw $a1, reg2
	lw $a2, cantidad
	jal rotor				# Llamar funcion

	# Guardar en salida
	sw $v0, out1			# Guardar ambos resultados
	sw $v1, out2
	li $v0, 10				# Salir
	syscall

# Funciones para calcular el largo:
# largo, loop, actualizar
largo:
	addi $s1, $zero, 32		# Inicializar valores (max = 32 bits)
	addi $t0, $zero, 0x2
	add $s0, $a0, $zero

loop:
	addi $s1, $s1, -1		# Iterar hasta encontrar el ultimo 1
	div $s0, $t0
	mflo $s0
	mfhi $t1
	slt $t2, $zero, $t1
	bne $t2, $zero, actualizar	# Si se encuentra 1, actualizar
	beq $s1, $zero, volver		# Si se terminaron los bits
	j loop

actualizar:
	add $s2, $s1, $zero		# Guardar valor actual
	j loop

volver:						# Retornar valor obtenido
	add $t0, $zero, 32
	sub $v0, $t0, $s2
	jr $ra

# Funciones para calcular potencia:
# potencia, iterar, ret
potencia:
	addi $t0, $zero, 1		# Iterador
	addi $t1, $zero, 0x2	# Variable para calcular potencia
	addi $t2, $zero, 0x2	# Constante

iterar:
	beq $t0, $a3, ret		# Potencia de 0b10 segun
	mult $t1, $t2			# la cantidad
	addi $t0, $t0, 1
	mflo $t1
	j iterar 				# Loop

ret:
	add $v0, $t1, $zero		# Devolver resultado potencia
	jr $ra

# Funcion principal rotor:
# rotor, calculo, end
rotor:
	sw $ra, -4($sp)			# Guardar ra
	addi $sp, $sp, -4

	jal largo				# Calcular largo primera palabra
	add $s0, $v0, $zero

	sub $a3, $s0, $a2		# Calcular constante primera palabra
	jal potencia
	add $s1, $v0, $zero

	add $a3, $a2, $zero		# Calcular constante segunda palabra
	jal potencia
	add $s2, $v0, $zero

calculo:
	div $a0, $s1			# Dividir por la potencia obtenida
	mflo $t0				# Guardando cuocientes y restos
	mfhi $t1

	div $a1, $s2			# Dividir por segunda potencia
	mflo $t2
	mfhi $t3

	add $t4, $zero, $zero	# Constante para ajustar tamaño

	mult $t3, $s1			# Amplificar cuociente/restos segun
	mflo $s3				# corresponda y sumar la contraparte
	add $s3, $s3, $t4		# Pimer resultado
	add $s3, $s3, $t1

	mult $t2, $s2			# Segundo resultado
	mflo $s4
	add $s4, $s4, $t4
	add $s4, $s4, $t0

end:						# Retorno
	add $v0, $s3, $zero		# Guardar en retornos
	add $v1, $s4, $zero
	lw $ra, 0($sp)			# Devolver stack ra
	addi $sp, $sp, 4
	jr $ra
