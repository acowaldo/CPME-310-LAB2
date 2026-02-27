#include <stdio.h> 
extern unsigned int ham_dist;

extern int hammer(void); 

int main()
{
    int distance = hammer(); 
    printf("Hamming Distance: ");

    printf("%d\n ", distance); //ham[0x50]);
    
    printf("\n"); 
    return 0; 
}