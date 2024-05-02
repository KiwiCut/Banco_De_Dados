CREATE  MASTER KEY ENCRYPTION BY PASSWORD = 'PASSWORD@123'

CREATE CERTIFICATE certificadoDeCriptografia WITH SUBJECT = 'Certificado de criptografia'

Create symmetric key MinhaChave with algorithm = AES_256 ENCRYPTION by CERTIFICATE certificadoDeCriptografia


select * from sys.symmetric_keys

select * from sys.certificates

select * from kiwicut.Cliente


--P A R A   C R I P T O G R A F A R:
BEGIN
    OPEN symmetric key MinhaChave
    Decryption by certificate certificadoDeCriptografia
    insert into kiwicut.Cliente 
    VALUES
    ('Felipe','Manuel','manuelFelipe@gmail.com','21946280156','98451326051','62154302','2024-07-07', EncryptByKey(Key_GUID('MinhaChave'), 'NationalIDNumber'))
END

--P A R A   D E S C R I P T O G R A F A R 
BEGIN
    OPEN symmetric key MinhaChave
    Decryption by certificate certificadoDeCriptografia
    select c.nome +' '+c.sobrenome as 'Nome', c.senha, CONVERT(varchar,DECRYPTBYKEY(c.senha)) as 'Senha sem cripto' from kiwicut.Cliente as c
END

select * from kiwicut.Cliente