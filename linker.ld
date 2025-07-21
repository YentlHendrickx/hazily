ENTRY(_start)

SECTIONS
{
		. = 2M; /* 2M start offset */
		.text BLOCK(4K) : ALIGN(4K)
		{
				*(.multiboot)
				*(.text)
		}

		/* Read-only data section */
		.rodata BLOCK(4K) : ALIGN(4K)
		{
				*(.rodata)
		}

		/* Read-write data section */
		.data BLOCK(4K) : ALIGN(4K)
		{
				*(.data)
		}

		/* Read-Write data, stack (BSS) */
		.bss BLOCK(4K) : ALIGN(4K)
		{
				*(COMMON)
				*(.bss)
		}
}
