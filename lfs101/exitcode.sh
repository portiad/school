#!/bin/bash
#Searchs for an unknown file and a known file and puts it in a file
ls portia > /dev/null 2>&1
status=$(echo $?)
echo "Status is" $status
touch portia
ls portia > /dev/null 2>&1
status=$(echo $?)
echo "Status is $status"
rm portia
