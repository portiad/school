#/bin/bash

echo "Please enter in a string."
read string1

echo "Please enter in another string"
read string2

size1=${#string1}
size2=${#string2}


if [ $size1 -eq 0 ]
then
	stext1="String 1 does not exist."
else
	stext1="String 1 does exist."
fi

if [ $size2 -eq 0 ]
then
	stext2="String 2 does not exist."
else
	stext2="String 2 does exist."
fi

echo $stext1 $stext2
if [ $size1 -gt $size2 ]
then
	echo "String 1 ($size1) is bigger then String2 ($size2)."

elif [ $size2 -gt $size1 ]
then
	echo "String 2 ($size1) is bigger then String1 ($size2)."
else
	echo "String 1 and String 2 are equal length."
fi

if [[ "$string1" == "$string2" ]]
then
	echo "String 1 and String 2 are the same string."
else
	echo "String 1 and String 2 are not the same string."
fi

