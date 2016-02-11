#/bin/bash
num=0
message() {
	echo "This message is from message "$1

}
#--------------------------------------------------

while [ $num -ne 1 ]&&[ $num -ne 2 ]&&[ $num -ne 3 ]
do
	echo "Please enter in 1, 2 or 3"
	read newnum
	let num=$newnum
	echo ""
done

message $num
echo ""

#--------------------------------------------------

func4() {
	echo "This message is from function 4"
}

func5() {
	echo "This message is from function 5"
}

#--------------------------------------------------

while [ $num -ne 4 ]&&[ $num -ne 5 ]
do
	echo "Please enter in 4 or 5"
	read newnum
	let num=$newnum
	echo ""
done

func$num
