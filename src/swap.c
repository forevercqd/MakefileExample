/*
 * swap.c
 */

int shared = 1;

void swap(int *a, int *b)
{
    int temp = *b;
    *b = *a;
    *a = temp;
}
