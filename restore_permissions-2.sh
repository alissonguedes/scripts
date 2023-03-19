#!/bin/bash
# Author: Alisson Guedes

for i in `cut /etc/trueuserdomains -d : -f 2`
do

        CONTA=$i

        ID_CONTA=`grep $CONTA /etc/passwd | cut -d : -f 3`
        ID_GRUPO=`grep $CONTA /etc/passwd | cut -d : -f 4`

        find /home/$CONTA -user $ID_CONTA -exec chown -R -h -v $ID_CONTA {} \;
        find /home/$CONTA -group $ID_GRUPO -exec chown -R -h -v :$ID_GRUPO {} \;
        
        # Corrigir permissão do diretório /home/$CONTA/etc para o grupo `mail`
        find /home/$CONTA/etc -type d -user $ID_CONTA -exec chown -h -v :mail {} \;
        
        # Corrigir permissão dos arquivos /home/$CONTA/etc/DOMINIO/{passwd*,quota*} para o grupo `mail`
        find /home/$CONTA/etc/*/{passwd*,quota*} -type f -user $ID_CONTA -exec chown -h -v :mail {} \;
        
        
	# Corrigir permissão do diretório /home/$CONTA/public_html para o grupo `nobody`
        chown :nobody /home/$CONTA/public_html
        
done

