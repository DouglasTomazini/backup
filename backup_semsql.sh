#! /bin/bash

mysql_host="localhost"
mysql_user="user"
mysql_passwd="password"
base="base"
dominio="domain"
bkp_banco="/backup/domain.sql"
data='date +%d_%m_%y'

#--------------------------------FTP---------------------

echo "Iniciando compactação do FTP em: " $($data) >> /backup/log.txt
tar -czf /backup/$($data)domain.tar.gz /home/domain/
echo "Compactação de FTP realizada com sucesso em: " $($data) >> /backup/log.txt


#----------------------------removendo os backups antigos-----------


find /backup -name "*.tar.gz" -type f -mtime +7 -exec rm -f {} \;
