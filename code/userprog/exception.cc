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

void
ExceptionHandler(ExceptionType which)
{
    int type = machine->ReadRegister(2);

switch(which) {

case NoException: {
	return;
	}
case SyscallException: {
	switch(type)
	{
		case SC_Halt:
		{
			DEBUG('a', "Shutdown, initiated by user program.\n");
   			interrupt->Halt();
			break;
		}
		
		case SC_ReadInt:
		{
			char *buffer=new char();
			gSynchConsole->Read(buffer,7);
			int result;
			result=machine->myatoi(buffer);
			machine->WriteRegister(2,result);
			
			printf("Test- ReadInt: %d\n,result);
			delete buf;
			break;
		}
		
		case SC_PrintInt:
		{
			int number=(int) machine->ReadRegister(4);
			char *data=new char[256];
			machine->myitoa(num,data);
			for(int i=0;data[i]!= '\0';i++)
			{
				gSynchConsole->Write(&data[i],1);
			}
			delete[] data;
			break;
		}

		case SC_ReadChar:
		{
			int len;
			char *data=new char();
			len=gSynchConsole->Read(data,MAX_INT_LENGTH);
			machine->WriteRegister(2,data[len-1]);
			break;
		}

		case SC_PrintChar:
		{
			char data;
			data=(char) machine->ReadRegister(4);
			gSynchConsole->Write(&data,1);
			break;
		}

	machine->registers[PrevPCReg]=machine->registers[PCReg];
	machine->registers[PcReg]=machine->registers[NextPCReg];
	machine->registers[NextPCReg]+=4;
	break;
	}
case PageFaultException:
	printf("\nNo valid translation found. (%d %d)\n",which,type);
	interrupt->Halt();
	break;
case ReadOnlyException:
	printf("\nWrite attempted to page marked \"read-only\". (%d %d)\n",which,type);
	interrupt->Halt();
	break;
case BusErrorException:
	printf("\nTranslation resulted in an invalid physical address. (%d %d)\n",which,type);
	interrupt->Halt();
	break;
case AddressErrorException:
	printf("\nnaligned reference or one that was beyond the end of the address space. (%d %d)\n",which,type);
	interrupt->Halt();
	break;
case OverflowException:
	printf("\nInteger overflow in add or sub. (%d %d)\n",which,type);
	interrupt->Halt();
	break;
case IllegalInstrException:
	printf("\nUnimplemented or reserved instr. (%d %d)\n",which,type);
	interrupt->Halt();
	break;
case NumExceptionTypes:
	interrupt->Halt();
	break;
}

}

		


