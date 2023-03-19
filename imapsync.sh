#!/bin/bash
# Author: Alisson Guedes

LOG=/root/imapsync.log

echo "Informe a localização do arquivo com as contas (/root/contas.txt):"
read ARQ_TXT

if [[ $ARQ_TXT == '' ]]
then
	ARQ_TXT=/root/contas.txt
fi

echo "Arquivo de contas selecionado $ARQ_TXT"
echo "Informe o endereço do servidor de origem de onde serão migrados os e-mails (IP/DOMÍNIO):"
read HOST_1

if [[ ! $HOST_1 ]]
then
	echo "O endereço do servidor deve ser informado. Por favor, inicie novamente!"
	exit 0
fi

echo "Informe a senha padrão das contas de e-mail no servidor de origem:"
read -s PASS_1

echo "Informe o endereço do servidor de destino para onde serão migrados os e-mails (IP/DOMÍNIO):"
read HOST_2

if [[ ! $HOST_2 ]]
then
	echo "O endereço do servidor deve ser informado. Por favor, inicie novamente!"
	exit 0
fi

echo "Informe a senha padrão das contas de e-mail no servidor de destino:"
read -s PASS_2

echo "A migração iniciará com os dados informados abaixo:"

echo "-----------------------------"
echo "Arquivo de contas: $ARQ_TXT"
echo "Servidor de origem: $HOST_1"
echo "Servidor de destino: $HOST_2"
echo "-----------------------------"

echo "Prosseguir? (y)"
read GO

if [[ $GO == 'y' || $GO == 'yes' ]]
then

	for i in `cat $ARQ_TXT`
	do
		echo "Iniciando a migração da conta $i" >> $LOG
		imapsync \
		--host1 $HOST_1 \
		--user1 $i \
		--password1 $PASS_1 \
		--ssl1 \
		--host2 $HOST_2 \
		--user2 $i \
		--password2 $PASS_2 \
		--ssl2 >> $LOG
		echo "Migração da conta $i concluída com sucesso!" >> $LOG
		echo "----------------------------------------------" >> $LOG
	done

	echo "A migração foi finalizada. Todos os detalhes no arquivo de log $LOG."
	exit 0

else
	echo "A operação foi cancelada e a migração não será executada."
	HOST_1=""
	HOST_2=""
	PASS_1=""
	PASS_2=""
	ARQ_TXT=""
	exit 0
fi

echo "Houve algum problema na tentativa da execução. Por favor, contate o suporte."
