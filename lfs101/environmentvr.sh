#/bin/bash

no="No"
yes="Yes"

num="0"

while [ "$num" -ne 1 ]&&[ "$num" -ne 2 ]
do	
	echo "Please enter in a number 1. Yes or 2. No"
	read newnum
	let num=$newnum
done
if [ "$num" -eq 1 ]
then
	VAR=$yes
else
	VAR=$no
fi

echo "Variable has been set to $VAR"	
