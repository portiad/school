#/bin/bash

if [ $# -eq 0 ]
then
	echo "Usage: usageLab word"
	exit 1
fi

month=$1

case $month in
	1) echo "January" ;;
	2) echo "Feburary" ;;
	3) echo "March" ;;
	4) echo "April" ;;
	5) echo "May" ;;
	6) echo "June" ;;
	7) echo "July" ;;
	8) echo "August" ;;
	9) echo "September" ;;
	10) echo "October" ;;
	11) echo "November" ;;
	12) echo "December" ;;
	*) echo "Incorrect option entered in" ;;
esac

echo "Give me a number between 1 and 12"
read month

case $month in
	1) echo "January" ;;
	2) echo "Feburary" ;;
	3) echo "March" ;;
	4) echo "April" ;;
	5) echo "May" ;;
	6) echo "June" ;;
	7) echo "July" ;;
	8) echo "August" ;;
	9) echo "September" ;;
	10) echo "October" ;;
	11) echo "November" ;;
	12) echo "December" ;;
	*) echo "Incorrect option entered in" ;;
esac
exit 0
