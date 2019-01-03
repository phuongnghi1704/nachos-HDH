#include "syscall.h"

int main()
{
	char* str;
	ReadString(str,255);
       PrintString(str);

	return 0;
}
