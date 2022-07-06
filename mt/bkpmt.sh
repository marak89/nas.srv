#!/bin/bash

if [ -n "$1" ]
then

echo "Wykonywanie kopii MikroTika o adresie ip: " $1
DATAKOPII=`date "+%Y_%m_%d_%H_%M"`

echo "do magic"

ssh -t bkp@$1 ':log info "STARTING BACKUP";
:global filename;
:global date [/system clock get date];
:global time [/system clock get time];
:global name [/system identity get name];
:global months ("jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec");
:global varHour [:pick $time 0 2];
:global varMin [:pick $time 3 5];
:global varSec [:pick $time 6 8];
:global varMonth [:pick $date 0 3];
:set varMonth ([ :find $months $varMonth -1 ] + 1);
:if ($varMonth < 10) do={ :set varMonth ("0" . $varMonth); }
:global varDay [:pick $date 4 6];
:global varYear [:pick $date 7 11];
:set filename ("" .$name. "-" .$varYear."-".$varMonth."-".$varDay."-".$varHour.$varMin.$varSec);
/system backup save dont-encrypt=yes name=$filename;
:log info "DELAY 3S"
:delay 3s;
:log info "GENERATING RSC";
/export terse file=($filename."");;
/export terse verbose file=($filename."-verbose");;
:log info $filename;
:delay 1s;
/file print file=lastbkp
:delay 1s;
/file set lastbkp.txt contents=$filename;
:delay 1;
quit;'

scp bkp@$1:/lastbkp.txt ./

FILENAME=$(<lastbkp.txt)

FILEBKP="${FILENAME}.backup"
FILERSC="${FILENAME}.rsc"
FILERSCVERB="${FILENAME}-verbose.rsc"

echo "prefix pliku: " $FILENAME
echo "nazwa pliku backup: " $FILEBKP
echo "nazwa pliku rsc: " $FILERSC
echo "nazwa pliku rsc verb: " $FILERSCVERB

scp bkp@$1:/$FILEBKP  /home/bkp/mikrotik/
scp bkp@$1:/$FILERSC  /home/bkp/mikrotik/
scp bkp@$1:/$FILERSCVERB  /home/bkp/mikrotik/

ssh -t bkp@$1 "
/file remove $FILEBKP
/file remove $FILERSC
/file remove $FILERSCVERB
quit
"

echo "end do magic"
else
echo "Nie podano adresu MikroTika"
fi
