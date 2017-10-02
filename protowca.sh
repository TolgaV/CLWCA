#!/bin/bash
#declaring a string variable
#Wireless Connection Command Line Automator
STRING2="ESSID"
COUNTER="1"
MYPWD=$(pwd)
echo -e "Later you can check the recent networks around you from : " $MYPWD"/"$STRING2".txt\n"
#or MYPWD=${pwd}
#-e flag enables \n escape
echo -e $STRING2".txt is being updated\n. . .\n"
sudo iwlist wlan1 scan | grep $STRING2 | grep -n $STRING2 > $STRING2.txt # | sed -i# #s/ //g $STRING2.txt > $STRING2.txt
sed -i -r -e 's/\s+//g' -e 's/:ESSID//' $MYPWD"/"$STRING2".txt"
chmod 775 $MYPWD/$STRING2.txt
cat $MYPWD/$STRING2.txt
# -i flag allowed the rewriting of ESSID.txt
NUMLINE=$(sudo cat $MYPWD/$STRING2.txt | wc -l)
echo -e "\n. . ."
echo -e "\nThere are "$NUMLINE " visible networks\n"

echo -e "\nWritten in July 2015\n\n"
read -t 5 -p "Enter header number of the desired network : " NUMBER
if [ $NUMBER -gt $NUMLINE ]
then
echo -e "\nFailed to choose an available network"
echo -e "\nTerminating..."
exit
fi
CHOSEN=$(grep ^$NUMBER: $MYPWD"/"$STRING2".txt" | sed 's/.\{0,2\}://')
echo -e "\nNetwork you have chosen : " $CHOSEN"\n\n"
#echo -e \nNetwork you have chosen :  $(grep ^$NUMBER: $MYPWD/$STRING2.txt | sed s/.\{0,2\}://')\n\n"
#The grep in line above was a pain in the
#Weird parameters in sed are for removing n number of chars before the keyword <:> and its just 2 now
read -t 10 -p "Please enter the password for $CHOSEN : " PASSWORD
#cat > /home/pi/newinterfaces
echo -e "auto wlan0\niface wlan0 inet dhcp\nwpa-ssid $CHOSEN \nwpa-psk \"$PASSWORD\"" > /etc/network/interfaces
#tab is \t
#newline is \n
#quote is \"
#while [ $COUNTER -le $NUMLINE ]
#do
#	echo $COUNTER
#	if [[ $number -eq *:" ]]
#	then
#	echo It's there";
#	fi
#COUNTER=$[$COUNTER+1]
#done
#read -p Enter a number again :  " newnumber
#sudo iwlist wlan1 scan | grep $STRING2 | grep
#if grep -q $number  $ESSID"; then
#fi

#I"m gonna put those colorful text just as in the startup [ ok ] [ fail ] etc.

sudo ifdown wlan0
sudo ifup wlan0
