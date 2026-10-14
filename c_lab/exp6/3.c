#include <stdio.h>

int findString(char source[], char target[]) {
    int i, j;

    for (i = 0; source[i] != '\0'; i++) {
        j = 0;
        while (target[j] != '\0' && source[i + j] == target[j]) {
            j++;
        }

        if (target[j] == '\0') {
            return i;
        }
    }
    return -1;
}

void removeNewline(char str[]) {
    int i;

    for (i = 0; str[i] != '\0'; i++) {
        if (str[i] == '\n') {
            str[i] = '\0';
        }
    }
}

int main(void) {
    char source[100], target[100];
    int index;

    printf("Enter the source string: ");
    fgets(source, 100, stdin);
    removeNewline(source);

    printf("Enter the string to find: ");
    fgets(target, 100, stdin);
    removeNewline(target);

    index = findString(source, target);
    printf("Index = %d\n", index);

    return 0;
}