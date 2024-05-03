/*
--Funções para o uso da criptografia e descriptografia durante os métodos
create or ALTER procedure kiwicut.descriptografarAlgo
@algo varbinary(max),@ret varchar(max) OUTPUT
as
BEGIN
    OPEN symmetric key MinhaChave
    Decryption by certificate certificadoDeCriptografia
    select @ret = CONVERT(VARCHAR(MAX), DecryptByKey(@algo))
    close symmetric key MinhaChave
    select @ret as 'Elemento Descriptografado'
END
*/

CREATE or ALTER PROCEDURE kiwicut.selecionaIdPorCpfEEmail
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
    select @id
END

exec kiwicut.selecionaIdPorCpf '13532122030', 'abnerdias@gmail.com'


/*
DECLARE @ElementoCriptografado VARBINARY(MAX);
DECLARE @ElementoDescriptografado VARCHAR(MAX);

SET @ElementoCriptografado = 0x00E553642209A04EAA4A6FF2281F53E00200000071FA02B5A05769539121C43462590DF231075EFC5C2CE25AB77DFF1FF7FD05CE7F4E441B27B977D8A08F61C082806720

EXEC kiwicut.descriptografarAlgo @ElementoCriptografado, @ElementoDescriptografado OUTPUT;

print @ElementoDescriptografado
*/