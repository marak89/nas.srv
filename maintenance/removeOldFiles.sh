#!/bin/bash

echo "Codzienne usuwanie starszych plikow"
echo "Czyszczenie katalogu HOSTING "
echo "Ilosc plikow przed usuwaniem"
ls -la /home/bkp/hosting/ | grep -v ^l | wc -l
echo "Rozmiar katalogu kopii przed usuwaniem"
du -sh /home/bkp/hosting/
echo "Usuwanie plikow starszych niz 7 dni ";
find /home/bkp/hosting/ -type f -mtime +7 -exec rm -fr {} +
echo "Ilosc plikow po usuwaniu"
ls -la /home/bkp/hosting/ | grep -v ^l | wc -l
echo "Rozmiar katalogu kopii po usuwaniu"
du -sh /home/bkp/hosting/

echo "Czyszczenie katalogu MIKROTIK "
echo "Ilosc plikow przed usuwaniem"
ls -la /home/bkp/mikrotik/ | grep -v ^l | wc -l
echo "Rozmiar katalogu kopii przed usuwaniem"
du -sh /home/bkp/mikrotik/
echo "Usuwanie plikow starszych niz 7 dni ";
find /home/bkp/mikrotik/ -type f -mtime +7 -exec rm -fr {} +
echo "Ilosc plikow po usuwaniu"
ls -la /home/bkp/mikrotik/ | grep -v ^l | wc -l
echo "Rozmiar katalogu kopii po usuwaniu"
du -sh /home/bkp/mikrotik/
