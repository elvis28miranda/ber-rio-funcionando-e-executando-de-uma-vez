create database bercario03;
use bercario03;

-- ------------- ENDEREÇOS ------------- 

create table enderecos(
id_endereco int primary key,
cep varchar(10),
rua varchar(255),
numero varchar(10),
complemento varchar(50),
bairro varchar (100),
cidade varchar (100),
estado varchar (50)
);

LOAD DATA INFILE 'C:\\Users\\0040482311010\\Downloads\\registorsIA.csv'
INTO TABLE enderecos
FIELDS TERMINATED BY ','   -- Delimitador de campo para TSV é '\t'
ENCLOSED BY '"'             -- Opcional
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id_endereco, cep, rua, numero, complemento, bairro, cidade, estado);



-- ------------- GENITORES ------------- 

create table genitores (
id_genitores int primary key,
nome varchar(255),
rg varchar (20) unique,
sexo char(1),
data_nascimento date,
telefone varchar(15),
id_endereco int,
 foreign key (id_endereco) references enderecos (id_endereco)
);

LOAD DATA INFILE 'C:\\Users\\0040482311010\\Downloads\\registorsIAGenitores.csv'
INTO TABLE genitores
FIELDS TERMINATED BY ','   -- Delimitador de campo para TSV é '\t'
ENCLOSED BY '"'             -- Opcional
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id_genitores, nome, rg, sexo, data_nascimento, telefone, id_endereco);



-- ------------- BEBES ------------- 

create table bebes(
id_bebe int primary key,
nome varchar(255),
data_hora_nascimento datetime,
sexo char(1),
peso decimal (5,2),
altura decimal (5,2),
tipo_parto varchar(50),
id_pai int, foreign key (id_pai) references genitores (id_genitores),
id_mae int, foreign key (id_mae) references genitores (id_genitores)
);

LOAD DATA INFILE 'C:\\Users\\0040482311010\\Downloads\\registorsIABebes.csv'
INTO TABLE bebes
FIELDS TERMINATED BY ','   -- Delimitador de campo para TSV é '\t'
ENCLOSED BY '"'             -- Opcional
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id_bebe, nome, data_hora_nascimento, sexo, peso, altura, tipo_parto, id_pai, id_mae);


-- ----------- IMPORTANDO TODOS JUNTOS ----------





-- ------------- CARGOS ------------- 

create table cargos(
id_cargo int primary key,
descricao_cargo varchar(100)
);

-- ------------- PROFISSIONAIS DE SAUDE ------------- 

create table profissionais_saude(
id_profissional int primary key,
nome varchar(255) not null,
rg varchar(20) unique not null,
cpf varchar(14) unique not null,
data_nascimento date,
registro_ordem varchar(50),
id_cargo int,
 foreign key(id_cargo) references cargos (id_cargo)
);

-- ------------- PROFISSIONAIS BEBE ------------- 
create table profissionais_bebe(
id_bebe int, 
id_profissional int, 
primary key (id_bebe, id_profissional),
foreign key (id_bebe) references bebes(id_bebe),
foreign key (id_profissional) references profissionais_saude(id_profissional)
);

-- ------------- usuarios ------------- 

create table usuarios(
id_usuario int primary key,
nome varchar(255),
email varchar(255) unique,
senha varchar (255),
ativo boolean
);

-- ------------- LOGINS ------------- 

create table logins (
id_login int primary key,
id_usuario int,
foreign key (id_usuario) references usuarios(id_usuario),
data_hora_login datetime,
ip_login varchar(45)
);

-- ------------- PAPEIS ------------- 
create table papeis(
id_papel int primary key,
nome_papel varchar(100) unique
);
-- ------------- PERMISSOES ------------- 
create table permissoes(
id_permissoes int primary key,
nome_permissoes varchar(100)
);
-- ------------- PAPEL PERMISSOES ------------- 
create table papel_permissoes(
id_papel int, 
id_permissao int, 
primary key (id_papel , id_permissao),
foreign key (id_papel ) references papel(id_papel ),
foreign key (id_permissao) references permissao(id_permissao)
);

-- ------------- USUARIOS PAPEIS ------------- 

create table usuario_papel(
id_usuario int, 
id_papel int, 
primary key (id_papel , id_usuario),
foreign key (id_usuario) references usuarios (id_usuario),
foreign key (id_papel ) references papeis(id_papel )
);
