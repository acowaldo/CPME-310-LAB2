.section .data 
STR1: .ascii "foo" #create first string
STR2: .ascii "bar" #create 2nd string
len1 = . - STR1  
len2 = . - STR2 

.section .bss
LENGTH: .skip 2 #reserve 2 bytes for length
.globl ham_dist #allow C program to see ham_dist
ham_dist: .skip 2 #reserve 2 bytes for hamming distance


.section .text
.globl hammer
hammer: 
    movb $0, %dh #move the value 0 to dh
    movb %dh, ham_dist # initialize ham_dist to 0
    

    #Store strings (USE LEA) 
    lea STR1, %SI # chuck memory address of STR1 to si
    lea STR2, %DI #memory address of STR2 to DI


    #len two strings, but length of smaller into variable
    movw $len1, %AX #move length1 into AX
    cmpw $len2, %AX #Compare string lengths 
    jl small_len_in_var #jump if len2 smaller than len1
    

    
    movw $0, %CX #initialize counter 

    #proper length has been aquired (YAY) create loop with comparisons
    xor_loop: 
    #does XOR need to be per byte? if do, double for loop, with bytes & 8 rotations
        #XOR each bit!
        #movb (%ebx), %ah #move first byte into ah
        #movb (%edx), %al 
        #xorb %ah, %al #XORRRRR

        #jne inc_ham_dist (inequality)
    
        inc %CX 
        cmp %AX, %CX
        jl xor_loop #if counter != to length 
        ret

    #place hamming distance at memory location 0x50
    mov $0x50, %esi #make 0x50 an index value
    lea ham_dist, %rdi #say ram is rdi
    add %esi, ham_dist #increment ram by esi


small_len_in_var: 
    movw $len2, %AX #PUT smaller length into AX
    ret

inc_ham_dist: #increment hamming distance
    add $1, %dh 
    ret


.section .note.GNU-stack,"",@progbits
