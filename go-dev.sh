#!/bin/bash 
#
# Writing something in go?
# Use this script to monitor for saves
# and then run your code.
#
# call this app with the first argument being the name of the file to watch.
# if your app needs a subcommand, make that the second positional argument. 
# ex: go-dev.sh main.go [sub-command]
#

APP_NAME=`pwd | tr '/' '\n'`
APP_NAME=`echo "${APP_NAME##*$'\n'}"`
go run $APP_NAME &
GO_PID=`echo $!`

while true;do
  while inotifywait -q -e modify $1 ; do echo "supp" > /dev/null; done

  echo -e "\n\n=======\n"
  pkill -P $GO_PID
  kill -9 $GO_PID
  date
  go run $APP_NAME $2 &
  GO_PID=`echo $!`

done
