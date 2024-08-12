/*
create or alter PROCEDURE showme.incluirShowComData
@idArtista int, @nome varchar(50),@localCep char(9), @dataShow date
AS
BEGIN
    if EXISTS (select nome,idArtista,localCep from showme.Show where nome = @nome and idArtista = @idArtista and localCep = @localCep and dataShow = @dataShow)
    BEGIN
        DECLARE @Mensagem varchar(30)
        set @Mensagem = 'Show idêntico já registrado'
        RAISERROR ('Erro ao incluir um Show: %s', 16, 2, @Mensagem)
    END
    ELSE
    BEGIN
        begin TRANSACTION
        BEGIN TRY  
            insert into showme.Show VALUES (@idArtista,@nome,@localCep,@dataShow)
            COMMIT TRANSACTION
        END TRY  
        BEGIN CATCH 
            ROLLBACK TRANSACTION
            Set @Mensagem = 'Erro interno'
            RAISERROR ('Erro ao cadastrar um show :%s', 16, 2, @Mensagem)
        END CATCH 
    END    
END


create or alter PROCEDURE showme.incluirShowSemData
@idArtista int, @nome varchar(50),@localCep char(9)
AS
BEGIN
    if EXISTS (select nome,idArtista,localCep from showme.Show where nome = @nome and idArtista = @idArtista and localCep = @localCep)
    BEGIN
        DECLARE @Mensagem varchar(30)
        set @Mensagem = 'Show idêntico já registrado'
        RAISERROR ('Erro ao incluir um Show: %s', 16, 2, @Mensagem)
    END
    ELSE
    BEGIN
        begin TRANSACTION
        BEGIN TRY  
            insert into showme.Show VALUES (@idArtista,@nome,@localCep,null)
            COMMIT TRANSACTION
        END TRY  
        BEGIN CATCH 
            ROLLBACK TRANSACTION
            Set @Mensagem = 'Erro interno'
            RAISERROR ('Erro ao cadastrar um show :%s', 16, 2, @Mensagem)
        END CATCH 
    END    
END

create or alter PROCEDURE showme.adcionarDataNoShow
@idArtista int, @nome varchar(50),@localCep char(9), @dataShow date
AS
BEGIN
    if not EXISTS (select nome,idArtista,localCep from showme.Show where nome = @nome and idArtista = @idArtista and localCep = @localCep)
    BEGIN
        DECLARE @Mensagem varchar(37)
        set @Mensagem = 'Show buscado não registrado registrado'
        RAISERROR ('Erro ao atualizar o show: %s', 16, 2, @Mensagem)
    END
    ELSE
    BEGIN
        begin TRANSACTION
        BEGIN TRY  
            UPDATE showme.Show SET dataShow = @dataShow WHERE nome = @nome and idArtista = @idArtista and localCep = @localCep;
            COMMIT TRANSACTION
        END TRY  
        BEGIN CATCH 
            ROLLBACK TRANSACTION
            Set @Mensagem = 'Erro interno'
            RAISERROR ('Erro ao atualizar o show :%s', 16, 2, @Mensagem)
        END CATCH 
    END    
END
*/

create or alter PROCEDURE showme.cancelarShow
@id int
as
BEGIN
    if not EXISTS (select id from showme.Show where id = @id)
    BEGIN
        DECLARE @Mensagem varchar(30)
        set @Mensagem = 'Show buscado não registrado'
        RAISERROR ('Erro ao cancelar o show: %s', 16, 2, @Mensagem)
    END
    ELSE
    BEGIN
    begin TRANSACTION
        BEGIN TRY  
            delete from showme.Show where id = @id
            COMMIT TRANSACTION
        END TRY  
        BEGIN CATCH 
            ROLLBACK TRANSACTION
            Set @Mensagem = 'Erro interno'
            RAISERROR ('Erro ao cancelar o show :%s', 16, 2, @Mensagem)
        END CATCH 
    END
END