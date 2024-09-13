--Construiremos um programa em T-SQL para pegar uma sequência de números inteiros desde um limite mínimo a um limite máximo. 
--Em seguida, ele irá e percorrer esses números e verificar se eles correspondem a uma nota fiscal na base de dados SUCOS_VENDAS. 
--Portanto é importante estarmos conectados e conectadas à base SUCOS_VENDAS.

DECLARE @LIMITE_MINIMO INT, @LIMITE_MAXIMO INT

--gravar o resultado da declaração @LIMITE_MINIMO e @LIMITE_MAXIMO na variável tabela.
DECLARE @TABELA_NUMEROS TABLE ([NUMERO] INT, [STATUS] VARCHAR(200))
DECLARE @CONTADOR_NOTAS INT

--inicializar limite minimo e maximo
SET @LIMITE_MINIMO = 1
SET @LIMITE_MAXIMO = 1000000

--nao aparecer inclusoes e resultados
SET NOCOUNT ON

WHILE @LIMITE_MINIMO <= @LIMITE_MAXIMO
BEGIN
	SELECT @CONTADOR_NOTAS = COUNT(*) FROM [dbo].[NOTAS FISCAIS] WHERE NUMERO = @LIMITE_MINIMO
	IF @CONTADOR_NOTAS > 0 
		BEGIN
			INSERT INTO @TABELA_NUMEROS (NUMERO, STATUS) VALUES (@LIMITE_MINIMO, 'É NOTA FISCAL')
		END
	ELSE
		BEGIN 
			INSERT INTO @TABELA_NUMEROS (NUMERO, STATUS) VALUES (@LIMITE_MINIMO, 'NÃO É NOTA FISCAL')
		END
	
	SET @LIMITE_MINIMO = @LIMITE_MINIMO + 1
END
SELECT * FROM @TABELA_NUMEROS ORDER BY NUMERO

--SELECT MIN(NUMERO), MAX(NUMERO) FROM [dbo].[NOTAS FISCAIS]
