#!/bin/bash
#AUTOR: Daniel Marques da Silva
#DATA: 14/01/2018

#Em um novo servidor, o arquivo 000-default.conf em /etc/apache2/sites-available deve
#ter como ServerName example1.com.br e como ServerAlias www.example1.com.br, para que
#o script funcione corretamente.

if [ -z "$1" ]; then
  echo 'Digite o nome do domínio (sem www)'
  read DOMINIO
else
  DOMINIO=$1
fi
if [ -z "$2" ]; then
  echo 'O domínio é '$DOMINIO'. Esse domínio possui www para alias? (1-SIM, 2-NÃO)'
  read ISPOSSUIWWW
elif [ "$2" -eq '1' ]; then
    ISPOSSUIWWW='1'
else
  ISPOSSUIWWW='2'
fi

  sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/$DOMINIO.conf
  sudo sed -i 's/example1.com.br/'$DOMINIO'/g' /etc/apache2/sites-available/$DOMINIO.conf
  if [[ ISPOSSUIWWW -eq '1' ]]; then
    #Server alias será www/domínio e certificado será criado
    sudo sed -i 's/www.example1.com.br/www.'$DOMINIO'/g' /etc/apache2/sites-available/$DOMINIO.conf
    sudo ln -s /etc/apache2/sites-available/$DOMINIO.conf /etc/apache2/sites-enabled/$DOMINIO.conf
    sudo certbot --apache -d $DOMINIO -d www.$DOMINIO
  else
    #Não haverá server alias e certificado será criado
    sudo sed -i '/www.example1.com.br/d' /etc/apache2/sites-available/$DOMINIO.conf
    sudo ln -s /etc/apache2/sites-available/$DOMINIO.conf /etc/apache2/sites-enabled/$DOMINIO.conf
    sudo certbot --apache -d $DOMINIO
  fi

