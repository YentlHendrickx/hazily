#!/bin/bash

if grub-file --is-x86-multiboot "$1"; then
    echo "The file '$1' is a valid Multiboot file."
else
    echo "The file '$1' is not a valid Multiboot file."
fi

