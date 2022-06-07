#!/bin/bash

echo -e "############################################" 
echo -e "            URL TO HTML CONVERTER           "
echo -e "############################################"
echo -e ""
echo -e ""

find . -name "*.url" > /tmp/files_url.txt
n=1
while read line;do
	echo -e "["${n}"]" ${line:2} 
	n=$((n+1))
done < /tmp/files_url.txt
n=1
if [[ `wc -l < /tmp/files_url.txt` -ne 0 ]];then
	echo -e ""
	echo -e ""
	echo -e "Choose a file for converter to html: "
	read file

	search_file=`sed -n ${file}p /tmp/files_url.txt`
	while read line; do
		if [[ $line == *"URL="* ]]; then
			url=${line:4}
			echo $url
		fi
	done < $search_file

	final_file=${search_file:2:-3}
	final_file=`echo -e ${final_file}"html"`
	touch $final_file
	echo -e "<html>" >> $final_file
	echo -e "	<head>" >> $final_file
	echo -e '		<meta http-equiv="refresh" content="0; url='${url}'" />' >> $final_file
	echo -e "	</head>" >> $final_file
	echo -e "	<body></body>" >> $final_file
	echo -e "</html>" >> $final_file
	echo -e ""
	echo -e ""
	echo -e "FILE HTML CREATED SUCCESFULLY"
else
	echo -e
	echo -e "NOT EXITS ANY FILE WITH URL EXTENSION IN THIS DIRECTORY"
	echo -e "Ending..."
	echo -e
	exit
fi;


