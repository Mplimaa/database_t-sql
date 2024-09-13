--SELECT BAIRRO
--FROM [TABELA DE CLIENTES]
--WHERE CIDADE = 'Rio de Janeiro'
--ORDER BY BAIRRO
--OFFSET 3 ROWS
--FETCH NEXT 1 ROWS ONLY;

--adapte a função criada neste vídeo, porém o parâmetro inicial será uma cidade e iremos listar 
--todos os bairros desta cidade, um a um, dentro do loop, gravando na tabela de saída o nome do
--bairro (Em vez do número da nota e o status se é nota ou não, como mostrado no vídeo da aula).
--Observação: O contador do OFFSETcomeça no zero.

--Inicialmente, declaramos uma variável para receber o bairro e a cidade:
DECLARE @BAIRRO VARCHAR(50), @CIDADE VARCHAR(50)

--Depois mais duas variáveis: a primeira para receber o contador que vai começar
-- no zero e percorrer até o número total de bairros, e outra com este número total de bairros:
DECLARE @CONTADOR INT, @LINHAS_BAIRRO INT

--Em seguida, a tabela que vai receber a resposta com a lista de bairros:
DECLARE @TABELA_BAIRROS TABLE ([BAIRRO] VARCHAR(50))

--Inicializamos a cidade e o contador:
SET @CIDADE = 'Rio de Janeiro'
SET @CONTADOR = 0

--Obtemos o número total de bairros para a cidade:
SELECT @LINHAS_BAIRRO = COUNT(*) FROM (
SELECT DISTINCT BAIRRO FROM [TABELA DE CLIENTES]
WHERE CIDADE = @CIDADE) X

--Fazemos o Loop para percorrer todas as cidades. Lembrando que o contador começa no zero
--e vai terminar em @LINHAS_BAIRRO - 1, como podemos verificar abaixo:
WHILE @CONTADOR < @LINHAS_BAIRRO
BEGIN
    SELECT DISTINCT @BAIRRO = BAIRRO FROM [TABELA DE CLIENTES]
    WHERE CIDADE = @CIDADE
    ORDER BY BAIRRO
    OFFSET @CONTADOR ROWS
    FETCH NEXT 1 ROWS ONLY
INSERT INTO @TABELA_BAIRROS (BAIRRO) VALUES (@BAIRRO)
SET @CONTADOR = @CONTADOR + 1
END


SELECT * FROM @TABELA_BAIRROS ORDER BY BAIRRO

