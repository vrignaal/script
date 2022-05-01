#!/bin/bash

<< 'Comment'
Ce script permet la création d'un nouveau projet en C
 	Arborescence :
		\_ Projet
			\_ bin
				\_ README.md
			\_ src
				\_ main.c
				\_ README.md
			\_ makefile
			\_ new_class.sh
		
	- dossier bin 	-> contient le fichier executable
	- dossier src 	-> contient les fichiers sources
	- README.md 	-> doc
	- main.c 		-> hello world
	- makefile 		-> fichier de compilation
	- new_class.sh 	-> script permettant la création de classe (.c .h)
Comment

#
# Fonctions de construction des fichiers
#
constructMakefile(){
echo "# $project_name Makefile

# Tools
OBJS 	 = *.o
CC 		 = gcc
APP_NAME = $project_name

# Folders
BIN = bin
SRC = src

# Rules
all: \$(BIN)/\$(APP_NAME) clean
	@echo \"Done\"

\$(BIN)/\$(APP_NAME):	\$(OBJS) 
	\$(CC) -o \$@ \$(OBJS)

*.o : \$(SRC)/*.c
	\$(CC) -c -Wall \$(SRC)/*.c

# Clean
clean:
	rm -f \$(APP_NAME) *.o" >> makefile
}

constructNewClass(){
echo "#!/bin/bash
cd src

read -p \"Entrez le nom de la classe : \" class_name

touch \$class_name.h

echo \"// header file

#ifndef \${class_name^^}_H
#define \${class_name^^}_H

#endif /* \${class_name^^}_H */\" >> \$class_name.h

touch \$class_name.c

echo \"// source file

#include \\\"\$class_name.h\\\"\">> \$class_name.c

" >> new_class.sh
}

constructMain(){
	echo "// main file

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
	printf(\"Hello World!\\n\");
	
	return EXIT_SUCCESS;
}" >> main.c
}

constructREADME(){
	echo "$1 directory" >> README.md
}

#
# Construction du dossier projet
#

# nommage du projet
read -p "Entrez le nom du projet : " project_name
mkdir $project_name
cd $project_name

# construction des fichiers/dossiers utiles 
mkdir src bin 
touch makefile README.md 

constructREADME project 
constructMakefile

# construction du script de creation de classe
touch new_class.sh
chmod 764 new_class.sh

constructNewClass

# dossier SRC
cd src
touch main.c README.md

constructMain
constructREADME src

# dossier BIN
cd ../bin
touch README.md 
constructREADME bin