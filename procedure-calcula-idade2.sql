select cpf,nome,[data de nascimento],idade from [TABELA DE CLIENTES]


select datediff (year,'2000-01-01', getdate())


select cpf,nome,[data de nascimento],idade, datediff (year,[data de nascimento], getdate()) from [TABELA DE CLIENTES]


CREATE PROCEDURE CalculaIdade2
AS
BEGIN
UPDATE [TABELA DE CLIENTES] SET IDADE = DATEDIFF (year,[data de nascimento], getdate())
END;

select * from [TABELA DE CLIENTES] where cpf = '123123123'
exec CalculaIdade2