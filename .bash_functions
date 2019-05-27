#!/bin/bash
cleancython(){
	read -p "Are you sure? [Y/n] " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo Recursive cleaning *.pyc, *.c, *.so
		find \( -name '*.pyc' -o -name '*.c' -o -name '*.so' \) -delete
	else
		echo Aborting
	fi 
}

