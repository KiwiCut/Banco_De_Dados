create schema kiwicut

create table kiwicut.Cliente(
    nome varchar(15) not null,
    sobrenome varchar(25) not null,
    id int PRIMARY key IDENTITY,
    email varchar(35) not null unique,
    telefone char(11) not null unique,
    senha varchar,
    cpf char(11) not null UNIQUE,
    cep char(9) not null,
    dataNascimento date
)
create table kiwicut.Show(
    id int PRIMARY key IDENTITY,
    localCep char(9) not null,
    dataShow date,  
)
Create table kiwicut.Ingresso(
    cpfCliente char(11) not null,
    idShow int not null,
    idIngresso nvarchar not null,
    FOREIGN key (cpfCliente) REFERENCES kiwicut.Cliente(cpf),
    FOREIGN KEY (idShow) REFERENCES kiwicut.Show(id)
)

