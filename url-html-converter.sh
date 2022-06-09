#!/bin/bash
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;43m'
PURPLE='\033[0;45m'

for e in `seq 1 75`;do echo -ne "${PURPLE}#";sleep 0.02; done;echo -e "";sleep 0.02;echo -ne "#";sleep 0.02;echo -ne "                          ";sleep 0.05;echo -ne "U";sleep 0.05;echo -ne "R";sleep 0.05;echo -ne "L";
sleep 0.05;echo -ne " ";sleep 0.05;echo -ne "H";sleep 0.05;echo -ne "T";sleep 0.05;echo -ne "M";sleep 0.05;echo -ne "L";sleep 0.05;echo -ne " ";sleep 0.05;echo -ne "C";sleep 0.05;echo -ne "O";sleep 0.05;
echo -ne "N";sleep 0.05;echo -ne "V";sleep 0.05;echo -ne "E";sleep 0.05;echo -ne "R";sleep 0.05;echo -ne "T";sleep 0.05;echo -ne "E";sleep 0.05;echo -ne "R";sleep 0.05;echo -ne "                             ";
echo -ne "#";sleep 0.02;echo -e "";sleep 0.02;for e in `seq 1 75`;do echo -ne "#";sleep 0.02; done;echo -e "${NC}";
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

echo -e "${GREEN}[*]${NC} ALL FILES"

n=1
num_urls=`wc -l < /tmp/files_url.txt`
if [[ $num_urls -ne 0 ]];then
	echo -e ""
	echo -e ""
	echo -e "Choose a file for converter to html: "
	read file

        unidad=1
        resultado=0
        if [[ $file == "*" ]];then
                while read line;do
                        file=$((num_urls*unidad))
                        file=$((file+resultado))
                        resultado=$((file))
                        num_urls=$((num_urls-1))
                        unidad=$((unidad*10))
                done < /tmp/files_url.txt
	elif [[ $file == *[[:space:]]* ]];then
		file=`echo $file | tr -d '[:space:]'`
        fi

	x=0
	while read line;do
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
        done < /tmp/files_url.txt
	echo -e ""
	echo -e "Delete .url files? [Y]Yes / [N]No"
	echo -e ""
	read del_url_files
	answer=0
	while [[ $answer -eq 0  ]];do
		if [[ $del_url_files == *"Y"* ]];then
			rm *.url
			echo -e "${GREEN}###############################"
       	 		echo -e "     COMPLETED SUCCESFULLY!"
			echo -e "###############################"
			echo -e "${NC}"
			answer=$((answer=1))
		elif [[ $del_url_files == *"N"* ]];then
              		echo -e "${GREEN}###############################"
              		echo -e "     COMPLETED SUCCESFULLY!"
             		echo -e "###############################"
            		echo -e "${NC}"
              		answer=$((answer=1))
		else : 
		fi
	done
	exit
else
	echo -e
	echo -e "ANY FILE WITH URL EXTENSION IN DIRECTORY"
	echo -e
	echo -e "${NC}"
	exit
fi;
;;

4)
exit
;;

*)
;;

esac
exit
