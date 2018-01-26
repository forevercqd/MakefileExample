/*
 * SpectialSymbol.c
 */
 
#include <stdio.h>

extern char __executable_start[];
extern char etext[], _etext[], __etext[];
extern char edata[], _edata[];
extern char end[], _end[];
 
int main()
{
     printf("Excutalble Start %0x\n", __executable_start);
     printf("text end %0x %0x %0x\n", etext, _etext, __etext);
     printf("data end %0x %0x \n", edata, _edata);
     printf("Excutalble end %0x, %0x.\n", end, _end);
 
     return 0;
}
 
