-- T A B E L A   D E   C L I E N T E S
exec kiwicut.incluirCliente 'Abner', 'Dias', 'abnerdias@gmail.com','11751384186','senha123', '13532122030','656071702','20-11-2000'
exec kiwicut.incluirCliente 'Abner', 'Jonas', 'abnerJonas@gmail.com','11751384189', 'senha123','13532122060','656071701','20-11-2001'
exec kiwicut.incluirCliente 'Maria', 'Carolnia','mariacarolina@gmail.com','829462801562', 'senha123','63095487123','76813544','09-05-2005'



-- T A B E L A   D E   A R T I S T A S
insert into kiwicut.Artista 
values
    ('RacionaisMC'),
    ('Matue'),
    ('Teto'),
    ('Gustavo Lima')

-- T A B E L A   D E   S H O W 
insert into kiwicut.Show
VALUES
    (1,'Rap in Cena','934653840','29-10-2023')

exec kiwicut.incluirShow 4,'Lollapalooza','08090750',"01-08-2024"
-- T A B E L A   D E   I N G R E S S O 
insert into kiwicut.Ingresso
VALUES
    ('13532122030',3,5)



select * from kiwicut.Cliente
SELECT * from kiwicut.Ingresso
select * from kiwicut.Show
SELECT * FROM kiwicut.Artista