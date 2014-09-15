#include <stdio.h>
#include <cs50.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int main(int argc, string argv[])
{
    if (argc != 2) {
      printf("Please enter in two arguments to start your ciphering!\n"); 
      return 1; 
    }

    string k = argv[1];
    int lenk = strlen(k); 
    for(int i = 0; i < lenk; i++) { // determine that the keyword is alpha
        if (isalpha(k[i]) == false) {
            printf("You did not enter in a word\n");
            return 1;
        }
    }
    
    string p = GetString();
    int n = strlen(p);
    
    for (int i = 0, j = 0; i < n; i++, j++) { //iterate through the code to cypher
        int v = 0;
        if (j > lenk - 1) {
            j = 0;
        }
        if (isupper(p[i])) { // determine if upper case
            v = ((p[i] - 'A') + (toupper(k[j]) - 'A') % 26 + 'A');
            if (v > 'Z') {
                v = v - 'Z' + '@';
            }
        } else if (islower(p[i])) { //determine if lower case
            v = ((p[i] - 'a') + (tolower(k[j]) - 'a') % 26 + 'a');
            if (v > 'z') {
                v = v - 'z' + '`';   
            }
        } else {
            v = p[i]; //print exisiting character if not alpha
            j--;
        }
        printf("%c",v);
    }
    printf("\n");
}
