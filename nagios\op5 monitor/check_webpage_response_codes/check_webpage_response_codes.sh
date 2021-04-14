#!/bin/bash

# Created: 2021-04-14
# Author: Tim Wetterek Andersson
# Contact: tim@wetterek.se

if [[ -z "$1" ]]
then
        echo "check_webpage_response_code.sh"
        echo ""
        echo "Syntax:" 
        echo "./check_webpage_response_code.sh url"
        echo ""
        echo "The plugin returns exit code under the following circumstances:"
        echo "* OK = Response code is 200"
        echo "* Warning = Response code is 503"
        echo "* Critical = Response code is 504"
        echo "* Unknown = Wrongly formatted arguments"
        echo ""
        exit 3
fi

var_input=$(echo $1)
var_exitcode=0

var_status=$(curl -s -i $1 | grep 'HTTP')

if [[ $var_status == *"200"* ]]; then
	echo "Everyhting is fine!" $var_status
	var_exitcode=0

elif [[ $var_status == *"503"* ]]; then	
	echo "Something went wrong!" $var_status
	var_exitcode=1

elif [[ $var_status == *"504"* ]]; then
	echo "Timeout!" $var_status
	var_exitcode=2

else
	var_exitcode=3
	echo "Error! Check input/syntax."

fi

exit $var_exitcode
unset 1
unset var_input
unset var_exitcode
unset var_status
