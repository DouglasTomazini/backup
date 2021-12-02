#! /bin/bash

mysql_host="localhost"
mysql_user="user"
mysql_passwd="password"
base="base"
dominio="domain"
bkp_banco="/backup/domain.sql"
data='date +%d_%m_%y'
#--------------------------------mysql-------------------

mkdir -p backup

echo "Iniciando backup mysql em: " $($data) >> /backup/log.txt
mysqldump -h$mysql_host -u$mysql_user -p$mysql_passwd $base > /backup/douglastomazini.sql

        tar -czf /backup/$($data)domain.sql.tar.gz /backup/domain.sql
        echo "compactação do  sql concluída em: " $($data)>>/backup/log.txt
        rm /backup/domain.sql


#--------------------------------FTP---------------------

echo "Iniciando compactação do FTP em: " $($data) >> /backup/log.txt
tar -czf /backup/$($data)domain.tar.gz /home/domain/
echo "Compactação de FTP realizada com sucesso em: " $($data) >> /backup/log.txt


#----------------------------removendo os backups antigos-----------


find /backup -name "*.tar.gz" -type f -mtime +7 -exec rm -f {} \;
