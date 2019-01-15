# virtual-host-certbot-apache

Script criado para criar e configurar um novo virtualHost num servidor funcionando com apache2, após é feita a configuração do certificado utilizando certbot/letsencript.

## Utilização básica

A utilização básica do script é:
```
./script-config-host.sh example.com 1
```
Onde o primeiro parâmetro indica o domínio e o segundo indica se esse domínio possui como alias www.example.com (1-SIM, 2-NÃO).
**O domínio deve ser escrito sem www, a não ser que o único host seja www.example.com.**
Caso não queira usar parâmetros, basta rodar o comando
```
./script-config-host.sh
```

E seguir as instruções:
- Indicar url do domínio. É importante que o domínio seja escrito sem www, para que a criação do host seja feita corretamente.
- Indicar se url possui alias 'www'. Caso positivo, digite 1, caso contrário 2.
- Confirmar as informações. Os dados coletados são impressos na tela. Se estiverem corretos, digite 1 para começar a criação do script, ou 2 para sair.

### Funcionamento:

Após a confirmação dada, seguem-se os passos:
- É criado uma cópia do sites-available/000-default.conf, cujo nome será igual ao nome do domínio;
- O serverName e o serverAlias serão alterados para o domínio informado, caso não haja serverAlias a linha referente à mesma será deletada;
- Um link desse arquivo é criado para o diretório sites-enabled, necessário para que o certbot consiga criar o certificado;
- O certificado é criado utilizando o certbot. 

### Pré-requisitos

Apache2 instalado;
Módulo para virtualHosts ativado;
certbot/letsencript instalado;
Módulo do apache para certbot instalado: 
```
sudo apt-get install python-certbot-apache
```
Arquivo 000-default.conf na pasta /etc/apache2/sites-available, com o conteúdo:
```
<VirtualHost *:80>
    ServerName example1.com.br
    ServerAlias www.example1.com.br
    Include /etc/apache2/domains-commons.conf
    Include /etc/apache2/force-ssl.conf
</VirtualHost>

```
Esse arquivo será usado como pattern para criação dos novos hosts;
Permissão de superusuário!

