echo "Skrypt do wysylania klucza publicznegoo uzytkownika bkp"
echo "do wskazanego hosta MikroTik"

if [ -n "$1" ]
then

echo "Wysylam klucze do " $1
./sendkey.sh $1
echo "Dodaje " $1 " do host.list"
echo $1 >> host.list
echo "ostatnie linie pliku host.list:"
tail host.list
echo "Dodawanie klucza do uzytkownika mt"
ssh -t bkp@$1 '/user ssh-keys import user=bkp public-key-file=naskeys;quit'
# /user ssh-keys import user=bkp public-key-file=naskeys
echo "test poprawnosci dodania klucza"
ssh -t bkp@$1 '/user ssh-keys print;quit'
echo "test wykonania kopii zapasowej"
./bkpmt.sh $1
else
echo "podaj adres ip jako parametr wywolania skryptu"
echo $0 "11.22.33.44"
fi
