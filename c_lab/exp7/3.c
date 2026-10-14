#include <stdio.h>

struct Student {
   int roll;
   char name[50];
   int m1, m2, m3;
};

struct Student readStudent() {
   struct Student s;

   printf("Roll number: ");
   scanf("%d", &s.roll);
   printf("Name: ");
   scanf("%49s", s.name);
   printf("Marks in 3 subjects: ");
   scanf("%d %d %d", &s.m1, &s.m2, &s.m3);

   return s;
}
void displayStudent(struct Student s) {
   int total = s.m1 + s.m2 + s.m3;
   float average = total / 3.0;

   printf("%d  %s  %d  %d  %d  Total=%d  Average=%.2f\n",s.roll, s.name, s.m1, s.m2, s.m3, total, average);
}
int main() {
   struct Student students[100];
   int n, i;
   printf("Number of students: ");
   scanf("%d", &n);
   if (n > 100) {
       printf("Maximum 100 students allowed\n");
       return 1;
   }
   for (i = 0; i < n; i++) {
       printf("\nStudent %d\n", i + 1);
       students[i] = readStudent();
   }
   printf("\nDetails:\n");
   for (i = 0; i < n; i++) {
       displayStudent(students[i]);
   }
   return 0;
}