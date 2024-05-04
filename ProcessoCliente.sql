/*
create or ALTER PROCEDURE kiwicut.incluirCliente
    @nome varchar(15), @sobrenome varchar(25), @email varchar(35), @telefone char(11), @senha nvarchar(MAX),
    @cpf char(11), @cep char(9), @dataNascimento date 
as
BEGIN
    if not exists (select cpf from kiwicut.Cliente where cpf = @cpf)
        begin
            OPEN symmetric key MinhaChave
            Decryption by certificate certificadoDeCriptografia
            insert into kiwicut.Cliente values (@nome,@sobrenome, @email,@telefone,EncryptByKey(Key_GUID('MinhaChave'), CAST(@senha as varchar)) ,EncryptByKey(Key_GUID('MinhaChave'),Cast(@cpf as varchar)), @cep, @dataNascimento)
            if @@ERROR <>0
            BEGIN
                declare @Mensagem NVARCHAR(100)
                SELECT @Mensagem = ERROR_MESSAGE()
                RAISERROR ('Erro ao incluir o Cliente: %s', @Mensagem,16,2)
            END
        end
    else -- em caso do cliente já existir no banco de dados !
        begin
            RAISERROR('Cliente, enviado já existe no banco de dados',16,2)
        end
END

CREATE or ALTER PROCEDURE kiwicut.deletarCliente
    @cpf char(11),@email varchar(35)
as 
BEGIN
    declare @id int, @Mensagem varchar(31),@cpfDoBanco varbinary(max), @cpfDescrip char (11)
    SELECT @cpfDoBanco =cpf from kiwicut.Cliente where email = @email
    select @id = id from kiwicut.Cliente where email = @email
    exec kiwicut.descriptografarAlgo @cpfDoBanco, @cpfDescrip OUTPUT
    IF NOT EXISTS (select * from kiwicut.Cliente where @cpf = @cpfDescrip)
    BEGIN
        set @Mensagem = 'Cliente inexistente ou inválido'
        RAISERROR ('Cliente buscado não existe no banco: %s', 16, 2, @Mensagem)
    END
    ELSE
    BEGIN
        begin TRANSACTION
        BEGIN TRY  
            delete from kiwicut.Cliente where id = @id
            print 'Deleção concluida'
            COMMIT TRANSACTION
        END TRY  
        BEGIN CATCH 
            ROLLBACK TRANSACTION
            Set @Mensagem = 'Erro interno'
            RAISERROR ('Erro ao deletar cliente :%s', 16, 2, @Mensagem)
        END CATCH 
    END
END


CREATE or alter PROCEDURE kiwicut.atualizarNomeCliente 
    @nome varchar(15), @cpf char(11),@email varchar(35)
AS
BEGIN
    declare @id int, @Mensagem varchar(31),@cpfDoBanco varbinary(max), @cpfDescrip char (11)
    select @cpfDoBanco = cpf from kiwicut.Cliente where email = @email
    select @id = id from kiwicut.Cliente where email = @email
    exec kiwicut.descriptografarAlgo @cpfDoBanco, @cpfDescrip OUTPUT
    if not EXISTS (select id from kiwicut.Cliente where @cpf = @cpfDescrip)
        Begin
            set @Mensagem = 'CPF inexistente e/ou inválido'
            RAISERROR ('Cliente buscado não existe no banco: %s', 16, 2, @Mensagem)
        END
    ELSE
    BEGIN
        begin TRANSACTION
        BEGIN TRY  
            update kiwicut.Cliente set nome = @nome where id = @id
            print 'Alteração concluida'
            COMMIT TRANSACTION
        END TRY  
        BEGIN CATCH 
            ROLLBACK TRANSACTION
            Set @Mensagem = 'Erro interno'
            RAISERROR ('Erro ao deletar cliente :%s', 16, 2, @Mensagem)
        END CATCH 
    END  
END
*/

CREATE or alter PROCEDURE kiwicut.atualizarSobrenomeCliente 
    @sobrenome varchar(25), @cpf char(11)
