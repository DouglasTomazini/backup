#! /bin/bash

mysql_host="localhost"
mysql_user="user"
mysql_passwd="password"
base="base"
dominio="domain"
data='date +%d_%m_%y'
#--------------------------------mysql-------------------

mkdir -p backup

echo "Iniciando backup mysql em: " $($data) >> /backup/log.txt

if mysqldump -h$mysql_host -u$mysql_user -p$mysql_passwd $base >> /backup/douglastomazini.sql ; then
    echo "Exportação mysql realizada com sucesso" >> /backup/douglastomazini.sql
else
    echo "Erro ao realizar a exportação mysql, verificar os logs em /backup/log.txt Erro gerado em:" $($data) >> /backup/log.txt
fi    

if tar -czf /backup/$($data)$dominio.sql.tar.gz /backup/$dominio.sql ; then
    echo "compactação do  sql concluída em: " $($data)>>/backup/log.txt
    rm /backup/$dominio.sql
else
    echo "erro na compactação mysql, verificar os logs em /backup/log.txt Erro gerado em:" $($data)>> /backup/log.txt
fi
#--------------------------------FTP---------------------

echo "Iniciando compactação do FTP em: " $($data) >> /backup/log.txt
if tar -czf /backup/$($data)$dominio.tar.gz /home/$dominio/ ; then 
    echo "Compactação de FTP realizada com sucesso em: " $($data) >> /backup/log.txt
else
    echo "Erro na compactação, verificar os logs em /backup/log.txt Erro gerado em:" $($data) >> /backup/log.txt
fi

#----------------------------removendo os backups antigos-----------


find /backup -name "*.tar.gz" -type f -mtime +7 -exec rm -f {} \;
