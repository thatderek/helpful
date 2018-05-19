#!/bin/bash 
#
# Writing a dockerfile? 
# Use this script to monitor for saves
# and then build your dockerfile
# 
# Sending a SIGINT (control+c) will override monitoring and rebuild
# Dockerfile. Sending 2 INTs in rapid succession will exit script.

run_func () {
  docker build -t testsomerando .
}

handle_int() { 
  trap handle_double_int INT
  sleep 1
  trap handle_int INT
  echo "INT caught, running...\n"
  run_func
}

handle_double_int() { 
  echo "INT-INT caught, killing..."
  exit 0
}
  

filename='Dockerfile'
OG_VALUE=`openssl md5 $filename`
echo "og value is $OG_VALUE"

trap handle_int INT

while :
do
  sleep 1 
  TEMP_VALUE=`openssl md5 $filename`  
  if [ "$TEMP_VALUE" != "$OG_VALUE" ]
  then
    echo "temp value, $TEMP_VALUE, $OG_VALUE"
    OG_VALUE=`openssl md5 $filename`
    run_func
  fi
done
