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
  char word[LENGTH + 1];
  struct node* next;
} node;

int dictionarySize = 0;
node* hashtable[SIZE] = {NULL};

/**
 * Returns true if word is in dictionary else false.
 */
bool check(const char* word)
{
    char tempWord[LENGTH + 1] = {'\0'};
    
    for(int i = 0, len = strlen(word); i <= len; i++)
    {
        tempWord[i] = tolower(word[i]);
    } 
     
    int index = tempWord[0] - 'a' + 1;
    node* temp = hashtable[index];
     
     // check if hashtable exists for letter
    if (temp == NULL)
    {
       return false;
    }
     
    // iterates through the list to find the last entry and appends newWord
    while (temp != NULL)
    {
        if (strcmp(tempWord, temp->word) == 0)
        {
            return true;
        }
        else
        { 
            temp = temp->next;
        }
    }   

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
    
    char word[LENGTH + 1] = {'\0'};
    
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
            node* temp = hashtable[index];
            // iterates through the list to find the last entry and appends newWord
            while (temp->next != NULL)
                {
                    temp = temp->next;
                }
            temp->next = newWord;    
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
