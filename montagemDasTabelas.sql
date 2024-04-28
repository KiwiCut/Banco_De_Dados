--create schema kiwicut

create table kiwicut.Cliente(
    id int PRIMARY key IDENTITY,
    nome varchar(15) not null,
    sobrenome varchar(25) not null,
    email varchar(35) not null unique,
    telefone char(11) not null unique,
    senha nvarchar(MAX),
    cpf char(11) not null UNIQUE,
    cep char(9) not null,
    dataNascimento date
)
create table kiwicut.Show(
    id int PRIMARY key IDENTITY,
    idArtista int not null,
    nome varchar(50) not null,
    localCep char(9) not null,
    dataShow date,  
    FOREIGN KEY (idArtista) REFERENCES kiwicut.Artista(id)
)
Create table kiwicut.Ingresso(
    cpfCliente char(11) not null,
    idShow int not null,
    idIngresso nvarchar not null PRIMARY key,
    FOREIGN key (cpfCliente) REFERENCES kiwicut.Cliente(cpf),
    FOREIGN KEY (idShow) REFERENCES kiwicut.Show(id)
)
CREATE TABLE kiwicut.Artista(
    id int IDENTITY PRIMARY key,
    nome varchar(50) not null unique
)