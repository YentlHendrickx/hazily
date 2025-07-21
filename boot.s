/* Constants for multiboot header */
/* NOTE: Look into all of these flags and what they mean in the multiboot specification */
.set ALIGN,		1<<0			 // Align loaded modules on page boundaries
.set MEMINFO,	1<<1			 // Memory gap
.set FLAGS,		ALIGN | MEMINFO  // multiboot 'flag' field 
.set MAGIC,		0x1BADB002		 // Magic number so bootloader can find header
.set CHECKSUM,	-(MAGIC + FLAGS) // Checksum of above, prove we are in multiboot format

/* 
Multiboot header structure
This is the first thing the bootloader will look for.
NOTE: understand how the bootloader uses this, maybe write my own bootloader?
*/
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

/*
Stack setup, stack grows downwards and needs to be aligned by 16-bytes on x86
NOTE: I understand how this works, but i need to dig into how x86 handles the stack and how the bootloader sets it up.
*/
.section .bss
.align 16
stack_bottom:
.skip 16384 # 16 KiB stack
stack_top:

/*
The linker script will place the kernel entry point here.
NOTE: Seems logical, however i need to understand how the linker script works and how it is used to place sections in memory.
*/
.section .text
.global _start
.type _start, @function
_start:
    // Set up the stack pointer
    movl $stack_top, %esp

    call kernel_main

	// Put in infinite loop to prevent returning
	cli
1:  hlt
	jmp 1b

/*
Set size of _start symbol to current location minus start, this can be useful in debugging
NOTE: Why is that so?
*/
.size _start, . - _start
