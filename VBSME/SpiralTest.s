#  Team Members:   Kinsleigh Wong , Zahra Sadeq
#  % Effort    :   70 - 30
#
# ECE369A,  
# 

########################################################################################################################
### data
########################################################################################################################
.data
# test input
# asize : dimensions of the frame [i, j] and window [k, l]
#         i: number of rows,  j: number of cols
#         k: number of rows,  l: number of cols  
# frame : frame data with i*j number of pixel values
# window: search window with k*l number of pixel values
#
# $v0 is for row / $v1 is for column

# test 0 For the 16X16 frame size and 4X4 window size
# The result should be 12, 12
asize0:  .word    16, 16, 4, 4    #i, j, k, l
frame0:  .word    0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
         .word    1, 2, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 
         .word    2, 3, 32, 1, 2, 3, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 
         .word    3, 4, 1, 2, 3, 4, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 
         .word    0, 4, 2, 3, 4, 5, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 
         .word    0, 5, 3, 4, 5, 6, 30, 35, 40, 45, 50, 55, 60, 65, 70,  75, 
         .word    0, 6, 12, 18, 24, 30, 36, 42, 48, 54, 60, 66, 72, 78, 84, 90, 
         .word    0, 4, 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105, 
         .word    0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 
         .word    0, 9, 18, 27, 36, 45, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135, 
         .word    0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 
         .word    0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165, 
         .word    0, 12, 24, 36, 48, 60, 72, 84, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    0, 13, 26, 39, 52, 65, 78, 91, 104, 114, 130, 143, 1, 2, 3, 4, 
         .word    0, 14, 28, 42, 56, 70, 84, 98, 112, 126, 140, 154, 2, 3, 4, 5, 
         .word    0, 15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 3, 4, 5, 6 
window0: .word    0, 1, 2, 3, 
         .word    1, 2, 3, 4, 
         .word    2, 3, 4, 5, 
         .word    3, 4, 5, 6 


########################################################################################################################
### main
########################################################################################################################

.text

.globl main

