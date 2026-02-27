#include <stdio.h> 
extern unsigned int ham_dist;

extern void hammer(void); 

int main()
{hammer(); 
    printf("Hamming Distance: ");

    printf("%02X ", ham_dist); //ham[0x50]);
    
    printf("\n"); 
    return 0; 
}