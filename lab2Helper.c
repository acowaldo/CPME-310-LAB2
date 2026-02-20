#include <stdio.h> 
extern unsigned char ham[];

extern void hammer(void); 

int main()
{hammer(); 
    printf("Hamming Distance: ");

    printf("%02X ", ham[0x50]);
    
    printf("\n"); 
    return 0; 
}