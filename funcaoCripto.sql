create or ALTER procedure kiwicut.descriptografarAlgo
@algo varbinary(max)
as
BEGIN
    OPEN symmetric key MinhaChave
    Decryption by certificate certificadoDeCriptografia
    print cast(DECRYPTBYKEY(@algo)as varchar)
    declare @ret varchar(max) = cast(DECRYPTBYKEY(@algo) as varchar)
    return @ret
END


exec kiwicut.descriptografarAlgo cast('0x00E553642209A04EAA4A6FF2281F53E00200000071FA02B5A05769539121C43462590DF2310
75EFC5C2CE25AB77DFF1FF7FD05CE7F4E441B27B977D8A08F61C082806720' as varbinary)