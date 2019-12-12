#!/bin/bash
ip="[0-9]"
touch archivo1.txt
touch archivo2.txt

while IFS=" " read -r uno dos tres cuatro cinco seis siete ocho nueve diez once doce trece catorce quince
do
	if [ $seis = "Failed"  ]
	then
		echo $once >> archivo2.txt
		echo $trece >> archivo2.txt
	fi
done < syslog-sample

sort archivo2.txt > archivo1.txt
rm -rf archivo2.txt
cat archivo1.txt | tr "." ":" | grep "^[^:]*:[^:]*:[^:]*:[^:]*$" | tr ":" "." > archivo2.txt
rm -rf archivo1.txt

sort archivo2.txt | uniq > archivo1.txt

echo "Count,IP,Location"
while read -r line
do
	var1=$(grep $line archivo2.txt | wc -l)
	echo $var1","$line | sort -k1 -g
done < archivo1.txt
