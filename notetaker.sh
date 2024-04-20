#!/bin/bash
file="/Users/michael/work/notes.txt";

# if users input a flag of -o
# open the file in nvim
if [ "$1" == "-o" ]; then
	nvim ${file};
	exit;
fi

# if users input a flag of -f 
if [ "$1" == "-f" ]; then
	# if $2 exists, then grep for it
	if [ "$2" ]; then
		# if $2 is not a vaild date, then exit, if [[ ! "$2" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then echo "Please enter a valid date in the format of YYYY-MM-DD"; exit;
		# output $2 in green
		#awk 'BEGIN { FS="," } ; { print $1 $2 $3 }' ${file} | awk /./ | grep "${2}" | GREP_COLOR='1;32' grep --color=always "${2}";
		if [[ "$3" == "n" ]]; then
			# no color
			awk -F ', ' '{ printf "%s %s %s\n", $1, $2, $3 }' ${file} | grep "${2}";
			exit;
		fi
		echo "finding notes for ${2}";
		awk -F ', ' '{ printf "\033[1;32m%s\033[0m \033[0;33m%s\033[0m %s\n", $1, $2, $3 }' ${file} | grep "${2}";
		echo "Search complete!";
		echo "to output without color use n";
		echo "example run notes -f '$2' n";
		# orginal
		#awk 'BEGIN { FS="," } ; { print $1 $2 $3 }' ${file} | awk /./ | grep "${2}";
		exit;
	fi
	echo "to filter by date use -f and the date you want to search for";
	echo "example run: notes -f 2019-01-01";
	echo "for other searches use the following as a starting point";
	echo "awk 'BEGIN { FS=\",\" } ; { print \$1 \$2 \$3 }' ${file} | awk /./";
	# orginal
	#awk 'BEGIN { FS="," } ; { print $1 $2 $3 }' ${file} | awk /./
	exit;
fi

# if searching for a specific note
if [ "$1" == "-s" ]; then
	# if $2 exists, then grep for it
	if [ "$2" ]; then
		#if $3 is -nc then no color
		if [[ "$3" = 'n' ]]; then
			# no color
			awk -F ', ' '{ printf "%s %s %s\n", $1, $2, $3 }' ${file} | grep "${2}";
			exit;
		fi
		echo "finding notes for ${2}";
		awk -F ', ' '{ printf "\033[1;32m%s\033[0m \033[0;33m%s\033[0m %s\n", $1, $2, $3 }' ${file} | grep "${2}" | GREP_COLOR='1;31' grep --color=always "${2}";
		echo "Search complete!";
		echo "to output without color use n";
		echo "example run: notes -s '$2' n";
		exit;
	fi
	echo "to filter by date use -s and the date you want to search for";
	echo "example run: notes -s 2019-01-01";
	echo "for other searches use the following as a starting point";
	echo "awk 'BEGIN { FS=\",\" } ; { print \$1 \$2 \$3 }' ${file} | awk /./";
	# orginal
	#awk 'BEGIN { FS="," } ; { print $1 $2 $3 }' ${file} | awk /./
	exit;
fi

input="${@}";
# if input is empty
if [ -z "${input}" ]; then
	echo "Please enter a note to save";
	echo -e "\n";
	echo "for other searches use the following as a starting point";
	echo "awk 'BEGIN { FS=\",\" } ; { print \$1 \$2 \$3 }' ${file} | awk /./";
	# search for notes
	echo -e "\n";
	echo "to search for notes use -s and the string you want to search for";
	echo "example run: notes -s 'string'";
	echo -e "\n";
	# filter notes
	echo "to filter by date use -f and the date you want to search for";
	echo "example run: notes -f '2019-01-01'";
	echo -e "\n";
	echo "original file location: run to see: nvim ${file}";
	exit;
fi
# if input \n is in the input, then \\n
if [[ "${input}" == *"\\"* ]]; then
	input=$(echo ${input} | sed 's/\\/\\\\/g');
fi
date=$(date +"%Y-%m-%d");
time=$(date +"%H:%M:%S");
echo -e "${date}, ${time}, ${input}\n" >> ${file};
echo -e "Note saved successfully!" | GREP_COLOR='1;32' grep --color=always "Note saved successfully!";
exit;
