#!/bin/bash

##
# Search for a class name recursively in multiple jar files.
#
# author: Frank Chen
# date:   2013/11/15
# parameters: $1 path, $2 case insensitive class name
##

if [ ! -d "$1" ];then
    echo "path does not exists!"
    exit
fi

JARS=`find -L $1 -iname "*.jar" 2> /dev/null`
for FILE in $JARS
do
    RESULT=`jar tvf "$FILE" 2> /dev/null | grep -Hsi $2`
    RESULT_LOWER=$( tr '[:upper:]' '[:lower:]' <<< "$RESULT" )
    ARG2_LOWER=$( tr '[:upper:]' '[:lower:]' <<< "$2" )
    if [[ "$RESULT_LOWER" == *$ARG2_LOWER* ]];then
	echo ""
	echo "jar:"
	echo "$FILE"
	echo "result:"
	echo "$RESULT"
	echo ""
    fi
done

echo ""
echo "search finished."
echo ""

