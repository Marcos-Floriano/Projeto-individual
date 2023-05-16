-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql - banco local - ambiente de desenvolvimento
*/

DROP DATABASE aquatech;

CREATE DATABASE aquatech;

USE aquatech;

CREATE TABLE usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
	email VARCHAR(50),
	senha VARCHAR(50)
);

CREATE TABLE aviso (
	id INT PRIMARY KEY AUTO_INCREMENT,
	titulo VARCHAR(100),
	descricao VARCHAR(150),
	fk_usuario INT,
	FOREIGN KEY (fk_usuario) REFERENCES usuario(id)
);

create table aquario (
/* em nossa regra de negócio, um aquario tem apenas um sensor */
	id INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(300)
);

/* esta tabela deve estar de acordo com o que está em INSERT de sua API do arduino - dat-acqu-ino */

create table medida (
	id INT PRIMARY KEY AUTO_INCREMENT,
	dht11_umidade DECIMAL,
	dht11_temperatura DECIMAL,
	luminosidade DECIMAL,
	lm35_temperatura DECIMAL,
	chave TINYINT,
	momento DATETIME DEFAULT CURRENT_TIMESTAMP,
	fk_aquario INT,
	FOREIGN KEY (fk_aquario) REFERENCES aquario(id)
);

SELECT * FROM usuario;

INSERT INTO aquario VALUES
	(1, 'Primeiro Aquario para teste dos dashbords');

INSERT INTO medida VALUES
	(NULL, 55.20, 25.20 , 555, 22.20, 0, DEFAULT ,1),
	(NULL, 55.20, 25.20 , 555, 22.20, 0, DEFAULT ,1),
	(NULL, 54.20, 24.20 , 555, 22.20, 0, DEFAULT ,1),
	(NULL, 54.20, 24.20 , 555, 22.20, 0, DEFAULT ,1),
	(NULL, 53.20, 23.20 , 555, 22.20, 0, DEFAULT ,1),
	(NULL, 53.20, 23.20 , 555, 22.20, 0, DEFAULT ,1),
	(NULL, 52.20, 22.20 , 555, 22.20, 0, DEFAULT ,1),
	(NULL, 52.20, 22.20 , 555, 22.20, 0, DEFAULT ,1),
	(NULL, 51.20, 21.20 , 555, 22.20, 0, DEFAULT ,1),
	(NULL, 51.20, 21.20 , 555, 22.20, 0, DEFAULT ,1),
	(NULL, 50.20, 20.20 , 555, 22.20, 0, DEFAULT ,1),
	(NULL, 50.20, 20.20 , 555, 22.20, 0, DEFAULT ,1);
    
SELECT * FROM medida;

TRUNCATE TABLE medida;

/*
comando para sql server - banco remoto - ambiente de produção
*/

CREATE TABLE usuario (
	id INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(50),
	email VARCHAR(50),
	senha VARCHAR(50),
);

CREATE TABLE aviso (
	id INT PRIMARY KEY IDENTITY(1,1),
	titulo VARCHAR(100),
	descricao VARCHAR(150),
	fk_usuario INT FOREIGN KEY REFERENCES usuario(id)
);

create table aquario (
/* em nossa regra de negócio, um aquario tem apenas um sensor */
	id INT PRIMARY KEY IDENTITY(1,1),
	descricao VARCHAR(300)
);

/* esta tabela deve estar de acordo com o que está em INSERT de sua API do arduino - dat-acqu-ino */

CREATE TABLE medida (
	id INT PRIMARY KEY IDENTITY(1,1),
	dht11_umidade DECIMAL,
	dht11_temperatura DECIMAL,
	luminosidade DECIMAL,
	lm35_temperatura DECIMAL,
	chave TINYINT,
	momento DATETIME,
	fk_aquario INT FOREIGN KEY REFERENCES aquario(id)
);

/*
comandos para criar usuário em banco de dados azure, sqlserver,
com permissão de insert + update + delete + select
*/

CREATE USER [usuarioParaAPIWebDataViz_datawriter_datareader]
WITH PASSWORD = '#Gf_senhaParaAPIWebDataViz',
DEFAULT_SCHEMA = dbo;

EXEC sys.sp_addrolemember @rolename = N'db_datawriter',
@membername = N'usuarioParaAPIWebDataViz_datawriter_datareader';

EXEC sys.sp_addrolemember @rolename = N'db_datareader',
@membername = N'usuarioParaAPIWebDataViz_datawriter_datareader';
