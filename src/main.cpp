#include <stdio.h>
#include "add_sub.h"

int  main()
{
    printf("enter main.\n");
    int add_sub_result = add_sub(3, 4, 5);

    printf("%s, line %d, add_sub_result = %d.\n", __FUNCTION__, __LINE__, add_sub_result);

    return 0;
}
