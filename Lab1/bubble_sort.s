.data
msg1:	.asciiz "The array before sort : "
msg2:	.asciiz "\nThe array after sort : "
space:	.asciiz " "
line:	.asciiz "\n"
data: 	.word 5, 3, 6, 7, 31, 23, 43, 12, 45, 1

.text
.globl main

main:
# print msg1
	li $v0, 4		# system call: print string
	la $a0, msg1		# load address of string into $a0
	syscall			# run the system call
	
	la $s6, data		# load address of data into $s6
	move $s0, $zero		# $s0 is i in for loop, and set it into zero
	li $s1, 10		# $s1 is n in for loop, and set it into 10
	
# for loop
loop1:
	slt $t0, $s0, $s1	# if (i >= 10), $t0 = 0
	beq $t0, $zero, exit1	# if ($t0 = 0), go to exit1
	
	sll $t1, $s0, 2		# $t1 = i * 4
	add $t2, $s6, $t1	# $t2 = data + (i * 4)
	lw $t3, 0($t2)		# $t3 = data[i]
	
# print data[i]
	li $v0 1		# system call: print integer
	la $a0, 0($t3)		# load address of integer into $a0
	syscall			# run the system call

# print space	
	li $v0, 4		# system call: print string
	la $a0, space		# load address of string into $a0
	syscall			# run the system call
	
	addi $s0, $s0, 1	# i = i + 1
	j loop1			#jump to loop1
	
exit1:
#print \n
	li $v0, 4		# system call: print string
	la $a0, line		# load address of string into $a0
	syscall			# run the system call

#set param of bubble sort	
	la $a0, data		# load address of data into $a1
	move $a1, $s1		# $a1 is 10
	
	jal bubblesort
	
	move $a1, $a0		#$a1 = v which have been sorted
	
# print msg2
	li $v0, 4		# system call: print string
	la $a0, msg2		# load address of string into $a0
	syscall			# run the system call
	
	move $s0, $zero		# $s0 is i in for loop, and set it into zero
	li $s1, 10		# $s1 is n in for loop, and set it into 10

# for loop
loop2:
	slt $t0, $s0, $s1	# if $s0 >= $s1, $t0 = 0
	beq $t0, $zero, exit2	# if $t0 = 0, go to exit2
	
	sll $t1, $s0, 2		# $t1 = i * 4
	add $t2, $a1, $t1	# $t2 = data + (i * 4)
	lw $t3, 0($t2)		# $t3 = data[i]
	
# print data[i]
	li $v0 1		# system call: print integer
	la $a0, 0($t3)		# load address of integer into $a0
	syscall			# run the system call

# print space	
	li $v0, 4		# system call: print string
	la $a0, space		# load address of string into $a0
	syscall			# run the system call
	
	addi $s0, $s0, 1	# i = i + 1
	j loop2			# jump to loop2

exit2:
#print \n
	li $v0, 4		# system call: print string
	la $a0, line		# load address of string into $a0
	syscall			# run the system call
	
	li $v0, 10		# call system call: exit
  	syscall			# run the syscall	
	
	
.text
bubblesort:
	addi $sp, $sp, -20 	# make room on stack for 5 registers
	sw $ra, 16($sp)		# store $ra on stack
	sw $s3, 12($sp)		# store $s3 on stack
	sw $s2, 8($sp)		# store $s2 on stack
	sw $s1, 4($sp)		# store $s1 on stack
	sw $s0, 0($sp)		# store $s0 on stack
	
	move $s2, $a0		# $s2 = v
	move $s3, $a1		# $s3 = k
	move $s0, $zero		# i = 0
for1:
	slt $t0, $s0, $s3	# if (i >= k) $t0 = 0
	beq $t0, $zero, exitfor1	# if (i >= k) go to exitfor1
	addi $s1, $s0, -1	# j = i - 1
for2:
	slti $t0, $s1, 0	# if (j < 0) $t0 = 1
	bne $t0, $zero, exitfor2 	# if (j < 0) go to exit2
	
	sll $t1, $s1, 2		# $t1 = j * 4
	add $t2, $s2, $t1	# $t2 = v + j * 4
	lw $t3, 0($t2)		# $t3 = v[j]
	lw $t4, 4($t2)		# $t4 = v[j + 1]
	slt $t0, $t4, $t3	# if ($t4 >= $t3) $t0 = 0
	beq $t0, $zero, exitfor2	# if ($t4 >= $t3) go to exitfor2
	move $a0, $s2		# 1st param of swap is v
	move $a1, $s1		# 2nd param of swap is j
	jal swap
	addi $s1, $s1, -1	# j -= 1
	j for2			# jump to inner loop (for2)
exitfor2:
	addi $s0, $s0, 1	# i += 1
	j for1
exitfor1:
	lw $s0, 0($sp)		# restore $s0 from stack
	lw $s1, 4($sp)		# restore $s1 from stack
	lw $s2, 8($sp)		# restore $s2 from stack
	lw $s3, 12($sp)		# restore $s3 from stack
	lw $ra, 16($sp)		# restore $s4 from stack
	addi $sp, $sp, 20	# restore stack pointer
	jr $ra 			# return to caller
	
swap:
	sll $t1, $a1, 2		# $t1 = k * 4
	add $t1, $a0, $t1	# $t1 = v + k * 4
	lw $t0, 0($t1)		# $t0 = v[k]
	lw $t2, 4($t1) 		# $t2 = v[k + 1]
	sw $t2, 0($t1)		# v[k] = $t2
	sw $t0, 4($t1)		# v[k + 1] = $t0
	jr $ra			# return to caller
	
	
	

	
	
	
	
