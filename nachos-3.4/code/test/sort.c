/* sort.c 
 *    Test program to sort a large number of integers.
 *
 *    Intention is to stress virtual memory system.
 *
 *    Ideally, we could read the unsorted array off of the file system,
 *	and store the result back to the file system!
 */

#include "syscall.h"
	
int arr[100];
int n;

void input()
{
	int i;
	do
	{
		PrintString("Nhap vao so phan tu cua mang (1 <= n <= 100): ");
		n = ReadInt();
	}while(n > 100 || n < 1);
	for(i = 0;i < n; i++)
	{
		PrintString("A["); PrintInt(i); PrintString("]: ");
		arr[i] = ReadInt();
	}
}

void output()
{
	int i;
	for(i = 0;i < n; i++)
	{
		if((i % 10) == 0)
			PrintChar('\n');
		PrintInt(arr[i]); PrintChar(' ');
		
	}
}

void bubblesort()
{
	int i ;
	int temp;
	int j;
	for(i = n-1;i > 0;i--)
	{
		for( j = 0;j < i;j++)
		{
			if(arr[j] > arr[j+1])
			{
				temp = arr[j];
				arr[j] = arr[j+1];
				arr[j+1] = temp;
			}
		}
	}
}

int main()
{	
	input();
	PrintString("Mang ban dau: \n");
	output();
	PrintString("\n\n");
	
	bubblesort();
	PrintString("Mang sau khi sap xep: \n");
	output();
	PrintChar('\n');
	
	return 0;
}
 
