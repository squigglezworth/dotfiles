#!/bin/bash

for foo in {0..32..1} 
do
	tput setaf $foo
	echo $foo
done
