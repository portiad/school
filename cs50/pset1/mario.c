#include <stdio.h>
#include <cs50.h>

int main(void)
{
    int n;
    do {
        printf("Choose a number between 1 and 23 for the height of Mario's pyramid:\n");
        n = GetInt();
    } while (n < 0 || n > 23);
    for (int i = 0; i < n; i++) {
        for (int j = n ; j - 2 >= i ; j--) {
            printf(" ");
        }
        for (int k = 0; k - 2 < i ; k++) {
            printf("#");
        }
        printf("\n");
    }
}
