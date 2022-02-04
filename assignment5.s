###########################################################
# Assignment #: 5
#  Name: Matthew Groholski
#  ASU email: mgrohols@asu.edu
#  Course: CSE/EEE230, TTh 3PM
#  Description: -write assembly language programs to: 
#            -perform decision making using branch instructions. 
#            -create loops 
#            -use syscall operations to display integers and strings on the console window 
#            -use syscall operations to read integers from the keyboard.
###########################################################

.data
#Storing messages
m1: .asciiz "Enter an integer:\n"
m2: .asciiz "Enter another integer:\n"
m3: .asciiz "Result Array Content:\n"
numbers: .word -4, 23, 15, -26, 27, 8, -21, 31, 15, -17, 11, -7
numbers_len: .word 12
newLine: .asciiz "\n"
.text
.globl main

main:
    #Prints prompt
    li $v0, 4
    la $a0, m1
    syscall

    #Gets input
    li $v0, 5
    syscall
    move $s0, $v0

    #Prints second prompt
    li $v0, 4
    la $a0, m2
    syscall

    #Gets second input
    li $v0, 5
    syscall
    move $s1, $v0

    #Makes i $s2 and stores 0
    lw $s2, numbers_len
    la $s3, numbers
    li $t0, 0
    li $s4, 3

    #begins change loop
    beginChange:
        bge $t0, $s2, endChange
            #loads to ith element of array into $t1
            sll $t1, $t0, 2
            add $t2, $t1, $s3
            lw $t3, 0($t2)
            #gets division
            div $t3, $s0
            mflo $t4
            #compares against 3
            bge $t4, $s4, increment
                #alters array element
                div $t3, $s1
                mfhi $t3
                sw $t3, 0($t2)
            increment:
            #adds 1 to i and restarts
            addi $t0, $t0, 1
            j beginChange
        endChange:
    
    #prints result array content
    li $v0, 4
    la $a0, m3
    syscall

    #sets $t0 back to 0
    li $t0, 0

    #starts print loop
    beginPrint:
        bge $t0, $s2, endPrint
            #prints out array[i]
            li $v0, 1
            sll $t1, $t0, 2
            add $t2, $t1, $s3
            lw $a0, 0($t2)
            syscall
            #prints newLine
            li $v0,4
            la $a0, newLine
            syscall
            #adds 1 to i and restarts
            addi $t0, $t0, 1
            j beginPrint
    endPrint:
    jr $ra

