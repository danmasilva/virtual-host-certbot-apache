# virtual-host-certbot-apache

Script criado para criar e configurar um novo virtualHost num servidor funcionando com apache2, após é feita a configuração do certificado utilizando certbot/letsencript.

## Getting Started

A utilização básica do script é:
```
./script-config-host.sh example.com 1
```
Onde o primeiro parâmetro indica o domínio e o segundo indica se esse domínio possui como alias 'www.example.com' (1-SIM, 2-NÃO).
** O domínio deve ser escrito sem www, a não ser que o único host seja www.example.com. **
Caso não queira usar parâmetros, basta rodar o comando
```
./script-config-host.sh
```

E seguir as instruções.
Primeiro: indicar url do domínio. É importante que o domínio seja escrito sem www, para que a criação do host seja feita corretamente.
Segundo: indicar se url possui alias 'www'. Caso positivo, digite 1, caso contrário 2.
Terceiro: Confirmar as informações. Os dados coletados são impressos na tela. Se estiverem corretos, digite 1 para começar a criação do script, ou 2 para sair.
### Prerequisites

Apache2 instalado;
Módulo para virtualHosts ativado;
certbot/letsencript instalado
Módulo do apache para certbot instalado: 
```
sudo apt-get install python-certbot-apache
```
Permissão de superusuário!

