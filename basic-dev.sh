#!/bin/bash 
#
# Writing something in .... anything?
# Use this script to monitor for saves
# and then run your code.
#
# call this app with the first argument being the name of the file to watch
# and the second argument being what to run on that file updating. 
#
# As an example, if you were writing the
# if your app needs a subcommand, make that the second positional argument. 
# ex: go-dev.sh main.go [sub-command]
#
# As an example, if you wanted wanted to run a `go run main.go` on every save to test whether there 
# were any build/runtime errors, you could do the following:
# 
# basic-dev.sh somebasegoappfolder/thefileyouareworkingon.go 'go run main.go'
# 
# Similarly, if you were working on in the terraform-provider-aws repo and wanted to run the testsuite against 
# changes to a file, you could the following:
#
# basic-dev.sh aws/resource_aws_whatever.go 'docker run --rm \
#  -v `pwd`:/go/src/github.com/terraform-providers/terraform-provider-aws \
#  --workdir /go/src/github.com/terraform-providers/terraform-provider-aws \
#  golang:1.13 make test'
#
# 

APP_NAME=`pwd | tr '/' '\n'`
APP_NAME=`echo "${APP_NAME##*$'\n'}"`
$2
APID=`echo $!`

while true;do
  while inotifywait -q -e modify $1 ; do echo "supp" > /dev/null; done

  echo -e "\n\n=======\n"
  pkill -P $APID
  kill -9 $APID
  date
  $2 &
  APID=`echo $!`

done
