--11
--Mão na massa: hora da prática
--PRÓXIMA ATIVIDADE

--Chegou a hora de se desafiar a desenvolver ainda mais todo o conhecimento aprendido durante nossa jornada!

--Aqui estão algumas atividades que vão te ajudar a praticar e fixar ainda mais cada conteúdo e caso você precise de ajuda, opções de solução das atividades estão disponíveis na seção “Opinião da pessoa instrutora”.

--Considerando a mesma base de dados utilizada no curso.

--01 - Qual é o número de Clientes que existem na base de dados ?

--02 - Quantos produtos foram vendidos no ano de 2022 ?

--03 - Qual a categoria que mais vendeu em 2022 ?

--04 - Qual o primeiro ano disponível na base ?

--05 - Qual o nome do fornecedor que mais vendeu no primeiro ano disponível na base ?

--06 - Quanto ele vendeu no primeiro ano disponível na base de dados ?

--07 - Quais as duas categorias que mais venderam no total de todos os anos ?

--08 - Crie uma tabela comparando as vendas ao longo do tempo das duas categorias que mais venderam no total de todos os anos.

--09 - Calcule a porcentagem de vendas por categorias no ano de 2022.

--10 - Crie uma métrica mostrando a porcentagem de vendas a mais que a melhor categoria tem em relação a pior no ano de 2022.

-- DISCUTIR NO 

--Opinião do instrutor

--Podem existir diversas formas de solucionar os problemas propostos e algumas delas são apresentadas a seguir:

--01 -
SELECT COUNT(*) AS Qtd_Clientes FROM CLIENTES;

--02-
SELECT COUNT(*) AS Qtd_Produtos, strftime('%Y', data_venda) AS Ano FROM VENDAS WHERE Ano = '2022';

--03-
SELECT COUNT(*) AS Qtd_Vendas, c.nome_categoria AS Categoria
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN PRODUTOS p ON p.id_produto = iv.produto_id
JOIN CATEGORIAS c ON c.id_categoria = p.categoria_id
WHERE strftime('%Y', v.data_venda) = '2022'
GROUP BY categoria 
ORDER BY COUNT(*) DESC
LIMIT 1;

--04-
SELECT MIN(strftime('%Y', data_venda)) AS Ano FROM VENDAS;

--05-
SELECT COUNT(*) AS Qtd_Vendas, f.nome AS Fornecedor
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN PRODUTOS p ON p.id_produto = iv.produto_id
JOIN FORNECEDORES f ON f.id_fornecedor = p.fornecedor_id
WHERE strftime('%Y', v.data_venda) = '2020'
GROUP BY Fornecedor
ORDER BY COUNT(*) DESC
LIMIT 1;

--06
SELECT COUNT(*) AS Qtd_Vendas, strftime('%Y', v.data_venda) AS Ano, f.nome AS Fornecedor
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN PRODUTOS p ON p.id_produto = iv.produto_id
JOIN FORNECEDORES f ON f.id_fornecedor = p.fornecedor_id
WHERE Ano = '2020'
GROUP BY Fornecedor
ORDER BY COUNT(*) DESC
LIMIT 1
;


--07-
SELECT COUNT(*) AS Qtd_Vendas, c.nome_categoria AS Categoria
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN PRODUTOS p ON p.id_produto = iv.produto_id
JOIN CATEGORIAS c ON c.id_categoria = p.categoria_id
GROUP BY Categoria
ORDER BY COUNT(*) DESC
LIMIT 2;


--08
SELECT "Ano/Mês",
SUM(CASE WHEN Categoria=='Eletrônicos' THEN Qtd_Vendas ELSE 0 END) AS Eletrônicos,
SUM(CASE WHEN Categoria=='Vestuário' THEN Qtd_Vendas ELSE 0 END) AS Vestuário
FROM(
    SELECT COUNT(*) AS Qtd_Vendas, strftime('%Y/%m', v.data_venda) AS "Ano/Mês", c.nome_categoria AS Categoria
    FROM itens_venda iv
    JOIN vendas v ON v.id_venda = iv.venda_id
    JOIN PRODUTOS p ON p.id_produto = iv.produto_id
    JOIN CATEGORIAS c ON c.id_categoria = p.categoria_id
    WHERE Categoria IN ('Eletrônicos', 'Vestuário')
    GROUP BY "Ano/Mês", Categoria
    ORDER BY "Ano/Mês", Categoria
)
GROUP BY "Ano/Mês"
;


--09
WITH Total_Vendas AS (
SELECT COUNT(*) as Total_Vendas_2022
From itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
WHERE strftime('%Y', v.data_venda) = '2022'
)
SELECT Nome_Categoria, Qtd_Vendas, ROUND(100.0*Qtd_Vendas/tv.Total_Vendas_2022, 2) || '%' AS Porcentagem
FROM(
  SELECT c.nome_categoria AS Nome_Categoria, COUNT(iv.produto_id) AS Qtd_Vendas
  from itens_venda iv
  JOIN vendas v ON v.id_venda = iv.venda_id
  JOIN produtos p ON p.id_produto = iv.produto_id
  JOIN categorias c ON c.id_categoria = p.categoria_id
  WHERE strftime('%Y', v.data_venda) = '2022'
  GROUP BY Nome_Categoria
  ORDER BY Qtd_Vendas DESC
  ), Total_Vendas tv
;



--12
--Desafio: crie outras métricas e elabore mais o seu relatório
--PRÓXIMA ATIVIDADE

--Para dar suporte ao time de negócios, nós criamos uma métrica que calcula a porcentagem de vendas e ela já será bem útil para eles.
--E no nosso relatório incluímos comparação de vendas entre os principais fornecedores, a porcentagem de vendas das categorias e
--identificamos uma sazonalidade nas vendas comparando os últimos anos de dados.

--Aqui proponho para você um desafio, você já é um especialista nesse projeto e pode criar mais análises e métricas, atacando partes
--não exploradas como marcas, categorias e o que mais você entender que faz sentido para o nosso relatório e para a área de negócios.

--Opinião do instrutor

--Depois que fizer isso, não esqueça de compartilhar seus resultados lá na comunidade no Discord ou no LinkedIn marcando a Alura.