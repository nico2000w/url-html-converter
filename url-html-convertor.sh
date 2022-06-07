#!/bin/bash
function goto {
	label=$1
	cmd=$(sed -n "/$label:/{:a;n;p;ba}" $0 | grep -v ':$')
	eval "$cmd"
	exit
}

start=${1:-"start"}

goto $start

start:
n=1
file_trash=0
echo -e '###################################'
echo -e "#   @URL TO HTML FILE CONVERTER   #"
echo -e "###################################"
echo -e ""
echo -e "Insert the file to convert: "
read file
find / -name "$file" > /tmp/find_file.txt
wc -l < /tmp/find_file.txt > /tmp/lines_number.txt
linesnumber=`cat /tmp/lines_number.txt`


trashtest:
trash=0
while read line; do
	if [[ $line == *".Trash"* ]]; then
		trash=1
		goto testlinesnumber
	fi;
done < /tmp/find_file.txt;

testlinesnumber:
if [ $linesnumber -eq 0 ]; then
	goto zerolines
elif [ $linesnumber -gt 1 ] && [ $linesnumber -lt 3 ] && [ $trash -eq 1 ]; then
	goto onelines
elif [ $linesnumber -gt 1 ] && [ $linesnumber -lt 3 ] && [ $trash -eq 0 ]; then
	goto multipleline
elif [ $linesnumber -gt 2 ]; then
	goto multipleline
elif [ $linesnumber -eq 1 ]; then
	goto onelines
fi;
exit



multipleline:
while read line; do
        if [[ $trash -eq 0 ]]; then
		echo -e "Result "$n": "
                echo -e "Result "$n": " >> /tmp/results.txt
		echo -e $line
                echo -e $line >> /tmp/results.txt
                echo -e ""
        fi;
        if [[ $trash -eq 1 ]]; then
                if [[ $line != *".Trash"* ]];then
			echo -e "Result "$n": "
                        echo -e "Result "$n": " >> /tmp/results.txt
			echo -e $line
                        echo -e $line >> /tmp/results.txt
                        echo -e ""
                fi
        fi;
	n=$((n+1))
done < /tmp/find_file.txt;
n=1
goto opciones
exit

onelines:
while read line; do
	if [[ $trash -eq 0 ]]; then
                echo -e "Result "$n": "
                echo -e "Result "$n": " >> /tmp/results.txt
                echo -e $line
                echo -e $line >> /tmp/results.txt
                echo -e ""
        fi;
        if [[ $trash -eq 1 ]]; then
                if [[ $line != *".Trash"* ]];then
                        echo -e "Result "$n": "
                        echo -e "Result "$n": " >> /tmp/results.txt
                        echo -e $line
                        echo -e $line >> /tmp/results.txt
                        echo -e ""
                fi
        fi;
	n=$((n+1))
done < /tmp/find_file.txt;
n=1
goto opciones
exit

zerolines:
echo -e "Not exists any file."
exit


opciones:
echo -e "Insert result: "
read opcion
opcion=$((opcion+1))
file=`sed -n ${opcion}p /tmp/results.txt`


