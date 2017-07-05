#!/bin/bash 
#
# Writing something in Lambda? 
# Use this script to monitor for saves
# and then run your code in a clone of the lambda env.
#
filename='python_function.py'
OG_VALUE=`md5 -q $filename`
echo "og value is $OG_VALUE"

while :
do
  sleep 1 
  TEMP_VALUE=`md5 -q $filename`  
  if [ "$TEMP_VALUE" != "$OG_VALUE" ]
  then
    echo "temp value, $TEMP_VALUE, $OG_VALUE"
    OG_VALUE=`md5 -q $filename`
    python $filename
  fi
done
