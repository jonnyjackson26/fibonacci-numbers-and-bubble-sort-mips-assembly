.data
  promptMessage: .asciiz "Please enter a positive integer: "
  newLine: .asciiz "\n"

.text

.globl main
main:
#print "please enter positive integer"
li $v0, 4
la $a0, promptMessage
syscall

#ask for integer
li $v0, 5
syscall

#move int to $t1 (
move $t0, $v0
#this is 'i', incrementer
li $t1, 2 #its originallly set to 2 to make up for the first 0 and 1

#$t2 will be our number second prioir (but it will start as 0)
li $t2, 0
#$t3 will be our number prioir (but it will start as 1)
li $t3, 1



inputIsOne:
  #print 0  
  li $v0, 1
  move $a0, $t2
  syscall
  #print newline
  li $v0, 4
  la $a0, newLine
  syscall
  #if t0 is greater than 1, go to input is two, else, go to else
  sgt $t5, $t0, 1
  beq $t5, 1, inputIsTwo
  j end
  
inputIsTwo:
  #print 1
  li $v0, 1
  move $a0, $t3
  syscall
  #print newline
  li $v0, 4
  la $a0, newLine
  syscall
  #if t0 is greater than 2, go to else, else, go to end
  sgt $t5, $t0, 2
  beq $t5, 1, else
  j end

else:

  loop:
    beq $t0, $t1, end
    #print prioir number +second prior number (t2+t3), which will be stored in $t4
    add $t4, $t2, $t3
    li $v0, 1
    move $a0, $t4
    syscall
    #print newline
    li $v0, 4
    la $a0, newLine
    syscall
    #increment $t1
    addi $t1, $t1, 1
    #set new prior numbers
    move $t2, $t3
    move $t3, $t4
  
    j loop

end:
#end program
li $v0, 10
syscall