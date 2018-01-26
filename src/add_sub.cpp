#include <stdio.h>
#include "sub.h"
#include "add.h"

int add_sub(int a, int b, int c)
{
    return sub( add(a, b), c);
}
