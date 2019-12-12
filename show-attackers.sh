#!/bin/bash
#https://github.com/a14sertorper/PRACTICA19_PROJECTE04_SERGI_TORREJON_PEREZ

while IFS=" " read -r uno dos tres cuatro cinco seis siete ocho nueve diez once doce trece catorce quince
do
	if [ $seis = "Failed"  ]
	then
		echo $once >> archivo2.txt
		echo $trece >> archivo2.txt
	fi
done < $1

sort archivo2.txt > archivo1.txt
cat archivo1.txt | tr "." ":" | grep "^[^:]*:[^:]*:[^:]*:[^:]*$" | tr ":" "." > archivo2.txt
sort archivo2.txt | uniq > archivo1.txt
echo "Count	IP		Location"

while read -r line
do
	var1=$(grep $line archivo2.txt | wc -l)
	var2=$(geoiplookup $line | cut -d " " -f 5,6)
	if [[ var1 -gt "10" ]]
	then
		echo $var1"	"$line"	"$var2
	fi
done < archivo1.txt
rm -rf archivo1.txt
rm -rf archivo2.txt
