// exception.cc 
//	Entry point into the Nachos kernel from user programs.
//	There are two kinds of things that can cause control to
//	transfer back to here from user code:
//
//	syscall -- The user code explicitly requests to call a procedure
//	in the Nachos kernel.  Right now, the only function we support is
//	"Halt".
//
//	exceptions -- The user code does something that the CPU can't handle.
//	For instance, accessing memory that doesn't exist, arithmetic errors,
//	etc.  
//
//	Interrupts (which can also cause control to transfer from user
//	code into the Nachos kernel) are handled elsewhere.
//
// For now, this only handles the Halt() system call.
// Everything else core dumps.
//
// Copyright (c) 1992-1993 The Regents of the University of California.
// All rights reserved.  See copyright.h for copyright notice and limitation 
// of liability and disclaimer of warranty provisions.

#include "copyright.h"
#include "system.h"
#include "syscall.h"

//----------------------------------------------------------------------
// ExceptionHandler
// 	Entry point into the Nachos kernel.  Called when a user program
//	is executing, and either does a syscall, or generates an addressing
//	or arithmetic exception.
//
// 	For system calls, the following is the calling convention:
//
// 	system call code -- r2
//		arg1 -- r4
//		arg2 -- r5
//		arg3 -- r6
//		arg4 -- r7
//
//	The result of the system call, if any, must be put back into r2. 
//
// And don't forget to increment the pc before returning. (Or else you'll
// loop making the same system call forever!
//
//	"which" is the kind of exception.  The list of possible exceptions 
//	are in machine.h.
//----------------------------------------------------------------------
char* User2System(int virtAddr,int limit)
{
	int i;// index
	int oneChar;
	char* kernelBuf = NULL;
	kernelBuf = new char[limit +1];//need for terminal string
	if (kernelBuf == NULL)
		return kernelBuf;
	memset(kernelBuf,0,limit+1);
	//printf("\n Filename u2s:");
	for (i = 0 ; i < limit ;i++)
	{
		machine->ReadMem(virtAddr+i,1,&oneChar);
		kernelBuf[i] = (char)oneChar;
	//printf("%c",kernelBuf[i]);
		if (oneChar == 0)
			break;
	}
	return kernelBuf;
}

int System2User(int virtAddr,int len,char* buffer)
{
	if (len < 0) return -1;
	if (len == 0)return len;
	int i = 0;
	int oneChar = 0 ;
	do{
		oneChar= (int) buffer[i];
		machine->WriteMem(virtAddr+i,1,oneChar);
		i ++;
	}while(i < len && oneChar != 0);
	return i;
}

void increasePC()
{
	machine->registers[PrevPCReg]=machine->registers[PCReg];
	machine->registers[PCReg]=machine->registers[NextPCReg];
	machine->registers[NextPCReg]+=4;
}


