########################################################################################################################
### data
########################################################################################################################
.data				 

# test 13 For the 32X32 frame and a 4X4 window size
# The result should be 5, 16 since its the first of multiple repeating occurences
asize13: .word    32, 32, 4, 4    #i, j, k, l
frame13: .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
		 .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
					
window13:   .word    10, 10, 10, 10, 
			.word    10, 10, 10, 10, 
			.word    10, 10, 10, 10, 
			.word    10, 10, 10, 10
		 
newline: .asciiz     "\n" 


########################################################################################################################
### main
########################################################################################################################

.text

.globl main

main: 
	#addi    $sp, $sp, -4    # Make space on stack
	#sw      $ra, 0($sp)     # Save return address	 

	# Start test 13
	############################################################
	la      $a0, asize13     # 1st parameter: address of asize13[0]
	la      $a1, frame13     # 2nd parameter: address of frame13[0]
	la      $a2, window13    # 3rd parameter: address of window13[0]   

	jal     vbsme           # call function
	jal     print_result    # print results to console
	############################################################
	# End of test 13  
	 
	#lw      $ra, 0($sp)         # Restore return address
	#addi    $sp, $sp, 4         # Restore stack pointer
	#jr      $ra                 # Return
	
here:
	j here

################### Print Result ####################################
print_result:
	# Printing $v0
	add     $a0, $v0, $zero     # Load $v0 for printing
	li      $v0, 1              # Load the system call numbers
	syscall
	 
	# Print newline.
	la      $a0, newline          # Load value for printing
	li      $v0, 4                # Load the system call numbers
	syscall
	 
	# Printing $v1
	add     $a0, $v1, $zero      # Load $v1 for printing
	li      $v0, 1                # Load the system call numbers
	syscall

	# Print newline.
	la      $a0, newline          # Load value for printing
	li      $v0, 4                # Load the system call numbers
	syscall
	 
	# Print newline.
	la      $a0, newline          # Load value for printing
	li      $v0, 4                # Load the system call numbers
	syscall
	 
	jr      $ra                   #function return

#####################################################################
### vbsme
#####################################################################


# vbsme.s 
# motion estimation is a routine in h.264 video codec that 
# takes about 80% of the execution time of the whole code
# given a frame(2d array, x and y dimensions can be any integer 
# between 16 and 64) where "frame data" is stored under "frame"  
# and a window (2d array of size 4x4, 4x8, 8x4, 8x8, 8x16, 16x8 or 16x16) 
# where "window data" is stored under "window" 
# and size of "window" and "frame" arrays are stored under "asize"

# - initially current sum of difference is set to a very large value
# - move "window" over the "frame" one cell at a time starting with location (0,0)
# - moves are based spiral pattern 
# - for each move, function calculates  the sum of absolute difference (SAD) 
#   between the window and the overlapping block on the frame.
# - if the calculated sum of difference is less than the current sum of difference
#   then the current sum of difference is updated and the coordinate of the top left corner 
#   for that matching block in the frame is recorded. 

# for example SAD of two 4x4 arrays "window" and "block" shown below is 3  
# window         block
# -------       --------
# 1 2 2 3       1 4 2 3  
# 0 0 3 2       0 0 3 2
# 0 0 0 0       0 0 0 0 
# 1 0 0 5       1 0 0 4

# program keeps track of the window position that results 
# with the minimum sum of absolute difference. 
# after scanning the whole frame
# program returns the coordinates of the block with the minimum SAD
# in $v0 (row) and $v1 (col) 


# Sample Inputs and Output shown below:
# Frame:
#
#  0   1   2   3   0   0   0   0   0   0   0   0   0   0   0   0 
#  1   2   3   4   4   5   6   7   8   9  10  11  12  13  14  15 
#  2   3  32   1   2   3  12  14  16  18  20  22  24  26  28  30 
#  3   4   1   2   3   4  18  21  24  27  30  33  36  39  42  45 
#  0   4   2   3   4   5  24  28  32  36  40  44  48  52  56  60 
#  0   5   3   4   5   6  30  35  40  45  50  55  60  65  70  75 
#  0   6  12  18  24  30  36  42  48  54  60  66  72  78  84  90 
#  0   7  14  21  28  35  42  49  56  63  70  77  84  91  98 105 
#  0   8  16  24  32  40  48  56  64  72  80  88  96 104 112 120 
#  0   9  18  27  36  45  54  63  72  81  90  99 108 117 126 135 
#  0  10  20  30  40  50  60  70  80  90 100 110 120 130 140 150 
#  0  11  22  33  44  55  66  77  88  99 110 121 132 143 154 165 
#  0  12  24  36  48  60  72  84  96 108 120 132   0   1   2   3 
#  0  13  26  39  52  65  78  91 104 117 130 143   1   2   3   4 
#  0  14  28  42  56  70  84  98 112 126 140 154   2   3   4   5 
#  0  15  30  45  60  75  90 105 120 135 150 165   3   4   5   6 

