all:
	nasm -f elf add.asm -o add.o -l starter.lst
	nasm -f elf sub.asm -o sub.o                # Add this line
	gcc -m32 -c main.c
	gcc -m32 main.o add.o sub.o -o $(EXECUTABLE) # Include sub.o here
	./$(EXECUTABLE)
