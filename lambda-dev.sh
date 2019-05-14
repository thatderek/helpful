#!/bin/bash 
#
# Writing something in Lambda? 
# Use this script to monitor for saves
# and then run your code in a clone of the lambda env.
#
# call this app with the first argument being the name of the file to watch.
#
# If you need to pass it data like you might get from a CWE or whatnot, save 
# it to the same directory as event_payload.json

while true;do
  while inotifywait -q -e modify $1 ; do echo "supp" > /dev/null; done
  echo -e "\n\n=======\n"
  docker run --rm \
    -e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" \
    -e "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" \
    -v `pwd`:/var/task \
    -v ~/.aws/:/home/sbx_user1051/.aws:ro \
    lambci/lambda:python3.7 lambda_function.lambda_handler `cat event_payload.json 2> /dev/null`
done
~                                                                                                                  
~                                                                                                                  
~                                                                                                                  
~                                                                                                                  
~                                                                                                                  
~                                                                                                                  
~              