# Window:
#  0   1   2   3 
#  1   2   3   4 
#  2   3   4   5 
#  3   4   5   6 

# cord x = 12, cord y = 12 returned in $v0 and $v1 registers

.text
.globl  vbsme

# Your program must follow spiral pattern.  

# Preconditions:
#   1st parameter (a0) address of the first element of the dimension info (address of asize[0])
#   2nd parameter (a1) address of the first element of the frame array (address of frame[0][0])
#   3rd parameter (a2) address of the first element of the window array (address of window[0][0])
# Postconditions:	
#   result (v0) x coordinate of the block in the frame with the minimum SAD
#          (v1) y coordinate of the block in the frame with the minimum SAD

# test input
# asize : dimensions of the frame [i, j] and window [k, l]
#         i: number of rows,  j: number of cols
#         k: number of rows,  l: number of cols  
# frame : frame data with i*j number of pixel values
# window: search window with k*l number of pixel values
#

# $v0 is for minSADRow
# $v1 is for minSADCol
# $s0 is minSAD
# $s1 is currentSAD
# $s2 is rowMax = frameRowSize - windowRowSize
# $s3 is colMax = frameColSize - windowColSize
# $s4 is windowRowSize
# $s5 is windowColSize
# $s6 is tempSAD
# $s7 is 
# $t0 is currentSpiralRow
# $t1 is currentSpiralCol
# $t2 is value of window[row][col]
# $t3 is branch checks
# $t4 is for loop iterators of spiral
# $t5 is value of frame[row][col]
# $t6 is windowRowIterator
# $t7 is windowColIterator
# $t8 is row passed to checkForMinSAD
# $t9 is col passed to checkForMinSAD

# Begin subroutine
vbsme:  
	li $v0, 0							# reset $v0 
	li $v1, 0							# reset $v1

	# insert your code here
	li $s0, 2147483647		# Set minSAD to max int value
	li $s1, 0							# Set currentSAD to 0
	lw $s2, 0($a0)				# Set s2 to frame number of rows
	lw $s3, 4($a0)				# Set s3 to frame number of columns
	lw $s4, 8($a0)				# Set s4 to window number of rows
	lw $s5, 12($a0)				# Set s5 to window number of columns
	sub $s2, $s2, $s4			# Set s2 to rowMax = frameRowSize - windowRowSize
	addi $s2, $s2, 1			# Since we're including the max, +1
	sub $s3, $s3, $s5			# Set s3 to colMax = frameColSize - windowColSize
	addi $s3, $s3, 1			# Since we're including the max, +1
	li $t0, 0							# Set currentSpiralRow to 0
	li $t1, 0							# Set currentSpiralCol to 0

# Start while loop
spiral:
	slt $t3, $t0, $s2			# Check currentSpiralRow < rowMax
	beq $t3, $0, exitSpiral 	# If currentSpiralRow >= rowMax, exitSpiral
	slt $t3, $t1, $s3			# Check currentSpiralCol < colMax
	beq $t3, $0, exitSpiral 	# If currentSpiralCol >= colMax, exitSpiral

iterColRightStart:
	add $t4, $t1, $0			# Load currentSpiralCol into i

iterColRight:	
	slt $t3, $t4, $s3			# Check if iterator < colMax
	beq $t3, $0, iterColRightExit # If iterator >= colMax, exit loop
												# currently at array[currentSpiralRow][i]
	add $t8, $t0, $0			# Row for checkForMinSAD = currentSpiralRow
	add $t9, $t4, $0			# Col for checkForMinSAD = i
	sub $sp, $sp, 4				# Move the stack pointer to make space
	sw $ra, 0($sp)				# [stack[$sp]=$ra] Backup return address
	jal checkForMinSAD 		# checkForMinSAD at current location
	lw $ra, 0($sp)				# Restore the return address
	addi $sp, $sp, 4			# Restore the stack pointer
	addi $t4, $t4, 1			# i = i + 1
	j iterColRight 				# Loop again