void
ExceptionHandler(ExceptionType which)
{
	int type = machine->ReadRegister(2);
	switch(which)
	{
		case NoException:
			return;
		case SyscallException:
			switch(type)
			{
				case SC_Halt:
					DEBUG('a', "Shutdown, initiated by user program.\n");
					interrupt->Halt();
					break;

				case SC_Sub:
					int op1;
					op1 = machine->ReadRegister(4);
					int op2;
					op2 = machine->ReadRegister(5);
					int result;
					result = op1 - op2;
					machine->WriteRegister(2,result);
					//interrupt->Halt();
					break;

				case SC_ReadInt:

				{    /*int: [-2147483648 , 2147483647] --> max length = 11*/

					char* stringInt= new char[12];        int lenght, i=0, res=0;   bool sign = true;

				// Doc chuoi so do nguoi dung nhap vao
				lenght = gSynchConsole->Read(stringInt, 12);

				// Kiem tra va danh dau neu la so am
				if (stringInt[0] == '-')
				{
					sign = false;
					i++;
				}
				   
				// Tien hanh chuyen doi chuoi so thanh so nguyen
				while(i < lenght)
				{
					// Xu ly tren tung ki tu. Neu la ki so thi cong vao gia tri
					if (stringInt[i] > 47 && stringInt[i] < 58)
					{
						res = res * 10 + (stringInt[i] - 48);
						i++;
					}
					else // Khong phai la ki so thi ghi 0 vao thanh ghi 2 
					{
						machine->WriteRegister(2, 0);
						goto EndReadInt;
					}             
				}
				
				// Ghi ket qua xuong thanh ghi
				if (sign)
					machine->WriteRegister(2, res);
				else
					machine->WriteRegister(2, -res);

				//test readint
				//printf("\nTest ReadInt: %i\n",res);
				
				EndReadInt:
				delete stringInt;

				break;
				}	

				case SC_PrintInt:

				{
					int i = 0, j, k, v = machine->ReadRegister(4);
					char* stringInt = new char[12];
					if (stringInt == NULL)
						break;
				
					// Neu la so am thi chuoi bat dau bang ki tu '-'
					if (v < 0)
					{
						stringInt[i] = '-';
						v = -v; 
						i++;
					}

					// Thuc hien vong lap de lay tung ki so
					do
					{
						stringInt[i] = v % 10 + 48;
						v /= 10; i++;
					} while (v != 0);
					stringInt[i] = '\0';
					// Dao chuoi de co thu tu dung
					stringInt[0] == '-' ? j = 1 : j = 0; i--;
					for (k = (i + j); j <= k/2; j++, i--)
					{
						char temp = stringInt[j];
						stringInt[j] = stringInt[i];
						stringInt[i] = temp;
					}

					// Xuat ra man hinh
					gSynchConsole->Write(stringInt, k + 1);
					
  				        machine->WriteRegister(2, 0);
					break;
				}

				case SC_ReadChar:
				{
					 char c = 0;
   					 gSynchConsole->Read(&c,1);
   					 machine->WriteRegister(2, (int)c);

					//test readchar
					//printf("\nTest ReadChar: %c\n",c);
				break;
				}

				case SC_PrintChar:
				
				{
					 char c = (char)machine->ReadRegister(4);
   					 gSynchConsole->Write(&c,1);
  					 machine->WriteRegister(2, 0);
					 break;
				}
				case SC_PrintString:
				{
					int virtAddr= machine->ReadRegister(4);
					char* stringBuffer=User2System(virtAddr,255);
					if (stringBuffer==NULL)
						{
						machine->WriteRegister(2,-1); // trả về lỗi 
										
						return;
						}
					int i = 0;

					while (stringBuffer[i] != '\0')
						i++;
					gSynchConsole->Write(stringBuffer,i);
					break;
				}
				case SC_ReadString:
				{
					int maxLength=machine->ReadRegister(5);
					char* stringBuffer=new char[maxLength];
					if (stringBuffer==NULL) 
					{
						machine->WriteRegister(2,-1);
						return;
					}
					int length=gSynchConsole->Read(stringBuffer,maxLength);
					int virtAddr=machine->ReadRegister(4);
					int sign= System2User(virtAddr,length,stringBuffer);
						if(sign == -1)
					{
						machine->WriteRegister(2,-1);
					}
					//Test ReadString
					//int i=0;
					//printf("\nTest ReadString: ");
					//while (stringBuffer[i] != '\0')
					//{
						
						//printf("%c",stringBuffer[i]);
						//i++;
					//}
					break;
				}	
			}

			increasePC();
			break;
																
			
			
		case PageFaultException:
			DEBUG('a', "\n No valid translation found.");
			printf("\nNo valid translation found. (%d %d)\n",which,type);
			interrupt->Halt();
			break;
		case ReadOnlyException:
			DEBUG('a', "\n Write attempted to page marked \"read-only\".");
			printf("\nWrite attempted to page marked \"read-only\". (%d %d)\n",which,type);
			interrupt->Halt();
			break;
		case BusErrorException:
			DEBUG('a', "\n Translation resulted in an invalid physical address.");
			printf("\nTranslation resulted in an invalid physical address. (%d %d)\n",which,type);
			interrupt->Halt();
			break;
		case AddressErrorException:
			DEBUG('a', "\n naligned reference or one that was beyond the end of the address space.");
			printf("\nnaligned reference or one that was beyond the end of the address space. (%d %d)\n",which,type);
			interrupt->Halt();
			break;
		case OverflowException:
			DEBUG('a', "\n Integer overflow in add or sub.");
			printf("\nInteger overflow in add or sub. (%d %d)\n",which,type);
			interrupt->Halt();
			break;
		case IllegalInstrException:
			DEBUG('a', "\n Unimplemented or reserved instr.");
			printf("\nUnimplemented or reserved instr. (%d %d)\n",which,type);
			interrupt->Halt();
			break;
		case NumExceptionTypes:
			interrupt->Halt();
			break;

	}
	
}
