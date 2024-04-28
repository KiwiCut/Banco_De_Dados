create or alter PROCEDURE kiwicut.incluirShow
@idArtista int, @nome varchar(50),@localCep char(9), @dataShow date
AS
BEGIN
    if EXISTS (select nome,idArtista,localCep from kiwicut.Show where nome = @nome and idArtista = @idArtista and localCep = @localCep and dataShow = @dataShow)
    BEGIN
        DECLARE @Mensagem varchar(30)
        set @Mensagem = 'Show idêntico já registrado'
        RAISERROR ('Erro ao incluir um Show: %s', 16, 2, @Mensagem)
    END
    ELSE
    BEGIN
        begin TRANSACTION
        BEGIN TRY  
            insert into kiwicut.Show VALUES (@idArtista,@nome,@localCep,@dataShow)
            COMMIT TRANSACTION
        END TRY  
        BEGIN CATCH 
            ROLLBACK TRANSACTION
            Set @Mensagem = 'Erro interno'
            RAISERROR ('Erro ao cadastrar um show :%s', 16, 2, @Mensagem)
        END CATCH 
    END    
END


