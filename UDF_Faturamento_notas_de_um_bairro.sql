--Em seguida, faça uma função UDF que retorne o faturamento total de todas as notas fiscais de um bairro.

--Exemplo: Se eu seleciono como parâmetro da função o bairro jardins, o retorno da função será o total de faturamento de todas as notas ,
--fiscais, para todos os períodos, para este bairro.

--Primeiramente, vamos determinar a consulta SQL que retorna o faturamento total de um bairro.

--Lembre-se que o campo bairro está na TABELA DE CLIENTES e o faturamento na tabela de ITENS NOTAS FISCAIS.

--Para juntar estas duas tabelas precisamos usar a tabela NOTAS FISCAIS fazendo um JOIN entre TABELA DE CLIENTES e NOTAS FISCAIS através
--do campo CPF e depois entre NOTAS FISCAIS e ITENS NOTAS FISCAIS pelo campo NUMERO.

--A consulta pode ser verificada abaixo.


SELECT 
SUM(INF.QUANTIDADE * INF.[PREÇO]) AS FATURAMENTO
FROM [ITENS NOTAS FISCAIS] INF
	INNER JOIN [NOTAS FISCAIS] NF
		ON INF.NUMERO = NF.NUMERO
	INNER JOIN [TABELA DE CLIENTES] TC
		ON TC.CPF = NF.CPF
WHERE TC.BAIRRO = 'Jardins'


--Logo podemos montar a função UDF.

CREATE FUNCTION FaturamentoBairro (@BAIRRO VARCHAR(50))
RETURNS FLOAT
AS
BEGIN
   DECLARE @FATURAMENTO FLOAT
   SELECT @FATURAMENTO = SUM(INF.QUANTIDADE * INF.[PREÇO]) 
   FROM [ITENS NOTAS FISCAIS] INF
   INNER JOIN [NOTAS FISCAIS] NF
   ON INF.NUMERO = NF.NUMERO
   INNER JOIN [TABELA DE CLIENTES] TC
   ON TC.CPF = NF.CPF
   WHERE TC.BAIRRO = @BAIRRO
   RETURN @FATURAMENTO
END;


CREATE FUNCTION BuscaPreco (@CODIGO INT, @TAXA_DESCONTO)
RETURNS FLOAT
AS
BEGIN
DECLARE @ALEATORIO INT 
	DECLARE @VALOR_ALEATORIO FLOAT
	SELECT @VALOR_ALEATORIO = VALOR_ALEATORIO FROM VW_ALEATORIO
	SET @ALEATORIO = ROUND (((@VAL_MAX - @VAL_MIN - 1) * @VALOR_ALEATORIO + @VAL_MIN), 0)
	RETURN @ALEATORIO


--Parabéns por concluir o desafio e te espero nos próximos vídeos, atividades e desafios.
--Bons estudos!

select * from [TABELA DE PRODUTOS]


go


SELECT [PREÇO DE LISTA] FROM [TABELA DE PRODUTOS]
WHERE [CODIGO DO PRODUTO] = @CODIGO_PRODUTO

select dbo.[CalculaDesconto](1002334,006309)

CREATE FUNCTION CalculaDesconto (@CODIGO_PRODUTO VARCHAR(10), @DescontoPercentual INT)
RETURNS FLOAT
AS
BEGIN
   DECLARE @Desconto FLOAT
   DECLARE @PrecoComDesconto FLOAT
   DECLARE @Preco FLOAT
   SELECT @Preco = [PREÇO DE LISTA] FROM [TABELA DE PRODUTOS] WHERE [CODIGO DO PRODUTO] = @CODIGO_PRODUTO
   SET @Desconto = (@Preco * @DescontoPercentual) / 100
   SET @PrecoComDesconto = @Preco - @Desconto
   RETURN @PrecoComDesconto
END

