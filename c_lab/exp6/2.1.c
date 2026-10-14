#include <stdio.h>

int binarySearch(int arr[], int n, int key) {
    int low = 0, high = n - 1, mid;

    while (low <= high) {
        mid = (low + high) / 2;

        if (arr[mid] == key) {
            return mid;
        } else if (key < arr[mid]) {
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return -1;
}

int main(void) {
    int a[] = {2, 5, 8, 12, 16, 23, 38, 56, 72, 91};
    int key, pos;

    printf("Enter key: ");
    scanf("%d", &key);

    pos = binarySearch(a, 10, key);

    if (pos == -1) {
        printf("Not found\n");
    } else {
        printf("Found at index %d\n", pos);
    }

    return 0;
}