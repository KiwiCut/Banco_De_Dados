-- T A B E L A   D E   C L I E N T E S
exec showme.incluirCliente 'Abner', 'Dias', 'abnerdias@gmail.com','11751384186','senha123', '13532122030','656071702','20-11-2000'
exec showme.incluirCliente 'Abner', 'Jonas', 'abnerJonas@gmail.com','11751384189', 'senha123','13532122060','656071701','20-11-2001'
exec showme.incluirCliente 'Maria', 'Carolnia','mariacarolina@gmail.com','829462801562', 'senha123','63095487123','76813544','09-05-2005'
exec showme.incluirCliente 'Elisabeth', 'Silva','bethMathSilva@gmail.com','954123604587', 'mssql41@','95621306548','30125487','15-09-2006'



-- T A B E L A   D E   A R T I S T A S
insert into showme.Artista 
values
    ('RacionaisMC'),
    ('Matue'),
    ('Teto'),
    ('Gustavo Lima')

-- T A B E L A   D E   S H O W 
insert into showme.Show
VALUES
    (1,'Rap in Cena','934653840','29-10-2023')

exec showme.incluirShowComData 4,'Lollapalooza','08090750',"01-08-2024"
-- T A B E L A   D E   I N G R E S S O 
insert into showme.Ingresso
VALUES
    ('13532122030',3,5)



select * from showme.Cliente
SELECT * from showme.Ingresso
select * from showme.Show
SELECT * FROM showme.Artista