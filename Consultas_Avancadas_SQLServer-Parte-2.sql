--Fa�a como eu fiz

--1) NO SSMS crie uma nova consulta para praticar o conhecimento do curso

--2) O primeiro problema � saber quais s�o as vendas v�lidas dentro do limite estabelecido em contrato

--3) Para calcular o volume de venda por cliente use o c�digo


SELECT 
NF.CPF
,NF.DATA_VENDA
,INF.QUANTIDADE
	FROM NOTAS_FISCAIS NF
		INNER JOIN ITENS_NOTAS_FISCAIS INF
			ON NF.NUMERO = INF.NUMERO

--4) Agora preciso ter esta informa��o dentro do m�s e do ano
SELECT 
NF.CPF
,CONVERT(VARCHAR(7), NF.DATA_VENDA, 120) AS MES_ANO
,INF.QUANTIDADE
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO

--5) Para agrupar por CPF use o c�digo
SELECT 
NF.CPF
,CONVERT(VARCHAR(7), NF.DATA_VENDA, 120) AS MES_ANO
,SUM(INF.QUANTIDADE) AS QUANTIDADE_TOTAL
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
GROUP BY
NF.CPF
, CONVERT(VARCHAR(7), NF.DATA_VENDA, 120)

--6) Mostre a tabela de clientes
SELECT CPF, NOME, VOLUME_DE_COMPRA FROM TABELA_DE_CLIENTES;

--7) Para comparar o volume de compra com o volume total por CPF
SELECT
TC.CPF, TC.NOME, TC.VOLUME_DE_COMPRA, TV.MES_ANO, TV.QUANTIDADE_TOTAL
FROM TABELA_DE_CLIENTES TC
INNER JOIN
(
SELECT 
NF.CPF
,CONVERT(VARCHAR(7), NF.DATA_VENDA, 120) AS MES_ANO
,SUM(INF.QUANTIDADE) AS QUANTIDADE_TOTAL
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
GROUP BY
NF.CPF
, CONVERT(VARCHAR(7), NF.DATA_VENDA, 120)
) TV
ON TV.CPF = TC.CPF

--8) Vamos classificar o volume para descobrir o que estiver fora do limite
SELECT
TC.CPF, TC.NOME, TC.VOLUME_DE_COMPRA, TV.MES_ANO, TV.QUANTIDADE_TOTAL,
(CASE WHEN TC.VOLUME_DE_COMPRA >= TV.QUANTIDADE_TOTAL THEN 'VENDAS V�LIDAS'
ELSE 'VENDAS INV�LIDAS' END) AS RESULTADO
FROM TABELA_DE_CLIENTES TC
INNER JOIN
(
SELECT 
NF.CPF
,CONVERT(VARCHAR(7), NF.DATA_VENDA, 120) AS MES_ANO
,SUM(INF.QUANTIDADE) AS QUANTIDADE_TOTAL
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
GROUP BY
NF.CPF
, CONVERT(VARCHAR(7), NF.DATA_VENDA, 120)
) TV
ON TV.CPF = TC.CPF

--9) Agora vamos filtrar por data
SELECT
TC.CPF, TC.NOME, TC.VOLUME_DE_COMPRA, TV.MES_ANO, TV.QUANTIDADE_TOTAL,
(CASE WHEN TC.VOLUME_DE_COMPRA >= TV.QUANTIDADE_TOTAL THEN 'VENDAS V�LIDAS'
ELSE 'VENDAS INV�LIDAS' END) AS RESULTADO
FROM TABELA_DE_CLIENTES TC
INNER JOIN
(
SELECT 
NF.CPF
,CONVERT(VARCHAR(7), NF.DATA_VENDA, 120) AS MES_ANO
,SUM(INF.QUANTIDADE) AS QUANTIDADE_TOTAL
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
GROUP BY
NF.CPF
, CONVERT(VARCHAR(7), NF.DATA_VENDA, 120)
) TV
ON TV.CPF = TC.CPF
WHERE TV.MES_ANO = '2015-01'

--10) Agora vamos para outro problema. O cliente quer saber as vendas por sabor

--11) Abra uma nova janela de consulta

--12) Para ver a venda por dia por quantidade fa�a o JOIN de tr�s tabelas

SELECT
TP.SABOR
,NF.DATA_VENDA
,INF.QUANTIDADE
	FROM TABELA_DE_PRODUTOS TP
		INNER JOIN ITENS_NOTAS_FISCAIS INF
			ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
		INNER JOIN NOTAS_FISCAIS NF
			ON INF.NUMERO = NF.NUMERO

