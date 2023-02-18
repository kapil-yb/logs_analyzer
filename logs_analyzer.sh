#!/bin/bash
filename=$1

help(){
echo "

Usage:
	Syntax: $0 log_file_name [-h|--help]

options:
	log_file_name	Name of the log file which need to be analyze

"
}

while getopts ":h" option; do
   case $option in
      h)
         help
         exit;;
      help)
         help
         exit;;
   esac
done

if [[ ! -f "$filename" ]]; then
	echo "File "$filename" does not exist"
	help
	exit 1
fi

#filename="yb-tserver.yb-prod-cdp-api-n1.yugabyte.log.INFO.20230131-022159.10016"

str1="Number of aborted transactions not cleaned up on account of reaching size limits"
str1_cnt=0
str1_func(){
   echo "
============================================================================
We found following message in the logs
$str1

This typically means that we need to run compaction on offending tablets

Check this case for more details
https://yugabyte.zendesk.com/agent/tickets/5416
============================================================================

"
}



str2="Ignoring partially flushed segment in write ahead log"
str2_cnt=0
str2_func(){
   echo "
============================================================================
We found following message in the logs
$str2

This typically means that we .........

Check this KB for more details
============================================================================

"
}


while IFS=  read -r line
do
	readline=$line
	if [[ $readline == *$str1* && $str1_cnt == 0 ]]; then
		str1_func
		str1_cnt=$((str1_cnt+1))

	elif [[ $readline == *$str2* && $str2_cnt == 0 ]]; then
                str2_func
                str2_cnt=$((str2_cnt+1))

	fi

done < $filename
