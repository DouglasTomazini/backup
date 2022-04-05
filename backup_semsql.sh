#! /bin/bash

dominio="douglastomazini.tk"
data='date +%d_%m_%y'
user="douglastomazini"

#--------------------------------FTP---------------------

mkdir -p backup

echo "Iniciando compactação do FTP em: " $($data) >> /backup/log.txt
tar -czf /backup/$($data)$dominio.tar.gz /home/$user/
echo "Compactação de FTP realizada com sucesso em: " $($data) >> /backup/log.txt


#----------------------------removendo os backups antigos-----------


find /backup -name "*.tar.gz" -type f -mtime +7 -exec rm -f {} \;
