#!/bin/bash
cd /home/bkp/scripts/mt/
echo "Kopia konfiguracji urzadzen MikroTik wg listy z pliku host.list"
readarray listamt < host.list

echo "Wczytane Mikrotiki: "
echo "${listamt[@]}"

for i in "${listamt[@]}"
do : 
   echo "Wykonuje kopie: " $i
   ./bkpmt.sh $i
done
