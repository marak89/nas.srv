#!/bin/sh
if [ -n "$1" ]
then

HOST=$1
USER='bkp'
PASSWD=''
FILE='./naskeys'

ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
binary
put $FILE
quit
END_SCRIPT
exit 0
else
echo "Podaj adres IP"
fi
