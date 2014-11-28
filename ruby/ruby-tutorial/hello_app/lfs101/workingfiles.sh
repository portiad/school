#/bin/bash
echo "What name is the name of the directory you would like to create"
read direct
mkdir $direct
cd $direct
pwd
echo "Create file 1"
read file1
touch $file1
echo "Create file 2"
read file2
touch $file2
echo "Create file 3"
read file3
touch $file3
echo "The files in $direct are:"
ls -hl
echo "This is $direct/$file1" > $file1
echo "This is $direct/$file2" > $file2
echo "This is $direct/$file3" > $file3 
echo "The contents of the files are:"
cat $file1
cat $file2
cat $file3
