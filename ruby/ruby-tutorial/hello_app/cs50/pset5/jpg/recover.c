/**
 * recover.c
 *
 * Computer Science 50
 * Problem Set 5
 *
 * Recovers JPEGs from a forensic image.
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <stdint.h>


#define BLOCK 512

int main(void)
{

    // remember filenames
    char* infile = "card.raw";
    
    // open input file 
    FILE* inptr = fopen(infile, "r");
    if (inptr == NULL)
    {
        printf("Could not open %s.\n", infile);
        return 2;
    }

    // bytes to id a jpg
    uint8_t jpg1[4] =  {0xff, 0xd8, 0xff, 0xe0};
    uint8_t jpg2[4] =  {0xff, 0xd8, 0xff, 0xe1};

    //count for jpg name
    int jfilecount = 0;
    
    //loading 512 bytes into memory
    uint8_t buffer[BLOCK];
    
    //tracking for starting and stopping new files
    int match = 0;
    int open = 0;
    
    FILE* outptr;
    
    while (!feof(inptr))
    {
        //read file into memory
        fread(buffer, BLOCK, 1, inptr);
        
        //loop to determine if the first 4 bytes are for jpg
        for(int i = 0; i < 4; i++)
        {
            if (buffer[i] == jpg1[i] || buffer[i] == jpg2[i])
            {
                match = 1;
            }
            else 
            {
                match = 0;
                break;
            }
        }
        
        //determine is match is set from above    
        if(match == 1)
        {
            char outfile[8];
			sprintf(outfile, "%03d.jpg", jfilecount);
            
            //first time through
            if (open == 0)
            {
                outptr = fopen(outfile, "w");
                fwrite(buffer, sizeof(buffer), 1, outptr);
                open = 1;
                jfilecount++;
            }
            
            //close file and open new file    
            else
            {
                fclose(outptr);
                outptr = fopen(outfile, "w");
                fwrite(buffer, sizeof(buffer), 1, outptr);
                jfilecount++;
             }    
        }
        
        //continue to write to existing file
        else if (open == 1)
        {
            fwrite(buffer, sizeof(buffer), 1, outptr);
        }
    }
}
