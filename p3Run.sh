
gcc -c -m64 -Wall -std=c99 -l p3Driver.lis -o p3Driver.o p3Driver.c

nasm -f elf64 -l p3Main.lis -o p3Main.o p3Main.asm

gcc -m64 -o p3.out p3Driver.o p3Main.o debug.o calc.o

./p3.out
