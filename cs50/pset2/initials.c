#include <stdio.h>
#include <cs50.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int main (void)
{
    string name;
    
    do {
        name = GetString();
    } while (strlen(name) <= 0);
    for (int i = 0; i < strlen(name); i++) {
        if (i == 0) {
            printf("%c",name[i]);
       } else if (name[i] == ' ' && i + 1 < strlen(name)) {
            printf("%c", name[i+1]);
       }
    }
    printf("\n");
}
