/****************************************************************************
 * dictionary.c
 *
 * Computer Science 50
 * Problem Set 6
 *
 * Implements a dictionary's functionality.
 ***************************************************************************/

#include <stdbool.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "dictionary.h"
#define SIZE 1024 

typedef struct node 
{
  char* word;
  struct node* next;
} node;

int dictionarySize = 0;
node* hashtable[SIZE] = {NULL};

/**
 * Returns true if word is in dictionary else false.
 */
bool check(const char* word)
{
    // TODO
    return false;
}

/**
 * Loads dictionary into memory.  Returns true if successful else false.
 */
bool load(const char* dictionary)
{
    FILE* dict = fopen(dictionary, "r");
    
    if (dict == NULL)
    {
        return false;
    }
    
    char word[LENGTH + 1];
    
    while (fscanf(dict, "%s\n", word)!= EOF)
    {
        // increment dictionary size
        dictionarySize++;
        
        // allocate memory for new word 
        node* newWord = malloc(sizeof(node));
        
        // put word in the new node
        strcpy(newWord->word, word);
        
        // find what index of the hash table should be added to
        int index = word[0] - 'a' + 1;
        
        // if hashtable is empty at index, insert
        if (hashtable[index] == NULL)
        {
            hashtable[index] = newWord;
            newWord->next = NULL;
        }
        
        // if hashtable is not empty at index, append
        else
        {
            newWord->next = hashtable[index];
            hashtable[index] = newWord;
        }      
    }
    
    fclose(dict);
    
    return true;
}

/**
 * Returns number of words in dictionary if loaded else 0 if not yet loaded.
 */
unsigned int size(void)
{
    // TODO
    return 0;
}

/**
 * Unloads dictionary from memory.  Returns true if successful else false.
 */
bool unload(void)
{
    // TODO
    return false;
}
