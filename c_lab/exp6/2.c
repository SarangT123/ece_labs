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
    int a[100], n, i, key, pos;

    printf("Enter number of elements: ");
    scanf("%d", &n);

    printf("Enter %d elements in sorted order:\n", n);
    for (i = 0; i < n; i++) {
        scanf("%d", &a[i]);
    }

    printf("Enter key: ");
    scanf("%d", &key);

    pos = binarySearch(a, n, key);

    if (pos == -1) {
        printf("Not found\n");
    } else {
        printf("Found at index %d\n", pos);
    }

    return 0;
}