iterColRightExit:
	addi $t0, $t0, 1			# currentSpiralRow++

iterRowDownStart:
	slt $t3, $t0, $s2			# Check if currentSpiralRow < rowMax
	beq $t3, $0, iterRowUpStart	# If currentSpiralRow >= rowMax, go to iterRowUpStart
	add $t4, $t0, 0				# Load currentSpiralRow into i

iterRowDown:
	slt $t3, $t4, $s2			# Check if iterator < rowMax
	beq $t3, $0, iterRowDownExit	# If iterator >= rowMax, exit loop
												# currently at array[i][colMax-1]
	add $t8, $t4, $0			# Row for checkForMinSAD = i
	addi $t9, $s3, -1			# Col for checkForMinSAD = colMax - 1
	sub $sp, $sp, 4				# Move the stack pointer to make space
	sw $ra, 0($sp)				# [stack[$sp]=$ra] Backup return address
	jal checkForMinSAD 			# checkForMinSAD at current location
	lw $ra, 0($sp)				# Restore the return address
	addi $sp, $sp, 4			# Restore the stack pointer
	addi $t4, $t4, 1			# i = i + 1
	j iterRowDown 				# Loop again

iterRowDownExit:
	addi $s3, $s3, -1			# colMax--

iterColLeftStart:
	slt $t3, $t0, $s2			# Check if currentSpiralRow < rowMax
	beq $t3, $0, iterRowUpStart	# If currentSpiralRow >= rowMax, go to iterRowUpStart
	add $t4, $s3, $0			# i = colMax
	addi $t4, $t4, -1			# i = colMax - 1
	addi $t1, $t1, -1			# this makes it not skip corners

iterColLeft:
	slt $t3, $t1, $t4			# Check if i >= currentSpiralCol
	beq $t3, $0, iterColLeftExit	# If currentSpiralCol < iterator, exit loop
												# currently at array[rowMax-1][i]
	addi $t8, $s2, -1			# Row for checkForMinSAD = rowMax - 1
	add $t9, $t4, $0			# Col for checkForMinSAD = i
	sub $sp, $sp, 4				# Move the stack pointer to make space
	sw $ra, 0($sp)				# [stack[$sp]=$ra] Backup return address
	jal checkForMinSAD 		# checkForMinSAD at current location
	lw $ra, 0($sp)				# Restore the return address
	addi $sp, $sp, 4			# Restore the stack pointer
	addi $t4, $t4, -1			# i = i - 1
	j iterColLeft 				# Loop again

iterColLeftExit:
	addi $t1, $t1, 1			# reset currentSpiralRow
	addi $s2, $s2, -1			# rowMax--

iterRowUpStart:
	slt $t3, $t1, $s3			# Check if currentSpiralCol < colMax
	beq $t3, $0, spiral		# If currentSpiralCol > colMax, go back to start of spiral loop
	add $t4, $s2, 0				# i = rowMax
	addi $t4, $t4, -1			# i = rowMax - 1
	addi $t0, $t0, -1			# this makes it not skip corners

iterRowUp:
	slt $t3, $t0, $t4			# i >= currentSpiralRow
	beq $t3, $0, iterRowUpExit	# If currentSpiralRow < iterator, exit loop
												# currently at array[i][l]
	add $t8, $t4, $0			# Row for checkForMinSAD = i
	add $t9, $t1, $0			# Col for checkForMinSAD = currentSpiralCol
	sub $sp, $sp, 4				# Move the stack pointer to make space
	sw $ra, 0($sp)				# [stack[$sp]=$ra] Backup return address
	jal checkForMinSAD 		# checkForMinSAD at current location
	lw $ra, 0($sp)				# Restore the return address
	addi $sp, $sp, 4			# Restore the stack pointer
	addi $t4, $t4, -1			# i = i - 1
	j iterRowUp 					# Loop again

iterRowUpExit:
	addi $t0, $t0, 1			# reset currentSpiralRow
	addi $t1, $t1, 1			# currentSpiralCol++
	j spiral 							# Jump back to start of spiral loop

exitSpiral:
	jr $ra 								# finished spiral, exit function

# $v0 is for minSADRow
# $v1 is for minSADCol
# $s0 is minSAD
# $s1 is currentSAD
# $s2 is rowMax = frameRowSize - windowRowSize
# $s3 is colMax = frameColSize - windowColSize
# $s4 is windowRowSize
# $s5 is windowColSize
# $s6 is tempSAD
# $s7 is 
# $t0 is currentSpiralRow
# $t1 is currentSpiralCol
# $t2 is value of window[row][col]
# $t3 is branch checks
# $t4 is for loop iterators of spiral
# $t5 is value of frame[row][col]
# $t6 is windowRowIterator
# $t7 is windowColIterator
# $t8 is row passed to checkForMinSAD
# $t9 is col passed to checkForMinSAD

