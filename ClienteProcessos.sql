create or ALTER PROCEDURE kiwicut.incluirCliente
    @nome varchar(11), @sobrenome varchar(25), @email varchar(35), @telefone char(11), @senha varchar,
    @cpf char(11), @cep char(9), @dataNascimento date 
as
BEGIN
    if not exists (select cpf from kiwicut.Cliente where cpf = @cpf)
        begin
            insert into kiwicut.Cliente values (@nome,@sobrenome, @email,@telefone, @senha, @cpf, @cep, @dataNascimento)
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


create or alter PROCEDURE kiwicut.deletarCliente
    @id int
as
    BEGIN TRANSACTION
        
        DELETE kiwicut.Cliente where id = @id
    COMMIT TRANSACTION

    IF @@Erro > 0
    BEGIN
        ROLLBACK TRANSACTION
        PRINT 'Erro ao deletar o cliente'
    END
END


-- atualizar: nome, sobrenome, cep, telefone,senha 
CREATE or alter PROCEDURE kiwicut.atualizarCliente (
    @nome varchar(11), @sobrenome varchar(25), @email varchar(35), @telefone char(11), @senha varchar,
    @cpf char(11), @cep char(9), @dataNascimento date
)
AS
    BEGIN
        IF 
            BEGIN
                h
SELECT 
from 
BEGIN
END

create or ALTER VIEW kiwicut.ingressosPorNomes as 
select
    'Você: '+cli.nome + ' '+ cli.sobrenome + ' '+ 'Artista: '+ art.nome +' Show: '+sh.nome + 'ID do Show: '+ sh.id 
FROM
    kiwicut.Cliente as cli
    kiwicut.Ingresso as ing
    kiwicut.Show as sh
    kiwicut.Artista as art
where