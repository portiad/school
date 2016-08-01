#!/bin/sh

printf "Logging Mailer has started.\n"

while true
do
  MESSAGE=$(nc -l -p 3333)
  printf "[Message]: %s\n" "$MESSAGE" >$1
  sleep 1
done
