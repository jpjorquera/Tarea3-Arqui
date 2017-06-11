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

# Funcion principal
rotor:
	addi $s0, $zero, 1		# Iterador
	addi $s1, $zero, 0x2	# Numero a multiplicar/dividir
	addi $s2, $zero, 0x2
	
potencia:
	beq $s0, $a2, extra		# Potencia de 0b10 segun
	mult $s1, $s2			# la cantidad
	addi $s0, 1
	mflo $s1
	j potencia

extra:
	div $a0, $s1			# Dividir por la potencia obtenida
	mflo $t0				# Guardando cuocientes y restos
	mfhi $t1
	div $a1, $s1
	mflo $t2
	mfhi $t3

	add $t4, $zero, $zero	# Constante para ajustar tamaño

	mult $t3, $s1			# Amplificar cuociente/restos segun
	mflo $s2				# corresponda y sumar la contraparte
	add $s2, $s2, $t4		# Pimer resultado
	add $s2, $s2, $t1

	mult $t2, $s1			# Segundo resultado
	mflo $s3
	add $s3, $s3, $t4
	add $s3, $s3, $t0

end:						# Retorno
	add $v0, $s2, $zero
	add $v1, $s3, $zero
	jr $ra