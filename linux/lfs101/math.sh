#/bin/bash

add() {
	ans=$(($1+$2))
	echo "Adding $1 and $2 equals $ans"
}
#--------------------------------------------------
multi() {
	ans=$(($1*$2))
	echo "Multipling $1 and $2 equals $ans"
}
#--------------------------------------------------
divide() {
	ans=$(($1/$2))
	echo "Dividing $1 and $2 equals $ans"
}
#--------------------------------------------------
sub() {
	ans=$(($1-$2))
	echo "Subtract $1 and $2 equals $ans"
}
#--------------------------------------------------
expo() {
	ans=$(($1**$2))
	echo "$1 raised to $2 equals $ans"
}
#--------------------------------------------------

echo "What operator would you like to use?"
echo "1. Add 2. Subtract 3. Divide 4. Multiple 5. Exponentiation"
read value

echo "What is number 1?"
read num1

echo "What is number 2?"
read num2

echo ""


if [ $value -eq 1 ]
then	
	add $num1 $num2	
elif [ $value -eq 2 ]
then	
	sub $num1 $num2
elif [ $value -eq 3 ]
then	
	divide $num1 $num2	
elif [ $value -eq 4 ]
then	
	multi $num1 $num2	
elif [ $value -eq 5 ]
then	
	expo $num1 $num2	
else
	echo "Wrong value entered"
fi
