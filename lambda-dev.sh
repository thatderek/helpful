#!/bin/bash 
#
# Writing something in Lambda? 
# Use this script to monitor for saves
# and then run your code in a clone of the lambda env.
#
# call this app with the first argument being the name of the file to watch.

while true;do
  while inotifywait -q -e modify $1 ; do echo "supp" > /dev/null; done
  echo -e "\n\n=======\n"
  docker run --rm \
    -e "INSTANCE_ID=lollol" \
    -e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" \
    -e "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" \
    -v `pwd`:/var/task \
    -v ~/.aws/:/home/sbx_user1051/.aws:ro \
    lambci/lambda:python3.7 lambda_function.lambda_handler
done
~                                                                                                                  
~                                                                                                                  
~                                                                                                                  
~                                                                                                                  
~                                                                                                                  
~                                                                                                                  
~              
