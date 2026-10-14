#include <stdio.h>

void readLine(char str[], int size)
{
    int i;

    fgets(str, size, stdin);

    // To remove newline
    for (i = 0; str[i] != '\0'; i++){
        if (str[i] == '\n'){
            str[i] = '\0';
        }
    }
}

int main(void)
{
    char line[100];

    printf("Enter a line: ");
    readLine(line, 100);
    printf("You typed: %s \n", line);

    return 0;
}