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
	mflo $a0				# corresponda y sumar la contraparte
	add $a0, $a0, $t4		# Pimer resultado
	add $a0, $a0, $t1

	mult $t2, $s1			# Segundo resultado
	mflo $a1
	add $a1, $a1, $t4
	add $a1, $a1, $t0

end:
	sw $a0, out1			# Guardar ambos resultados
	sw $a1, out2
	li $v0, 10				# Salir
	syscall