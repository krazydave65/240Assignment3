nasm -f elf64 -l p3Main.lis -o p3Main.o p3Main.asm
nasm -f elf64 -l debug.lis -o debug.o debug.asm
gcc -c -m64 -Wall -std=c99 -l p3Driver.l -o p3Driver.o p3Driver.c
gcc -c -m64 -Wall -std=c99 -l calc.l -o calc.o calc.c
gcc -m64 -o p3.out p3Driver.o calc.o p3Main.o debug.o -lm
