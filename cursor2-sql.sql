--Criaremos uma nova consulta e começaremos declarando duas variáveis: @NOME, do tipo VARCHAR de 200, e @ENDERECO, 
--do tipo VARCHAR de valor interno máximo permitido.
--Em seguida, declaramos nosso CURSOR, que chamaremos de CURSOR1, e fazemos a seleção de NOME, que será uma concatenação
--dos dados ENDERECO 1, BAIRRO, CIDADE, o texto , CEP e a informação CEP. Esses campos todos chamaremos de ENDCOMPLETO.

--Executando somente a consulta SELECT NOME, ([ENDERECO 1], + ' ' + BAIRRO + ' ' + CIDADE + ' ' + ESTADO + ', CEP: ' + CEP) 
--ENDCOMPLETO FROM [TABELA DE CLIENTES] teremos como retorno duas colunas: a de nome e a de endereço completo:
--Desta forma, o conteúdo do campo NOME irá para @NOME, e o conteúdo de ENDCOMPLETO, para @ENDERECO.

--Agora, incluímos o mesmo laço de repetição que fizemos no exemplo anterior. A diferença estará apenas no que deve ser
--impresso, pois optaremos por imprimir a variável @NOME, seguida do texto , Endereço: e da variável @ENDERECO:
--Por fim, usaremos CLOSE e DEALLOCATE:
--Executando o código, receberemos os dados organizados da seguinte forma: nome, seguido do texto "Endereço:" e do endereço completo.
DECLARE @NOME VARCHAR(200)
DECLARE @ENDERECO VARCHAR(MAX)

DECLARE CURSOR1 CURSOR FOR
SELECT
NOME, 
([ENDERECO 1] + ' ' + BAIRRO + ' ' + CIDADE + ' ' + ESTADO + ', CEP: ' + CEP) as ENDCOMPLETO
FROM [TABELA DE CLIENTES] --select * from [TABELA DE CLIENTES]
OPEN CURSOR1
FETCH NEXT FROM CURSOR1 INTO @NOME, @ENDERECO
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @NOME + ', Endereço: ' + @ENDERECO
    FETCH NEXT FROM CURSOR1 INTO @NOME, @ENDERECO
END
CLOSE CURSOR1
DEALLOCATE CURSOR1