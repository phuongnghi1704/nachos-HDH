#include "syscall.h"

char Bin[8];
char Hex[3];
char Oct[4];

void DectoBin(int Dec)
{
	int i = 6;
	int j;
	int temp;
	temp = Dec;
	while(temp != 0)
	{
	    	if (temp % 2 == 1)
            		Bin[i] = '1';
		else
           		Bin[i] = '0';

		temp = temp / 2;
		i--;
	}
	if(i >= 0)
		for(j = i ;j >=0;j--)
			Bin[j] = '0';
	Bin[7] = '\0';
}

void DectoHex(int Dec)
{
	char hex[16];
	int temp,r;
	int i = 1;
	temp = Dec;
	
	hex[0]='0';hex[1]='1';hex[2]='2';hex[3]='3';hex[4]='4';hex[5]='5';hex[6]='6';hex[7]='7';
	hex[8]='8';hex[9]='9';hex[10]='A';hex[11]='B';hex[12]='C';hex[13]='D';hex[14]='E';hex[15]='F';

	while(temp>0)
        {
            r = temp % 16;
            Hex[i] = hex[r];
            temp = temp/16;
	    i--;
        }
	Hex[2] = '\0';
	
}

void DectoOct(int Dec)
{
	int temp,r,j;
	int i = 2;
	temp = Dec;

	while(temp>0)
        {
            r = temp % 8;
            Oct[i] = r + 48;
            temp = temp/8;
	    i--;
        }
	if(i >= 0)
		for(j = i ;j >=0;j--)
			Oct[j] = '0';
	Oct[3] = '\0';
}

int main()
{	
	char i = 32;
	PrintString("Binary\tOct\tDec\tHex\tGlyph\n");
	for (; i < 127; i++)
	{
		DectoBin(i);
		PrintString(Bin);
		PrintString("\t");
		
		DectoOct(i);
		PrintString(Oct);
		PrintString("\t");

		PrintInt((int)i);	
		PrintString("\t");	

		DectoHex(i);
		PrintString(Hex);
		PrintString("\t");
		
		PrintChar(i);

		PrintChar('\n');	
	}
	return 0;
}

