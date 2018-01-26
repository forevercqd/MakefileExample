/*
 * main.c
 */

extern int shared;

int main()
{
    int a = 10;
    int *p; 

    printf("sizeof(int) %d, sizeof(pointer) %d.\n", sizeof(int), sizeof(p));
    printf("before swap: a %d, shared %d.\n", a, shared);
    swap(&a, &shared);

    printf("after swap: a %d, shared %d.\n", a, shared);

    return 0;
}
