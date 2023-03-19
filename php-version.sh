#!/bin/bash
# Author: Alisson Guedes

for i in `cat /etc/trueuserdomains | cut -d ':' -f 2`
do

        cd /home/$i/public_html

        # PHP 5.x.xx

        DIR=`php -v | grep -i "PHP *.*.*"`

        if [[ $(echo $DIR | cut -d ' ' -f 2) < 7 ]]
        then

		echo -e "========================\n\n"
		echo -e "Directory /home/$i/public_html/\n"
		echo $DIR
		echo -e "\n========================\n\n"

        fi

done > /root/php-versions.txt
cd

