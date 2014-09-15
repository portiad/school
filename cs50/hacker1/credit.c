#include <stdio.h>
#include <cs50.h>
#include <math.h>
#include <string.h>

int main(void)
{
    long long cc = 0;
    long long ccct = 0;
    int count = 0;
    string cctype;
   
    printf("What is your credit card number?\n");
    cc = GetLongLong();
    //check the length of the credit card
    ccct = cc;
    while (ccct)
    {
        ccct /= 10;
        count++;
    }
    if (count < 13 || count > 16) 
    {   
        cctype = "INVALID";
    }
    else
    {
        int ccarray[count];
        ccct = cc;
        int ft = 0;
        
        for (int i = 0; i < count; i++)
        {
            ccarray[i] = 0;
        }
        
        for (int i = 0; i < count; i++)
        {
            ccarray[i] = ccct % 10;
            ccct/=10;
        }
        
        if ((ccarray[(count - 1)] == 4) && (count == 13 || count == 16))
        {
          ft = 4;
          cctype = "VISA";  
        }
        else 
        {
            ft = ccarray[(count - 1)] * 10 + ccarray[(count) - 2];
            
            if ((ft == 34 || ft == 37) && count == 15)
            {
                cctype = "AMEX";    
            }
            else if ((ft == 51 || ft == 52 || ft == 53 || ft == 54 || ft == 55) && count == 16)
            {
                cctype = "MASTERCARD";  
            }
            else
            {
                cctype = "INVALID";
            }
        }
        
        for (int i = 1; i < count ; i = i + 2)
        {
            if (ccarray[i] >= 5)
            {
                ccarray[i] = (ccarray[i] * 2) % 10 + 1;
            }
            else 
            {
                ccarray[i] *= 2;
            }
        }
        
        int total = 0;
        
        for (int i = 0; i < count ; i++)
        {
            total += ccarray [i];
        }
        if (total % 10 != 0)
        {
            cctype = "Invalid";
        }   
    }
    
    printf("%s\n",cctype);
}
