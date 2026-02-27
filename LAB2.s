.section .data 
STR1: .ascii "foo" #create first string
STR2: .ascii "bar" #create 2nd string
len1 = . - STR1  
len2 = . - STR2 

.section .bss
LENGTH: .skip 2 #reserve 2 bytes for length
.globl ham_dist #allow C program to see ham_dist
ham_dist: .skip 4 #reserve 2 bytes for hamming distance


.section .text
.globl hammer
hammer: 
    movl $0, %eax #move the value 0 to eax
    #movl %eax, ham_dist # initialize ham_dist to 0
    

    #Store strings (USE LEA) 
    xor %esi, %esi 
    xor %edi, %edi

    lea STR1, %esi # chuck memory address of STR1 to esi
    lea STR2, %edi #memory address of STR2 to eDI

    movb $0, %CL #initialize counter 

    #len two strings, but length of smaller into variable
    movb $len1, %cl #move length1 into cl
    cmpb $len2, %cl #Compare string lengths 
    jl small_len_in_var #jump if len2 smaller than len
    movb $len1, %cl
        
    #proper length has been aquired (YAY) create loop with comparisons
    byte_loop: 
        #move byte into dh, bl
        xor %ebx, %ebx #clear ebx
        
        movb (%esi), %dh #move first byte into dh
        movb (%edi), %bl 

        xorb %dh, %bl #xor is stored in bl
        xor %ch, %ch
        movb $8, %ch #count all 8 bits

        rotate_bits:     
            shrb $1, %bl #rotate bl by one

            adc $0, %eax  
            #jc inc_ham_dist #if carry flag, inc hamming_distance by 1

            inc_all:  

                dec %ch #8-bit counter
                jnz rotate_bits #if 8 rotations are not over, keep looping

            inc %esi
            inc %edi
                
            dec %cl
            jnz byte_loop #if counter != 0 
            
        
    #c-file will take %eax as output integer
    #xor %eax, %eax
    #mov $ham_dist, %eax
    ret


small_len_in_var: 
    movb $len2, %cl #PUT smaller length into cl
    jmp byte_loop

inc_ham_dist: #increment hamming distance
    mov ham_dist, %eax
    inc %eax
    movl %eax, ham_dist 

    jmp inc_all 
    ret


.section .note.GNU-stack,"",@progbits