main: 
         
    # Start test 1 
    ############################################################
    la      $a0, asize0     # 1st parameter: address of asize1[0]
    la      $a1, frame0     # 2nd parameter: address of frame1[0]
    la      $a2, window0    # 3rd parameter: address of window1[0] 

    li      $v0, 0              # reset $v0 and $V1
    li      $v1, 0

    # insert your code here
	lw $t9, 0($a0) #So we get the # of rows for the frame.	
	lw $s2, 8($a0) #We get the number of rows for the window.	
	addi $t0, $t9, 1 
	sub $t0, $t0, $s2 #We calculate the value for how many times we iterate row-wise.	
	lw $s0, 4($a0) #Now, we get the # of cols for the frame. Also, s0 is used because we need this value. 
	lw $s3, 12($a0) #We get the # of cols for the window.
	addi $t1, $s0, 1 # y = FRAME_Y + 1
	sub $t1, $t1, $s3 #We calculate the value for how many times we iterate -wise. 	y
	add $t2, $zero, $zero #This is potato
	add $t3, $zero, $zero #$t3 and $t4 will represent our iterators.
	add $t4, $zero, $zero 
		#initialize s4 here
	addi $s4, $zero, 32767
	addi $s4, $s4, 32513
	slt $t9, $t1, $t0
	bne $t9, $zero, repeat2
	repeat1:
		add $t5, $t3, $t1
		horizontalright:
			add $t6, $t2, $t3
			sll $t6, $t6, 2
			addi $sp, $sp, -4
			sw $ra, 0($sp)
			jal sad
			lw $ra, 0($sp)
			addi $sp, $sp, 4
			addi $t3, $t3, 1
			bne $t3, $t5, horizontalright
		addi $t1, $t1, -1
		addi $t3, $t3, -1
		add $t5, $t4, $t0
		addi $t0, $t0, -1
		beq $t0, $zero, pete
		addi $t4, $t4, 1
		verticaldown:
			add $t2, $t2, $s0
			add $t6, $t2, $t3
			sll $t6, $t6, 2
			addi $sp, $sp, -4
			sw $ra, 0($sp)
			jal sad
			lw $ra, 0($sp)
			addi $sp, $sp, 4
			addi $t4, $t4, 1
			bne $t4, $t5, verticaldown
		addi $t4, $t4, -1
		addi $t3, $t3, -1
		sub $t5, $t3, $t1
		horizontalleft:
			add $t6, $t2, $t3
			sll $t6, $t6, 2
			addi $sp, $sp, -4
			sw $ra, 0($sp)
			jal sad
			lw $ra, 0($sp)
			addi $sp, $sp, 4
			addi $t3, $t3, -1
			bne $t3, $t5, horizontalleft
		addi $t3, $t3, 1
		addi $t1, $t1, -1
		sub $t5, $t4, $t0 
		addi $t0, $t0, -1
		beq $t0, $zero, pete
		addi $t4, $t4, -1
		verticalup:
			sub $t2, $t2, $s0
			add $t6, $t2, $t3
			sll $t6, $t6, 2
			addi $sp, $sp, -4
			sw $ra, 0($sp)
			jal sad
			lw $ra, 0($sp)
			addi $sp, $sp, 4
			addi $t4, $t4, -1
			bne $t4, $t5, verticalup
		addi $t3, $t3, 1
		addi $t4, $t4, 1	
		j repeat1
	repeat2:
		add $t5, $t3, $t1
		horizontalright2:
			add $t6, $t2, $t3
			sll $t6, $t6, 2
			addi $sp, $sp, -4
			sw $ra, 0($sp)
			jal sad
			lw $ra, 0($sp)
			addi $sp, $sp, 4
			addi $t3, $t3, 1
			bne $t3, $t5, horizontalright2
		addi $t1, $t1, -1
		addi $t3, $t3, -1
		add $t5, $t4, $t0
		addi $t0, $t0, -1
		addi $t4, $t4, 1
		verticaldown2:
			add $t2, $t2, $s0
			add $t6, $t2, $t3
			sll $t6, $t6, 2
			addi $sp, $sp, -4
			sw $ra, 0($sp)
			jal sad
			lw $ra, 0($sp)
			addi $sp, $sp, 4
			addi $t4, $t4, 1
			bne $t4, $t5, verticaldown2
		beq $t1, $zero, pete
		addi $t4, $t4, -1
		addi $t3, $t3, -1
		sub $t5, $t3, $t1
		horizontalleft2:
			add $t6, $t2, $t3
			sll $t6, $t6, 2
			addi $sp, $sp, -4
			sw $ra, 0($sp)
			jal sad
			lw $ra, 0($sp)
			addi $sp, $sp, 4
			addi $t3, $t3, -1
			bne $t3, $t5, horizontalleft2
		addi $t3, $t3, 1
		addi $t1, $t1, -1
		sub $t5, $t4, $t0 
		addi $t0, $t0, -1
		addi $t4, $t4, -1
		verticalup2:
			sub $t2, $t2, $s0
			add $t6, $t2, $t3
			sll $t6, $t6, 2
			addi $sp, $sp, -4
			sw $ra, 0($sp)
			jal sad
			lw $ra, 0($sp)
			addi $sp, $sp, 4
			addi $t4, $t4, -1
			bne $t4, $t5, verticalup2
		beq $t1, $zero, pete
		addi $t3, $t3, 1
		addi $t4, $t4, 1	
		j repeat2
		pete: #end of program
			j pete

	sad:
		addi $sp, $sp, -4
		sw $s4, 0($sp)
		add $s4, $a1, $t6 #Holding the location of the frame
		add $s5, $a2, $zero #holding the location of the window
		add $s6, $s3, $zero #s6 will hold the difference between two elements
		add $s7, $zero, $zero #s7 will hold the current sum
		add $s1, $zero, $zero #This variable will be used to move the frame to the next row.
		add $t7, $zero, $zero 
		loop1:
			add $t8, $zero, $zero #t8 is used to iterate through the columns of a row. 
			loop2:	
				lw $t9, 0($s4)
				addi $s4, $s4, 4
				add $s6, $t9, $zero
				lw $t9, 0($s5)
				addi $s5, $s5, 4 
				sub $s6, $s6, $t9
				#do absolute value thing here. Allowed to use pseudo-instruction abs?
				#abs $s6, $s6
				sra $t9, $s6, 31
				xor $s6, $s6, $t9
				sub $s6, $s6, $t9
				add $s7, $s7, $s6
				addi $t8, $t8, 1
				bne $t8, $s3, loop2
			addi $t7, $t7, 1
			beq $t7, $s2, donezo
			add $s1, $s1, $s0
			sll $t9, $s1, 2
			add $t9, $t9, $t6
			add $s4, $t9, $a1 
			j loop1
		donezo:
			lw $s4, 0($sp)
			addi $sp, $sp, 4
			slt $t9, $s7, $s4
			bne $t9, $zero, change
			jr $ra
		change:
			add $v0, $t4, $zero
			add $v1, $t3, $zero
			add $s4, $s7, $zero
			jr $ra
		