--13) Vamos agrupar por ano
SELECT
TP.SABOR
,YEAR(NF.DATA_VENDA) AS ANO
,SUM(INF.QUANTIDADE) AS VENDA_ANO
FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)


--14) Agora vamos filtrar para um ano espec�fico com as vendas ordenadas
SELECT
TP.SABOR
,YEAR(NF.DATA_VENDA) AS ANO
,SUM(INF.QUANTIDADE) AS VENDA_ANO
FROM TABELA_DE_PRODUTOS TP
	INNER JOIN ITENS_NOTAS_FISCAIS INF
		ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
	INNER JOIN NOTAS_FISCAIS NF
		ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
ORDER BY SUM(INF.QUANTIDADE) DESC

--15) Vamos colocar o percentual de vendas por ano

--16) Para calcular o total do ano
SELECT 
YEAR(NF.DATA_VENDA) AS ANO
, SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
FROM NOTAS_FISCAIS NF
	INNER JOIN ITENS_NOTAS_FISCAIS INF
		ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY YEAR(NF.DATA_VENDA)

--17) Para colocar os dois resultados em um resultado
SELECT
VS.SABOR, VS.ANO, VS.VENDA_ANO, VA.VENDA_TOTAL_ANO
FROM 
(
SELECT
TP.SABOR
,YEAR(NF.DATA_VENDA) AS ANO
,SUM(INF.QUANTIDADE) AS VENDA_ANO
FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
) VS
INNER JOIN
(
SELECT 
YEAR(NF.DATA_VENDA) AS ANO
, SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY YEAR(NF.DATA_VENDA)
) VA
ON VS.ANO = VA.ANO

--18) Vamos ordenar pelo campo VS.VENDA_ANO
SELECT
VS.SABOR, VS.ANO, VS.VENDA_ANO, VA.VENDA_TOTAL_ANO
FROM 
(
SELECT
TP.SABOR
,YEAR(NF.DATA_VENDA) AS ANO
,SUM(INF.QUANTIDADE) AS VENDA_ANO
FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
) VS
INNER JOIN
(
SELECT 
YEAR(NF.DATA_VENDA) AS ANO
, SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY YEAR(NF.DATA_VENDA)
) VA
ON VS.ANO = VA.ANO
ORDER BY VS.VENDA_ANO DESC

--19) Vamos achar o percentual dos valores das vendas
SELECT
VS.SABOR, VS.ANO, VS.VENDA_ANO, VA.VENDA_TOTAL_ANO,
(VS.VENDA_ANO / VA.VENDA_TOTAL_ANO) * 100 AS PERCENTUAL
FROM 
(
SELECT
TP.SABOR
,YEAR(NF.DATA_VENDA) AS ANO
,SUM(INF.QUANTIDADE) AS VENDA_ANO
FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
) VS
INNER JOIN
(
SELECT 
YEAR(NF.DATA_VENDA) AS ANO
, SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY YEAR(NF.DATA_VENDA)
) VA
ON VS.ANO = VA.ANO
ORDER BY VS.VENDA_ANO DESC

--20) Vamos converter os campos
SELECT
VS.SABOR, VS.ANO, VS.VENDA_ANO, VA.VENDA_TOTAL_ANO,
(CONVERT( FLOAT, VS.VENDA_ANO) / CONVERT( FLOAT, VA.VENDA_TOTAL_ANO)) * 100 AS PERCENTUAL
FROM 
(
SELECT
TP.SABOR
,YEAR(NF.DATA_VENDA) AS ANO
,SUM(INF.QUANTIDADE) AS VENDA_ANO
FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
) VS
INNER JOIN
(
SELECT 
YEAR(NF.DATA_VENDA) AS ANO
, SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY YEAR(NF.DATA_VENDA)
) VA
ON VS.ANO = VA.ANO
ORDER BY VS.VENDA_ANO DESC

--21) Para restringir a resposta para duas casas decimais
SELECT
VS.SABOR, VS.ANO, VS.VENDA_ANO,
ROUND((CONVERT( FLOAT, VS.VENDA_ANO) / CONVERT( FLOAT, VA.VENDA_TOTAL_ANO)) * 100, 2) AS PERCENTUAL
FROM 
(
SELECT
TP.SABOR
,YEAR(NF.DATA_VENDA) AS ANO
,SUM(INF.QUANTIDADE) AS VENDA_ANO
FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2016
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
) VS
INNER JOIN
(
SELECT 
YEAR(NF.DATA_VENDA) AS ANO
, SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2016
GROUP BY YEAR(NF.DATA_VENDA)
) VA
ON VS.ANO = VA.ANO
ORDER BY VS.VENDA_ANO DESC
