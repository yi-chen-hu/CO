.data
msg1:	.asciiz "Please input i : "
msg2:	.asciiz "th Fibonacci numbers is "
line:	.asciiz ".\n"

.text
.globl main

main:
# print msg1 on the console interface
		li      $v0, 4		# call system call: print string
		la      $a0, msg1	# load address of string into $a0
		syscall                 # run the syscall
 
# read the input integer in $v0
 		li      $v0, 5          # call system call: read integer
  		syscall                 # run the syscall
  		
  		move    $a1, $v0        # store input n in $a1 (set argument of procedure fibonacci)

# print n
		li	$v0, 1		# call system call: print integer
		la	$a0, 0($a1)	# load address of  n in to $a0
		syscall			# run syscall
		
# print msg2
		li 	$v0, 4		# call system call: print string
		la	$a0, msg2	# load address of string into $a0
		syscall			# run syscall
  		
  		jal fibonacci
 
# print the result of fibonacci(n)
		move 	$a0, $v0	# store the result of fibonacci(n) into $a0
		li	$v0, 1		# call system call: print integer
		syscall			# run syscall
		
# print line
		li	$v0, 4		# call system call: print string
		la 	$a0, line	# load address of string into $a0
		syscall			# run syscall
		
		li	$v0, 10		# call system call: exit
		syscall			# run syscall
  		
 .text
fibonacci:
		beq $a1, $zero, exit1	# if (n = 0) go to exit1
		li $t0, 1		# $t0 = 1
		beq $a1, $t0, exit2	# if (n = 1) go to exit2
		
# initialize parameters		
		move $s0, $zero		# a = 0
		li $s1, 1		# b = 1
		li $s2, 1		# c = 1
		li $s3, 2		# i = 2
for:
		slt $t0, $a1, $s3	# if (k < i) $t0 = 1
		bne $t0, $zero, exit3	# if (k < i) go to exit3
		add $s2, $s0, $s1	# c = a + b
		move $s0, $s1		# a = b
		move $s1, $s2		# b = c
		addi $s3, $s3, 1	# i += 1
		j for
exit1:
		move $v0, $zero		# return 0
		jr $ra			# return to caller

exit2:
		li $v0, 1		# return 1
		jr $ra			# return to caller
exit3:
		move $v0, $s2		# return c
		jr $ra			# return to caller
		 	
	
