#!/bin/bash 
#
# Writing something in Lambda? 
# Use this script to monitor for saves
# and then run your code in a clone of the lambda env.
#
filename='prx_create.py'
OG_VALUE=`openssl md5 $filename`
echo "og value is $OG_VALUE"

while :
do
  sleep 1 
  TEMP_VALUE=`openssl md5 $filename`  
  if [ "$TEMP_VALUE" != "$OG_VALUE" ]
  then
    echo "temp value, $TEMP_VALUE, $OG_VALUE"
    OG_VALUE=`openssl md5 $filename`
    python $filename
  fi
done
