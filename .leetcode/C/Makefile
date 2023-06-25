home = /home/ys/Code/Katas/Leet-Code/leetCodeFileName
valgrindFile = valgrind.txt
compiler = gcc 
flags = -Wextra -Wall -Wfloat-equal -lm
fileName = template

make:
	$(compiler) $(cdkPath) -o $(fileName) $(fileName).c

good:
	$(compiler) -o $(fileName) $(fileName).c  $(flags) 

debug-options:
	$(compiler) -g3 -o $(fileName) $(fileName).c  $(flags)  

debug:
	gdb --annotate=3 $(fileName)

valgrind:
	make debug-options
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=${valgrindFile} $(fileName)

uncrustify:
	find $(home) -type f -name '*.c' -exec uncrustify --no-backup -l=C {} + 
