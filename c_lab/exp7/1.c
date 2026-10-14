#include <stdio.h>
struct date{
   int day;
   int month;
   int year;
};

int f(int y,int m){
   if (m<=2){
        return y-1;
   }
   return y;
}
int g(int m){
   if (m<=2){
       return m+13;
   }
   return m+1;
}
int N(struct date d){
   return ((1461*f(d.year,d.month))/4)+((153*g(d.month))/5)+d.day;
}

int main(){
   struct date d1;
   struct date d2;

   printf("Enter the first date in the format dd mm yyyy \n ");
   scanf("%d %d %d",&d1.day,&d1.month,&d1.year);
   printf("Enter the second date in the format dd mm yyyy \n ");
   scanf("%d %d %d",&d2.day,&d2.month,&d2.year);

   int N1 = N(d1);
   int N2 = N(d2);

   printf("the no. of days between %d-%d-%d and %d-%d-%d is %d \n",d2.day,d2.month,d2.year,d1.day,d1.month,d1.year,N2-N1);

   return 0;
}