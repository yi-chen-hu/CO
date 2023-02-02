.data
msg1:	.asciiz "Please input i : "
msg2:	.asciiz "th Fibonacci numbers is "
line:	.asciiz ".\n"

.text
.globl main

main:
# print msg1
		li      $v0, 4		# call system call: print string
		la      $a0, msg1	# load address of string into $a0
		syscall                 # run the syscall
 
# read the input integer in $v0
 		li      $v0, 5          # call system call: read integer
  		syscall                 # run the syscall
  		
  		move    $t0, $v0        # store input n in $t0

# print n
		li	$v0, 1		# call system call: print integer
		la	$a0, 0($t0)	# load address of  n into $a0
		syscall			# run syscall
		
# print msg2
		li 	$v0, 4		# call system call: print string
		la	$a0, msg2	# load address of string into $a0
		syscall			# run syscall
  		
  		move 	$a0, $t0	# set argument of procedure fibonacci
  		jal 	fibonacci	# do fibonacci(n)
 		move 	$a0, $v0	# store the returned value of fibonacci in $a0
 		
# print the result of fibonacci(n)
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
 		addi	$sp, $sp, -8	# adjust stack for 2 items
 		sw	$ra, 4($sp)	# save return address
 		sw	$a0, 0($sp)	# save the argument k
 		
 		beq	$a0, $zero, exit1	# if (k = 0) go to exit1
 		li	$t0, 1		# $t0 = 1
 		beq	$a0, $t0, exit2 # if (k = 1) go to exit2
 		
 		addi 	$a0, $a0, -1	# k --
 		jal 	fibonacci	# do fibonacci(k - 1)
 		move 	$t1, $v0	# store the returned value of fibonacci(k - 1) in $t1
 		
 		addi	$sp, $sp, -4	# adjust stack for 1 item
 		sw 	$t1, 0($sp)	# save the returned value of fibonacci(k - 1)
 		
 		addi	$a0, $a0, -1	# k--
 		jal	fibonacci	# do finbonacci(k - 2)
 	
 		lw 	$t1, 0($sp)	# restore $t1 from stack
 		addi 	$sp, $sp, 4	# restore stack pointer
 		
 		add	$v0, $t1, $v0	# $v0 = fibonacci(k - 1) + fibonacci(k - 2)
 		
 		lw	$a0, 0($sp)	# restore $a0 from stack
 		lw 	$ra, 4($sp)	# restore $ra from stack
 		addi 	$sp, $sp, 8	# restore stack pointer
 		jr 	$ra		# return address
 		
 exit1:
 		move	$v0, $zero, 	# result = 0
 		lw	$a0, 0($sp)	# restore $a0 from stack
 		lw 	$ra, 4($sp)	# restore $ra from stack
 		addi 	$sp, $sp, 8	# restore stack pointer
 		jr 	$ra		# return address
 		
 exit2:
 		addi	$v0, $zero, 1	# result = 1
 		lw	$a0, 0($sp)	# restore $a0 from stack
 		lw 	$ra, 4($sp)	# restore $ra from stack
 		addi 	$sp, $sp, 8	# restore stack pointer
 		jr 	$ra		# return address
 		
 		
 	