#!/bin/bash
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;43m'
PURPLE='\033[0;35m'

for e in `seq 1 75`;do echo -ne "${PURPLE}#";sleep 0.02; done;echo -e "";sleep 0.02;echo -ne "#";sleep 0.02;echo -ne "                          ";sleep 0.05;echo -ne "U";sleep 0.05;echo -ne "R";sleep 0.05;echo -ne "L";
sleep 0.05;echo -ne " ";sleep 0.05;echo -ne "H";sleep 0.05;echo -ne "T";sleep 0.05;echo -ne "M";sleep 0.05;echo -ne "L";sleep 0.05;echo -ne " ";sleep 0.05;echo -ne "C";sleep 0.05;echo -ne "O";sleep 0.05;
echo -ne "N";sleep 0.05;echo -ne "V";sleep 0.05;echo -ne "E";sleep 0.05;echo -ne "R";sleep 0.05;echo -ne "T";sleep 0.05;echo -ne "E";sleep 0.05;echo -ne "R";sleep 0.05;echo -ne "                             ";
echo -ne "#";sleep 0.02;echo -e "";sleep 0.02;for e in `seq 1 75`;do echo -ne "#";sleep 0.02; done;echo -e "";
echo -e ""
echo -e ""
sleep 0.50
echo -e "${NC}${YELLOW}[1]${NC} FILES IN CURRENT REPOSITORY"
sleep 0.50
echo -e "${YELLOW}[2]${NC} RECURSIVITY MODE"
sleep 0.50
echo -e "${YELLOW}[3]${NC} SEARCH BY NAME"
sleep 0.50
echo -e "${YELLOW}[4]${NC} EXIT"
echo -e ""
echo -e "CHOOSE AN OPTION:"
read option

case $option in 

1)

find . -name "*.url" > /tmp/files_url.txt
n=1
while read line;do
	echo -e "${GREEN}["${n}"]${NC}" ${line:2}
	n=$((n+1))
done < /tmp/files_url.txt
n=1
if [[ `wc -l < /tmp/files_url.txt` -ne 0 ]];then
	echo -e ""
	echo -e ""
	echo -e "Choose a file for converter to html: "
	read file

	x=0
	while [[ $x -lt ${#file} ]];do
		search_file=`sed -n ${file:x:1}p /tmp/files_url.txt`

		while read line; do
			if [[ $line == *"URL="* ]]; then
				url=${line:4}
			fi
		done < "$search_file"

		final_file=${search_file:2:-3}
		final_file=`echo -e ${final_file}"html"`
		touch "$final_file"
		echo -e "<html>" >> "$final_file"
		echo -e "	<head>" >> "$final_file"
		echo -e '		<meta http-equiv="refresh" content="0; url='${url}'" />' >> "$final_file"
		echo -e "	</head>" >> "$final_file"
		echo -e "	<body></body>" >> "$final_file"
		echo -e "</html>" >> "$final_file"
		x=$((x+1))
        done
	echo -e ""
	echo -e "${GREEN}###############################"
        echo -e "     COMPLETED SUCCESFULLY!"
	echo -e "###############################"
	echo -e "${NC}"
	exit
else
	echo -e
	echo -e "ANY FILE WITH URL EXTENSION IN DIRECTORY"
	echo -e
	echo -e "${NC}"
	exit
fi;
;;

*)
;;

esac
