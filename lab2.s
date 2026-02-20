.section .data 
STR1: .ascii "foo" #create first string
STR2: .ascii "bar" #create 2nd string
len1 = . - STR1  
len2 = . - STR2 

.section .bss
LENGTH: .word #length of loop
.globl ham #HAMMMMM
.lcomm ham, 32

.section .text
.globl hammer
hammer: 

#len two strings, but length of smaller into variable
    movw $len1, %AX #move length1 into AX
    cmpw $len2, %AX #Compare string lengths 
    je SWAP

    SWAP: 
        movw $len2, %AX #PUT smaller length into AX
        ret 


    movw %AX, %CX

    #proper length has been aquired (YAY) create loop with comparisons
    HAMLOOP: 
    #XOR each bit!
        xor STR1, STR2

        je incHAM
    #set up a counter
    dec %CX 


