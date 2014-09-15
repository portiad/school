#include <stdio.h>
#include <cs50.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int main(int argc, string argv[])
{
    if (argc != 2) {
      printf("Please enter in two arguments to start your ceasaring!\n"); 
      return 1; 
    } else {
        int k = atoi(argv[1]) % 26;
        string p = GetString();
        
        for (int i = 0, n = strlen(p); i < n; i++) {
            int v = p[i] + k;
            if (isupper(p[i])) {
                if (v > 'Z'){
                    v = v - 'Z' + '@';
                }
            } else if (islower(p[i])) {
                if (v > 'z') {
                    v = v - 'z' + '`';
                }
            } else {
                v = p[i];
            }
            printf("%c", v);
        }
        printf("\n");
    }
}
