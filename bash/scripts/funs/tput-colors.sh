#!/bin/bash

for foo in {0..17..1} 
do
	tput setaf $foo
	echo $foo
done
