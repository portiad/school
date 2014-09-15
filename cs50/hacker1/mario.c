#include <stdio.h>
#include <cs50.h>

int main(void)
{
    int n;
    do
    {
        printf("Choose a number between 1 and 23 for the height of Mario's pyramid:\n");
        n = GetInt();
    }
    while (n > 23 || n < 0);
    for (int h = 0; h < n; h++)
    {
        for (int b = n ; b - 2 >= h ; b--)
        {
            printf(" ");
        }
        for (int l = 0; l - 1 < h ; l++)
        {
            printf("#");
        }
        printf("  ");
        
        for (int l = 0; l - 1 < h ; l++)
        {
            printf("#");
        }
        
        printf("\n");
    }
}
