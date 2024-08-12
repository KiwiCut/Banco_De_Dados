drop schema kiwicut


create table showme.Cliente(
    id int PRIMARY key IDENTITY,
    nome varchar(15) not null,
    sobrenome varchar(25) not null,
    email varchar(35) not null unique,
    telefone char(11) not null unique,
    senha varbinary(128) not null,
    cpf varbinary(128) not null UNIQUE,
    cep char(9) not null,
    dataNascimento date
)
create table showme.Show(
    id int PRIMARY key IDENTITY,
    idArtista int not null,
    nome varchar(50) not null,
    localCep char(9) not null,
    dataShow date,  
    FOREIGN KEY (idArtista) REFERENCES showme.Artista(id)
)
Create table showme.Ingresso(
    cpfCliente varbinary(128) not null,
    idShow int not null,
    idIngresso nvarchar not null PRIMARY key,
    cnpj varbinary(128) not null, 
    FOREIGN key (cpfCliente) REFERENCES showme.Cliente(cpf),
    FOREIGN KEY (idShow) REFERENCES showme.Show(id),
    FOREIGN key (cnpj) REFERENCES showme.Empresa(cnpj)
)

CREATE TABLE showme.Artista(
    id int IDENTITY PRIMARY key,
    nome varchar(50) not null unique
)

CREATE TABLE showme.Empresa(
    id int IDENTITY PRIMARY key,
    cnpj varbinary(128) not null UNIQUE,
    nome varchar(50) not null,
    email varchar(35) not null UNIQUE,
    telefone char(11) not null unique,
    senha varbinary(128) not null
)

drop TABLE showme.Empresa
drop TABLE showme.Ingresso