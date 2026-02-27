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
    lea STR1, %esi # chuck memory address of STR1 to esi
    lea STR2, %edi #memory address of STR2 to eDI


    #len two strings, but length of smaller into variable
    movb $len1, %al #move length1 into al
    cmpb $len2, %al #Compare string lengths 
    jl small_len_in_var #jump if len2 smaller than len1

    #get byte amount 
    #movb $8, %dh
    #div %dh #divide AX by 8, getting num of bytes
    
    
    movb $0, %CL #initialize counter 
    
    #proper length has been aquired (YAY) create loop with comparisons
    byte_loop: 
        #move byte into bh, bl
        movb (%esi), %bh #move first byte into bh
        movb (%edi), %bl 

        xorb %bh, %bl #XORRRRR
        jne inc_ham_dist #(inequality) #if xor, inequality
            
        #shift bitz
        inc %esi
        inc %edi 
    
        inc %cl
        cmpb %al, %cl
        jl byte_loop #if counter != to length 
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
