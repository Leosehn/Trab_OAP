.data
	titulo: .asciiz "Programa de Raiz Quadrada - Newton-Raphson\n"
	nomes: .asciiz "Desenvolvedores: Gabriel Ferri Schneider e Leonardo Francisco Sehnem dos Santos\n"
	digite: .asciiz "Digite os parâmetros x e i para calcular sqrt_nr (x, i) ou -1 para abortar a execução\n"
	resp1: .asciiz "sqrt("
	resp2: .asciiz ", "
	resp3:.asciiz ") = "
	resp4: .asciiz "\n"
	resp_POR_FAVOR_NAO_USAR: .asciiz "sqrt(x, y) = r"
	
.text
	.globl main
	
.macro resposta(%x, %i, %r)	# usa $a0 e $v0 (mas restaura depois) e $t0, $t1 e $t2 para imprimir a resposta
	
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $v0, 4($sp)
	move $t0, %x
	move $t1, %i
	move $t2, %r
	la $a0, resp1
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, resp2
	li $v0, 4
	syscall
	move $a0, $t1
	li $v0, 1
	syscall
	la $a0, resp3
	li $v0, 4
	syscall
	move $a0, $t2
	li $v0, 1
	syscall
	la $a0, resp4
	li $v0, 4
	syscall
	lw $a0, 0($sp)
	lw $v0, 4($sp)
	addi $sp, $sp, 8
	
.end_macro

main:
	li $v0, 4
	la $a0, titulo
	syscall
	la $a0, nomes
	syscall
	
loop:
	li $v0, 4
	la $a0, digite
	syscall
	la $v0, 5
	syscall
	move $a0, $v0
	bltz $a0, end
	la $v0, 5
	syscall
	move $a1, $v0
	bltz $a1, end
	jal calculo_inicio
	resposta($a0, $a1, $v0)
	j loop
end:
	li $v0, 10
	syscall

calculo_inicio:
	li $v0, 0		# resposta = 0
	move $t0, $a1		# $t0 <- y
calculo_loop:
	beqz $t0, volta		# if (y == 0) return
	addi $sp, $sp, -8	
	sw $ra, 4($sp)
	sw $t0, 0($sp)		# salva o $ra e y na pilha
	addi $t0, $t0, -1	# y--
	jal calculo_loop
	
volta:
	lw $t0, 0($sp)		# breakpoint
	lw $ra, 4($sp)
	beqz $v0, ajuste_primeira
	move $t2, $v0
pos_ajuste:
	addi $sp, $sp, 8
	divu $a0, $t2
	mflo $t1
	add $v0, $t2, $t1
	sra $v0, $v0, 1
	jr $ra
	
ajuste_primeira:
	move $t2, $a0
	j pos_ajuste