# Checks the current position to see if SAD < minSAD. If yes, replace the variables
checkForMinSAD:
	li $s1, 0							# Set currentSAD to 0
	li $t6, 0							# Set windowRowIterator to 0
	li $t7, 0							# Set windowColIterator to 0

loopRowSAD:
	sub $sp, $sp, 4 			# Make space for ra 
	sw $ra, 0($sp) 				# Store ra
	jal loopColSAD 				# goes to column loop for the row
	lw $ra, 0($sp) 				# restore ra
	addi $sp, $sp, 4			# restore sp

	sub $t9, $t9, $s5 		# sets frame column pos to beginning 
	addi $t7, $0, 0 			# sets window column to 0

	addi $t8, $t8, 1			# i = i + 1 : iterate frameRow
	addi $t6, $t6, 1			# k = k + 1 : windowRowIterator will increment
	bne $t6, $s4, loopRowSAD	# repeat the loop if windowRowIterator != windowRowSize 

	slt $t3, $s1, $s0 		# check if currentSAD < minSAD 
	beq $t3, $0, exitCalcSAD 	# if currentSAD < minSad, store values, else exit SAD calculation
	add $v0, $t8, $0  		# store xPos
	sub $v0, $v0, $s4			# reset xPos to not be offset by windowRowSize
	add $v1, $t9, $0  		# store yPos 
	add $s0, $s1, $0			# store currentSAD to be lowestSAD
	j exitCalcSAD					# return to spiral loops

loopColSAD: 						# loop counting col position on frame (j), t9
	sub $sp, $sp, 4				# Make space on stack
	sw $ra, 0($sp) 				# store ra
	jal checkForDifference	# goes to check whether values are different
	lw $ra, 0($sp)				# restore ra
	addi $sp, $sp, 4			# restore sp
		
	addi $t9, $t9, 1 			# j = j + 1 : frameCol will increment
	addi $t7, $t7, 1 			# l = l + 1 : windowCol will increment
	bne $t7, $s5, loopColSAD 	# repeats loop if windowCol != windowColSize
	j $ra 								# return to lowRowSAD
	
checkForDifference: 		# checks for difference between frame and window
	lw $t5, 4($a0)				# Load frame # of columns into t5
	mult $t8, $t5					# Multiply passed row * # of columns
	mflo $t5							# Load result into t5
	add $t5, $t5, $t9			# addressOffset(t5) = t5 + t9
	sll $t5, $t5, 2 			# addressOffset = 4 * addressOffset
	add $t5, $t5, $a1 		# address of frame[i][j] = arrayAddress + addressOffset
	lw $t5, 0($t5) 				# t5 = value of frame[i][j]

	mult $t6, $s5 				# Multiply windowColSize by windowRowIterator
	mflo $t2							# Load the result into t2
	add $t2, $t2, $t7			# windowAddressOffset = rowAddress + windowColIterator
	sll $t2, $t2, 2 			# windowAddressOffset = 4 * windowAddressOffset
	add $t2, $t2, $a2 		# address of window[k][l] = windowAddress + windowAddressOffset
	lw $t2, 0($t2) 				# t2 = value of window[k][l]

	bne $t5, $t2, calculateSAD # if window[k][l] != frameSize[i][j], SAD will be calculated
	j $ra 								# return to loopColSad

calculateSAD:
	sub $s6, $t5, $t2 		# tempSAD = frame[i][j] - window[k][l]
	slt $t3, $s6, $0 			# if tempSAD is < 0 (negative)
	bne $t3, $0, calculateSADNegative # If negative, abs(tempSAD)
	add $s1, $s1, $s6 		# currentSad = currentSad + tempSAD;
	j $ra

calculateSADNegative:
	sub $s6, $t2, $t5 		# tempSAD = window[k][l] - frame[i][j]
	add $s1, $s1, $s6 		# currentSad = currentSad + tempSAD;
	j $ra 								# return to the SAD loop

exitCalcSAD:
	jr $ra 								# return to the spiral loop

# asize : dimensions of the frame [i, j] and window [k, l]
#         i: number of rows,  j: number of cols
#         k: number of rows,  l: number of cols 