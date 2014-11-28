#include <stdio.h>
#include <cs50.h>

int main(void)
{
    double n = 0;
    int nc = 0;
    int r = 0;

    do {
        printf("How much change is due?\n");
        n = GetDouble() * 100;
        nc = (int) n;
    } while (n <= 0);
    
    if (nc / 25 >= 0) {
        r = nc % 25;
        nc = nc / 25;
    }
    if (r / 10 >= 0) {
        nc = nc + r / 10;
        r = r % 10;
    }
    if (r / 5 >= 0) {
        nc = nc + r / 5;
        r = r % 5;        
    } 
    if (r / 1 >= 0) {
        nc = nc + r / 1;
        r = r % 1;
    }
   
    printf("%d\n",nc);
 
}
