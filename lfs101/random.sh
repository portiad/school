#/bin/bash

if [ $# -eq 0 ]
then
	echo "Usage: usageLab word"
	exit 1
fi

word=$1
number=$RANDOM

echo $word$number

exit 0
