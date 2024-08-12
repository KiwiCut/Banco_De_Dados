
/*
create or ALTER PROCEDURE showme.incluirEmpresa
   @cnpj NVARCHAR(max), @nome varchar(50), @email varchar(35), @telefone char(11), @senha NVARCHAR(max)
as
BEGIN
    if not exists (select cnpj from showme.Empresa where cnpj = @cnpj)
        begin
            OPEN symmetric key MinhaChave
            Decryption by certificate certificadoDeCriptografia
            insert into showme.Empresa values (EncryptByKey(Key_GUID('MinhaChave'),Cast(@cnpj as varchar)),@nome,@email,@telefone,EncryptByKey(Key_GUID('MinhaChave'), CAST(@senha as varchar)))
            if @@ERROR <>0
            BEGIN
                declare @Mensagem NVARCHAR(100)
                SELECT @Mensagem = ERROR_MESSAGE()
                RAISERROR ('Erro ao incluir o Empresa: %s', @Mensagem,16,2)
            END
        end
    else -- em caso do Empresa já existir no banco de dados !
        begin
            RAISERROR('A empresa enviada já existe no banco de dados',16,2)
        end
END



CREATE OR ALTER PROCEDURE showme.excluirEmpresa
    @cnpj char(11), @email varchar(35)
AS
BEGIN
    declare @id int, @Mensagem varchar(31),@cnpjDoBanco varbinary(max), @cnpjDescrip char (11)
    SELECT @cnpjDoBanco = cnpj from showme.Empresa where email = @email
    select @id = id from showme.Empresa where email = @email
    exec showme.descriptografarAlgo @cnpjDoBanco, @cnpjDescrip OUTPUT
    IF NOT EXISTS (select * from showme.Empresa where @cnpj = @cnpjDescrip)
    BEGIN
        set @Mensagem = 'Empresa inexistente ou inválido'
        RAISERROR ('Empresa buscado não existe no banco: %s', 16, 2, @Mensagem)
    END
    ELSE
    BEGIN
        begin TRANSACTION
        BEGIN TRY  
            delete from showme.Empresa where id = @id
            print 'Deleção concluida'
            COMMIT TRANSACTION
        END TRY  
        BEGIN CATCH 
            ROLLBACK TRANSACTION
            set @mensagem = ERROR_MESSAGE()
            RAISERROR ('Erro ao deletar Empresa :%s', 16, 2, @Mensagem)
        END CATCH 
    END
END



Create or alter PROCEDURE showme.alterarTelefone
   @email varchar(35), @telefone char(11)
AS
BEGIN
    declare @Mensagem varchar(31)
    if not EXISTS (select email from showme.Empresa where email = @email)
        Begin
            set @Mensagem = 'Empresa não cadastrada no banco de dados'
            RAISERROR ('Empresa buscado não existe no banco: %s', 16, 2, @Mensagem)
        END
    ELSE
    BEGIN
        begin TRANSACTION
        BEGIN TRY  
            update showme.Empresa set telefone = @telefone where email = @email
            print 'Alteração concluida'
            COMMIT TRANSACTION
        END TRY  
        BEGIN CATCH 
            ROLLBACK TRANSACTION
            set @mensagem = ERROR_MESSAGE()
            RAISERROR ('Erro ao alterar telefone da  empresa :%s', 16, 2, @Mensagem)
        END CATCH 
    END  
END


CREATE OR ALTER PROCEDURE showme.atualizarSenhaEmpresa
    @senha varchar(128), @cnpj char(11), @email varchar(35)
AS
BEGIN
    declare @id int, @mensagem varchar(30),@cnpjDoBanco varbinary(max), @cnpjDescrip char (11)
    select @cnpjDoBanco = cnpj from showme.Empresa where email = @email
    select @id = id from showme.Empresa where email = @email
    exec showme.descriptografarAlgo @cnpjDoBanco, @cnpjDescrip OUTPUT
    if not EXISTS (select id from showme.Empresa where @cnpj = @cnpjDescrip)
      BEGIN
            set @mensagem = 'cnpj inexistente e/ou inválido'
            RAISERROR ('Empresa buscado não existe no banco: %s', 16, 2, @Mensagem)
      END
    else
      BEGIN
            begin TRAN
            begin TRY
                    OPEN symmetric key MinhaChave
                    Decryption by certificate certificadoDeCriptografia
                    update showme.Empresa set senha = EncryptByKey(Key_GUID('MinhaChave'), @senha) where id = @id
                    commit TRAN
            END TRY
            begin CATCH
                    ROLLBACK tran
                    set @mensagem = ERROR_MESSAGE()
                    RAISERROR ('Erro ao atualizar senha: %s', 16, 2, @Mensagem)
            END catch
      END
END

*/