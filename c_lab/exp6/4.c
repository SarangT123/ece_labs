#include <stdio.h>

void removeString(char text[], int start, int count) {
    int i;

    for (i = start; text[i + count - 1] != '\0'; i++) {
        text[i] = text[i + count];
    }
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
    char text[100];
    int start, count;

    printf("Enter a string: ");
    fgets(text, 100, stdin);
    removeNewline(text);

    printf("Enter starting index: ");
    scanf("%d", &start);

    printf("Enter number of characters to remove: ");
    scanf("%d", &count);

    removeString(text, start, count);
    printf("Result: %s\n", text);

    return 0;
}