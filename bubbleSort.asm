.data
  arr1: .word 100, 12, -6, 8, 101
  arr1Length: .word 5
  
  newLine: .asciiz "\n"
  space: .asciiz " "
  beforeSort: .asciiz "Before sort: "
  afterSort: .asciiz "After sort: "
  
  

.text
.globl main

  #takes in as args: a0 is addy of array, a1 is length
  #returns nothing
  #t0 is i, $t1 is addy of array, $t2 is length
  printArray:
    move $t1, $a0
    move $t2, $a1
    li $t0, 0
    printArrayLoop:
      beq $t0, $t2, endPrintArrayLoop
      li $v0, 1 #print int
      lw $a0, 0($t1) 
      syscall
      li $v0, 4 #print space
      la $a0, space
      syscall
      addi $t1, $t1, 4   #incremetn
      addi $t0, $t0, 1  
      j printArrayLoop
    endPrintArrayLoop:
      jr $ra
      
  
#bubbleSort returns nothing, but leaves the array sorted
#as inputs, it has $a0 being the array, and $a1 being the length of array
bubbleSort:
    move $t2, $a1 #length of array
    li $t0, 0   # outer loop counter, aka "i"

bubbleLoop:
    sub $t6, $t2, $t0  #inner loop limit (n - i)
    addi $t6, $t6, -1  # inner loop runs until n-i-1
    blez $t6, endBubbleLoop  # if inner limit <= 0, end sorting

    li $t7, 0 #swapOccured flag is originally set to 0
    move $t1, $a0   # Reset array pointer each pass
    li $t5, 0   # Inner loop counter "j"

bubbleLoop2:
    beq $t5, $t6, endBubbleLoop2  # stop inner loop if j reaches limit

    lw $t3, 0($t1) #current element
    lw $t4, 4($t1) #next element

    ble $t3, $t4, endSwap  # if current >= next, no swap needed
    # Swap the elements
    sw $t4, 0($t1)    
    sw $t3, 4($t1)      
    li $t7, 1

endSwap:
    addi $t1, $t1, 4  # now next element (increment pointer)
    addi $t5, $t5, 1  # inc i (inner lloop)
    
    j bubbleLoop2     

endBubbleLoop2:
    beqz $t7, endBubbleLoop # no swaps occured so array must already be sorted
    addi $t0, $t0, 1   # inc j (outler loop)
    j bubbleLoop         

endBubbleLoop:
    jr $ra    

  
  
  
  
  main:
    #print before sort
    li $v0, 4
    la $a0, beforeSort
    syscall
    
    la $a0, arr1
    lw $a1, arr1Length
    jal printArray
    
    #bubble sort
    la $a0, arr1
    lw $a1, arr1Length
    jal bubbleSort
    
    
    #new line
    li $v0, 4
    la $a0, newLine
    syscall
    #print after sort
    li $v0, 4
    la $a0, afterSort
    syscall
    
    la $a0, arr1
    lw $a1, arr1Length
    jal printArray
    
    
    #end program
    li $v0, 10
    syscall
    
    
    
    
