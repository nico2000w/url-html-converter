#!/bin/bash
clear
NC='\033[0m'
RED='\033[0;41m'
YELLOW='\033[1;43m'
BLUE='\033[0;44m'
BLACK='\033[0;40m'
GREY='\033[2;40m'

getcols=`tput cols`
getline=`tput lines`
printnewln(){
	for e in `seq 1 $3`;do echo -ne "$1$2";done
}
printwindow(){
	for e in `seq 1 $((getcols*(getline-$3)))`;do echo -ne "$1$2";done
}
printnewln "$RED" "#" "$getcols"
printnewln "$RED" "#" "$((getcols/2-11))"
echo -ne " URL - HTML CONVERTER "
if [[ $getcols -gt 202 || $getcols -lt 138 ]];then 
	printnewln "$RED" "#" "$((getcols/2-10))"
elif [[ $getcols -lt 203 && $getcols -gt 137 ]];then 
	printnewln "$RED" "#" "$((getcols/2-11))"
fi
printnewln "$RED" "#" "$getcols"
printnewln "$BLUE" " " "$getcols"
echo -ne "${YELLOW}[1]${BLUE} FILES IN CURRENT REPOSITORY"
printnewln "$BLUE" " " "$((getcols-32))"
echo -e " "
echo -ne "${YELLOW}[2]${BLUE} RECURSIVITY MODE"
printnewln "$BLUE" " " "$((getcols-21))"
echo -e " "
echo -ne "${YELLOW}[3]${BLUE} SEARCH BY NAME"
printnewln "$BLUE" " " "$((getcols-19))"
echo -e " "
echo -ne "${YELLOW}[4]${BLUE} EXIT"
printnewln "$BLUE" " " "$((getcols-9))"
echo -e " "
printnewln "$BLUE" " " "$getcols"
echo -ne "${BLACK}CHOOSE AN OPTION:"
printnewln "$BLACK" " " "$((getcols-17))"
printnewln "$BLACK" " " "$getcols"
printwindow "$BLACK" " " "11"
echo -ne "$BLACK"
read -s option

case $option in

1)

find . -name "*.url" > /tmp/files_url.txt
num_urls=`wc -l < /tmp/files_url.txt`
if [[ $num_urls -eq 0 ]];then echo -e "$GREY"; echo -e "ANY FILE WITH URL EXTENSION IN DIRECTORY";echo -ne "ENDING";sleep 1;echo -ne ".";sleep 1;echo -ne ".";sleep 1;echo -ne ".";sleep 1;echo -ne ".";echo -e "$NC";clear exit;fi
n=1
num_urls2=`awk -v r=$num_urls 'BEGIN { rounded = sprintf("%.0f", r/10); print rounded }'`
lines2=10
l=0
while [[ $l -ne $num_urls2 ]];do
if [[ -l -ne 0  ]];then
	head -n $lines2 /tmp/files_url.txt | tail $((num_urls-lines2)) > /tmp/files_url2.txt
elif [[ -l -eq 0 ]];then
	head -n $lines2 /tmp/files_url.txt > /tmp/files_url2.txt
fi
while read line;do
		echo -e "${GREEN}["${n}"]${NC}" ${line:2}
		n=$((n+1))
done < /tmp/files_url2.txt
echo -e "${GREEN}[*]${NC} ALL FILES"
n=1

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
		search_file=`sed -n ${file:x:1}p /tmp/files_url2.txt`
		if [[ "$search_file" == "$line" ]];then
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
		fi
        done < /tmp/files_url2.txt
	echo -e ""
	echo -e "Delete .url files? [Y]Yes / [N]No"
	echo -e ""
	read del_url_files
	answer=0
	while [[ $answer -eq 0  ]];do
		if [[ $del_url_files == *"Y"* ]];then
			while read line;do
				if [[ "$search_file" == "$line" ]];then
					rm $line
				fi
			done < /tmp/files_url2.txt
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
fi;
l=$((l+1))
line=$((line+10))
lines2=$((lines2+10))
rm /tmp/files_url2.txt
done
clear
exit
;;

4)
echo -ne "$BLACK"
echo -e "$GREY"
echo -ne "ENDING";sleep 1;echo -ne ".";sleep 1;echo -ne ".";sleep 1;echo -ne ".";sleep 1 
echo -ne "$NC"
clear
exit
;;

*)
;;

esac
clear
exit
