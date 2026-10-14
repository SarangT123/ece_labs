#include <stdio.h>
#include <string.h>
#include <ctype.h>
int palindrome(char str[]){
   int size = strlen(str);
   for(int i = 0; i < size / 2; i++){
       if(tolower(str[i]) != tolower(str[size - 1 - i])){
           return 0;
       }
   }
   return 1;
}

int main(){
   char str[50];
   printf("Enter a string: \n");

   fgets(str, sizeof(str), stdin);

   str[strcspn(str, "\n")] = '\0';

   if (palindrome(str)){
       printf("The string is a palindrome \n");
   }
   else{
       printf("The string is not a palindrome \n");
   }
   return 0;
}