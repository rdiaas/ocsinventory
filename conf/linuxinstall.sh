#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 05/02/2018
# Data de atualização: 05/02/2018
# Versão: 0.1

# Procedimentos para instalação do Agente do OCS Inventory na Plataforma GNU/Linux
# Script de instalação para distribuição derivadas do Debian (Ubuntu e Linux Mint)
# Adaptar o script para a sua necessidade, para distribuições baseadas no Red Hat
# Utilizar o comando yum, verificar os diretórios também e sua localização.

# Atualizar as listas do apt-get
apt-get update

# Atualizar o sistema
apt-get upgrade

# Atualizar a distribuição
apt-get dist-upgrade

# Instalando o OCS Inventory Agent e suas Dependências.
apt-get install ocsinventory-agent libnet-ssleay-perl libcrypt-ssleay-perl

# Fazendo o download dos arquivos do Servidor OCS Inventory
wget http://ocs.pti.intra/download/ocs.crt
wget http://ocs.pti.intra/download/ocsinventory-agent.cfg

# Copiando o arquivo de Certificado Raiz
cp -v ocs.crt /usr/local/share/ca-certificates/ocs.crt
cp -v ocs.crt /etc/ocsinventory/ocs.crt

# Atualizando o Certififcado Raiz do Desktop
update-ca-certificates

# Testando se o Certificado está funcionando com o wget
wget https://ocs.pti.intra/download/ocs.crt -O /tmp/ocs.crt
read

# Atualizando o arquivo de configuração do OCS Inventory Agent
cp -v ocsinventory-agent.cfg /etc/ocsinventory/ocsinventory-agent.cfg

# Editando o arquivo de configuração do OCS Inventory Agent
vim /etc/ocsinventory/ocsinventory-agent.cfg

# Criando o Diretório de Log OCS Inventory Agent
mkdir -v /var/log/ocsinventory-agent/

# Criando o Arquivo de Log do OCS Inventory Agent
touch /var/log/ocsinventory-agent/activity.log

# Atualizando o Inventário
echo > /var/log/ocsinventory-agent/activity.log
ocsinventory-agent --debug -i

# Verificando o conteúdo do Arquivo de Log do OCS Inventory Agent
less /var/log/ocsinventory-agent/activity.log
