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
    #Assign HAM to %EBX
    mov $0x50, %esi #make 0x50 an index value
    lea ham, %rdi #say ram is rdi

    #Store strings (USE LEA)
    mov $STR1, %ebx
    mov $STR2, %edx


#len two strings, but length of smaller into variable

    movw $len1, %AX #move length1 into AX
    cmpw $len2, %AX #Compare string lengths 
    je SWAP
    
    
    movw $0, %CX #initialize counter
    mov $0, %ch #HAM counter 

    #proper length has been aquired (YAY) create loop with comparisons
    HAMLOOP: 
    #XOR each bit!
        movb (%ebx), %ah #move first bit into ah
        movb (%edx), %al 
        xorb %ah, %al #XORRRRR



        #je incHAM
    
        inc %CX 
        cmp %AX, %CX
        jae HAMLOOP #if length is greater than counter 
        ret

    mov %ch, ham 


SWAP: 
    movw $len2, %AX #PUT smaller length into AX
    ret 

incHAM: 
    inc %ch 
    ret
