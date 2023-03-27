# Percona toolkit

Percona Toolkit is a collection of advanced open source command-line tools, developed and used by the Percona technical staff, that are engineered to perform a variety of MySQL®, MariaDB®, MongoDB®, and PostgreSQL server and system tasks that are too difficult or complex to perform manually – freeing your DBAs for work that helps you achieve your business goals.

Percona Toolkit supports MySQL, MariaDB, MongoDB, and PostgreSQL.

**Código fonte**: https://github.com/yuuki0xff/docker-percona-toolkit

Para executar a imagem que já possui o percone toolkit instalado basta executar o comando abaixo:

    docker run --rm --net database_percona-teste -ti yuuki0xff/percona-toolkit

## Docker-compose
Para exemplificar a utilização do percona, iremos iniciar um banco de dados Mysql utilizando o arquivo **docker-compose.yml**.
Para executar o arquivo basta digitar: 

Obs.: O comando precisa ser executado no mesmo direório do arquivo do **docker-compose.yml** ou será necessário especificar o caminho usando o parâmetro **-f**.

    docker-compose -p percona up  

Juntamente com o banco de dados estamos subindo um cliente, para facilitar a interação com o banco e executarmos consultas. Para acessar o cliente acessamos o navegador no endereço **http://localhost:8080**.

Será necessário logar usando os seguintes valores:
 - **Sistema**:       Mysql
 - **Servidor**:      mysql
 - **Usuário**:       root
 - **Senha**:         senha
 - **Base de dados**: teste

## Criação das tabelas
Para os testes vamos precisar criar duas tabelas, **country** e **city**. 
Abaixo temos o script de criação das tabelas, mas o docker-composer já fez essa criação e inseriu alguns registros.

    CREATE TABLE `country` (
      `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
      `name` varchar(50) NOT NULL,
      `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8

    CREATE TABLE `city` (
      `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
      `name` varchar(50) NOT NULL,
      `country_id` smallint(5) unsigned NOT NULL,
      `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      PRIMARY KEY (`id`),
      KEY `idx_fk_country_id` (`country_id`),
      CONSTRAINT `fk_city_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON UPDATE CASCADE
    ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8

## Percona - pt-online-schema-change
Alterar tabela sem travá-las.

  **Documentação**: https://www.percona.com/doc/percona-toolkit/3.0/pt-online-schema-change.html

Abaixo temos o exemplo de alteração da tabela **country**, vamos adicionar uma coluna de nome **coluna_1**. Observe que essa coluna é referenciada por uma FK da tabela **city**.

    pt-online-schema-change D=teste,t=country,h=mysql,u=root 
    --execute 
    --alter "ADD COLUMN coluna_1 INT"  
    --alter-foreign-keys-method="rebuild_constraints" 
    --password="senha" 
    --charset="utf8"
    --print 
    --statistic > percona.log 

## Percona - Executando o comando
Precisamos do **Percona toolkit** instalado e para isso vamos utilizar a imagem docker **yuuki0xff/percona-toolkit**.

**Código fonte:** https://github.com/yuuki0xff/docker-percona-toolkit.

Para podemos executar o comando, vamos iniciar um container da imagem **percona-toolkit** usando o comando abaixo. 

Obs.: O container **percona-toolkit** precisa estar na mesma rede que o container de banco de dados para que seja possível acessa-lo. Desta forma confira se o nome da rede usado no comando abaixo é o mesmo gerado pelo docker-compose. Para verificar o nome da rede, bastar executar **docker network ls**.

    docker run --rm --net percona_percona-net -w /percona -ti yuuki0xff/percona-toolkit

Após executar o container estamos logado e com acesso ao percona toolkit. Para realizar um teste execute o comando **pt-online-schema-change --help**. Esse comando deverá exibir a ajuda do comando de alteração de esquema.