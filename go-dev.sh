#!/bin/bash 
#
# Writing something in go?
# Use this script to monitor for saves
# and then run your code in a clone of the lambda env.
#
# call this app with the first argument being the name of the file to watch.
#
# If you need to pass it data like you might get from a CWE or whatnot, save 
# it to the same directory as event_payload.json

APP_NAME=`pwd | tr '/' '\n'`
APP_NAME=`echo "${APP_NAME##*$'\n'}"`

while true;do
  while inotifywait -q -e modify $1 ; do echo "supp" > /dev/null; done
  echo -e "\n\n=======\n"
  go build && time ./$APP_NAME 
done
~                                                                                                                  
~                                                                                                                  
~                                                                                                                  
~                                                                                                                  
~                                                                                                                  
~                                                                                                                  
~              
