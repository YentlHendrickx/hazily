.PHONY: all assemble compile link iso clean

CROSS_COMPILER_PREFIX = ${HOME}/opt/cross/bin/i686-elf
GCC = $(CROSS_COMPILER_PREFIX)-gcc
AS = $(CROSS_COMPILER_PREFIX)-as

all: iso

assemble: boot.o

compile: kernel.o

link: kernel.bin

iso: hazily.iso

boot.o: boot.s
	$(AS) -o $@ $<

kernel.o: kernel.c
	$(GCC) -c $< -o $@ -std=gnu99 -ffreestanding -O2 -Wall -Wextra

kernel.bin: boot.o kernel.o linker.ld
	$(GCC) -T linker.ld -o $@ -ffreestanding -O2 $(filter-out linker.ld,$^) -nostdlib -lgcc

hazily.iso: kernel.bin grub.cfg
	mkdir -p isodir/boot/grub
	cp $< isodir/boot/hazily.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o $@ isodir
	rm -rf isodir

clean:
	rm -f *.o *.bin *.iso
	rm -rf isodir
