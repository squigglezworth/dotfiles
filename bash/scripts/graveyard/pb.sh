#!/bin/bash

# -c 	Create paste
#		Read from stdin or file specified, can specify multiple -c files
# -r	Get paste
# -u 	Update paste
# -d 	Delete paste
# -db	Dump database of pastes
# shopt -s extglob
# [ ! -t 0 ] && stdin=1 || stdin=0
# for arg in "$@"; do
# 	case $arg in
# 		cb)
# 			[ $pb_op ] && echo "Only one operation permitted at a time" && exit;
# 			pb_op=clipboard;;
# 		c)
# 			[ $pb_op ] && echo "Only one operation permitted at a time" && exit;

# 			shift
# 			for arg2 in "$@"; do
# 				case $arg2 in
# 					-p) [[ ! $2 =~ (-s|-p) ]] || [ ! $2 ] && private=1; shift;;
# 					-s) [ ! $sunset ] && sunset=$2; shift 2;;
# 					[!-]*) [ $info ] || info=$arg2; shift;;
# 				esac
# 			done
# 			pb_op=create
# 			break;;
# 		d)
# 			[ $pb_op ] && echo "Only one operation permitted at a time" && exit;
# 			pb_op=delete
# 			break;;
# 		da)
# 			[ $pb_op ] && echo "Only one operation permitted at a time" && exit;
# 			pb_op=delete-all;
# 			break;;
# 		db)
# 			[ $pb_op ] && echo "Only one operation permitted at a time" && exit;
# 			pb_op=database
# 			break;;
# 		*) echo "Invalid args" && exit;
# 	esac
# done
#  echo -e "Name $info\n"
#  echo -e "Private $private\n"
#  echo -e "Sunset $sunset\n"

shopt -s extglob
[ ! -t 0 ] && stdin=1 || stdin=0
if [[ $stdin == 1 && "$#" -gt 0 ]]; then
	while [ "$#" -gt 0 ]; do
		case $1 in
			-p) [[ $2 =~ (-s|-p) ]] || [ ! $2 ] && private=1; shift;;
			-s) [ ! $sunset ] && sunset=$2; shift 2;;
			[!-]*) [ $info ] || info=$1; shift;;
			*) echo "invalid args"; exit;;
		esac
	done
fi
[ ! "$#" -gt 0 ] && echo "Please provide a command" && exit
while [[ "$#" -gt 0 && $stdin == 0 ]]; do
	# [ $operation ] || echo "Fail" && exit?
	case $1 in
		cb)
			[ $pb_op ] && echo "Only one operation permitted at a time" && exit
			pb_op=clipboard
			shift
		;;
		c)
			[ $pb_op ] && echo "Only one operation permitted at a time" && exit
			pb_op=create
			shift
			private=0
			sunset=0
			while [ "$#" -gt 0 ]; do
				case $1 in
					-p) [[ $private == 0 ]] && private=1; shift;;
					-s) [[ $sunset == 0 ]] && sunset=$2; shift 2;;
					[!-]*) [[ $info == 0 ]] && info=$1; shift;;
					*) echo "invalid args"; exit;;
				esac
			done
			[ $stdin ] && break
		;;
		d) [ $pb_op ] && echo "Only one operation permitted at a time" && exit; pb_op=delete;;
		da) [ $pb_op ] && echo "Only one operation permitted at a time" && exit; pb_op=delete-all;;
		db) [ $pb_op ] && echo "Only one operation permitted at a time" && exit; pb_op=database;;
		*) echo "invalid args"; exit;;
	esac
done
echo "Stdin $stdin"
case $pb_op in
	clipboard) echo "Clipboard";;
	create) echo "Creating";;
	delete) echo "Deleting";;
	database) echo "Dumping db";;
	delete-all) echo "Deleting all";;
esac
echo -e "Name $info\n"
echo -e "Private $private\n"
echo -e "Sunset $sunset\n"
# stdin=0
# while [ "$#" -gt 0 ]; do
# 	case $1 in
# 		c)
# 			[ $operation ] && echo "Only one operation at time" && exit
# 			operation=create
# 			if [ ! -t 0 ]; then
# 				[ $# -gt 1 ] && [[ ! $2 =~ (-p|-s) ]] && echo "Please fix the command" && exit
# 				stdin=1
# 				IFS=$'\n'
# 				info=$(</dev/stdin)
# 				echo $info
# 			else
# 				[[ $2 =~ (-p|-s) ]] && info=$3
# 				[[ ! $2 =~ (-p|-s) ]] && info=$2
# 			fi;;
# 		-p|--private) echo "private"; private=1;;
# 		-s|--sunset) echo "sunset"; sunset=$3;;
# 		d)
# 			[ $operation ] && echo "Only one operation at time" && exit
# 			info=$2
# 			operation=delete
# 		;;
# 		da)
# 			[ $operation ] && echo "Only one operation at time" && exit
# 			info=$2
# 			operation=delete-all
# 		;;
# 		db)
# 			[ $operation ] && echo "Only one operation at time" && exit
# 			info=$2
# 			operation=delete-db
# 		;;
# 		-*) echo "Invalid flag"; exit;;

# 	esac
# 	shift
# done
# case $operation in
# 	create) echo -e "Create: $info stdin: $stdin";;
# 	delete) echo -e "Delete: $info stdin: $stdin";;
# 	delete-all) echo -e "Delete-all: $info stdin: $stdin";;
# 	delete-db) echo -e "Delete-db: $info stdin: $stdin";;
# esac



# while getopts ":s:c:p" opt; do
# 	case $opt in
# 		c)
# 			case $opt in
# 				p)
# 					echo "Private $opt"
# 					;;
# 			esac
# 			echo "Create $opt"
# 			;;
# 		d);;
# 		da);;
# 		db);;
# 		\?);;
# 	esac
# done
# while getopts "r" opt; do
# 	echo $opt
# done