AS
BEGIN
    if not EXISTS (select id from kiwicut.Cliente where cpf = @cpf)
        Begin
            DECLARE @Mensagem varchar(30)
            set @Mensagem = 'CPF inexistente e/ou inválido'
            RAISERROR ('Cliente buscado não existe no banco: %s', 16, 2, @Mensagem)
        END
    ELSE
    BEGIN
        begin TRANSACTION
        BEGIN TRY  
            update kiwicut.Cliente set sobrenome = @sobrenome where cpf = @cpf
            COMMIT TRANSACTION
        END TRY  
        BEGIN CATCH 
            ROLLBACK TRANSACTION
            Set @Mensagem = 'Erro interno'
            RAISERROR ('Erro ao deletar cliente :%s', 16, 2, @Mensagem)
        END CATCH 
    END    
END


CREATE or alter PROCEDURE kiwicut.atualizarTelefoneCliente 
    @telefone char(11), @cpf char(11)
AS
BEGIN
    if not EXISTS (select cpf from kiwicut.Cliente where cpf = @cpf)
        Begin
            DECLARE @Mensagem varchar(60)
            set @Mensagem = 'Número de telefone atrelado ao CPF é inexistente e/ou inválido'
            RAISERROR ('Cliente buscado não existe no banco: %s', 16, 2, @Mensagem)
        END
    ELSE
    BEGIN
        begin TRANSACTION
        BEGIN TRY  
            update kiwicut.Cliente set telefone = @telefone where cpf = @cpf
            COMMIT TRANSACTION
        END TRY  
        BEGIN CATCH 
            ROLLBACK TRANSACTION
            Set @Mensagem = 'Erro interno'
            RAISERROR ('Erro ao deletar cliente :%s', 16, 2, @Mensagem)
        END CATCH 
    END    
END

CREATE or alter PROCEDURE kiwicut.atualizarCepCliente 
    @cep char(9), @cpf char(11)
AS
BEGIN
    if not EXISTS (select cpf from kiwicut.Cliente where cpf = @cpf)
        Begin
            DECLARE @Mensagem varchar(47)
            set @Mensagem = 'CEP atrelado ao CPF é inexistente e/ou inválido'
            RAISERROR ('Cliente buscado não existe no banco: %s', 16, 2, @Mensagem)
        END
    ELSE
    BEGIN
        begin TRANSACTION
        BEGIN TRY  
            update kiwicut.Cliente set cep = @cep where cpf = @cpf
            COMMIT TRANSACTION
        END TRY  
        BEGIN CATCH 
            ROLLBACK TRANSACTION
            Set @Mensagem = 'Erro interno'
            RAISERROR ('Erro ao deletar cliente :%s', 16, 2, @Mensagem)
        END CATCH 
    END    
END

CREATE or alter PROCEDURE kiwicut.atualizarSenhaCliente 
    @senha nvarchar(MAX), @cpf char(11)
AS
BEGIN
    if not EXISTS (select id from kiwicut.Cliente where cpf = @cpf)
        Begin
            DECLARE @Mensagem varchar(30)
            set @Mensagem = 'CPF inexistente e/ou inválido'
            RAISERROR ('Cliente buscado não existe no banco: %s', 16, 2, @Mensagem)
        END
    ELSE
    BEGIN
        begin TRANSACTION
        BEGIN TRY  
            update kiwicut.Cliente set senha = EncryptByKey(Key_GUID('MinhaChave'), CAST(@senha as varchar)) where cpf = @cpf
            COMMIT TRANSACTION
        END TRY  
        BEGIN CATCH 
            ROLLBACK TRANSACTION
            Set @Mensagem = 'Erro interno'
            RAISERROR ('Erro ao atualizar senha :%s', 16, 2, @Mensagem)
        END CATCH 
    END    
END

exec kiwicut.atualizarSenhaCliente 'mls51asw@', '98451326051' --ERRO

create or ALTER VIEW kiwicut.ingressosPorNomes as 
select
    'Você: '+cli.nome + ' '+ cli.sobrenome + ' '+ 'Artista: '+ art.nome +' Show: '+sh.nome + 'ID do Show: '+ sh.id 
FROM
    kiwicut.Cliente as cli
    kiwicut.Ingresso as ing
    kiwicut.Show as sh
    kiwicut.Artista as art
where