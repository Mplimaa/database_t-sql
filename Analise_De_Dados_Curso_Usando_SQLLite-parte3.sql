--Para saber mais: documentação das suas consultas e organização
--PRÓXIMA ATIVIDADE

--A documentação de código é uma prática fundamental no desenvolvimento de software e na análise de dados. Comentários eficazes em consultas SQL facilitam o entendimento do código, a manutenção e a colaboração entre equipes.

--No SQLite, assim como em outros sistemas de gerenciamento de banco de dados, você pode adicionar comentários para explicar o propósito de uma consulta, as razões por trás de uma abordagem específica ou detalhes importantes sobre os dados.

--Exemplo de Consulta SQL com Comentários e Organização Apropriada:

--Contexto da Consulta:

--Suponha que temos um banco de dados de uma biblioteca com tabelas livros e emprestimos. Queremos descobrir os livros mais emprestados no último ano.

--Consulta SQL com Comentários:

---- Consulta para encontrar os livros mais emprestados no último ano
--SELECT 
--    l.titulo AS TituloLivro,               -- Seleciona o título do livro
--    COUNT(e.id_livro) AS QtdEmprestimos    -- Conta o número de vezes que cada livro foi emprestado
--FROM 
--    emprestimos e
--    JOIN livros l ON e.id_livro = l.id     -- Junta a tabela de empréstimos com a tabela de livros
--WHERE 
--    e.data_emprestimo >= '2022-01-01'      -- Filtra os empréstimos do último ano
--GROUP BY 
--    l.titulo                               -- Agrupa os resultados pelo título do livro
--ORDER BY 



--    QtdEmprestimos DESC                    -- Ordena os livros pelo número de empréstimos, do mais ao menos emprestado
--LIMIT 10;                                  -- Limita os resultados aos 10 livros mais emprestados
--COPIAR CÓDIGO
--Importância dos Comentários:

--Clareza: Os comentários ajudam a explicar o propósito e a lógica de cada parte da consulta, tornando-a mais acessível.
--Manutenção: Documentar consultas SQL facilita futuras alterações ou correções, especialmente em projetos colaborativos ou de longo prazo.
--Colaboração: Comentários claros permitem que outros membros da equipe entendam rapidamente suas consultas, facilitando a colaboração.



--08 Faça como eu fiz
--PRÓXIMA ATIVIDADE

--Você está prestes a participar de uma importante reunião de negócios onde a análise de dados desempenha um papel central. Neste cenário, suas habilidades em SQL são fundamentais para responder a perguntas cruciais e fornecer insights valiosos para o time de negócios. O desafio se divide em três partes:

--Preparação para a Reunião: Aqui, você transformará as pautas da reunião em consultas SQL.
--Participação Ativa na Reunião: Durante a reunião, você usará suas consultas para responder questionamentos em tempo real.
--Dever de Casa: Após a reunião, você concluirá uma tarefa pendente baseada nas discussões.


--Transforme as seguintes pautas em consultas SQL:

--Papel dos Fornecedores na Black Friday
--Consulta SQL:

---- Calcula o total de vendas de cada fornecedor na Black Friday
--SELECT SUM(Qtd_Vendas)
--FROM(
--    SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
--    FROM itens_venda iv
--    JOIN vendas v ON v.id_venda = iv.venda_id
--    JOIN produtos p ON p.id_produto = iv.produto_id
--    JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--    GROUP BY Nome_Fornecedor, "Ano/Mes"
--    ORDER BY "Ano/Mes", Qtd_Vendas
--);
--COPIAR CÓDIGO
--Explicação: Esta consulta destaca o desempenho dos fornecedores durante a Black Friday, permitindo uma análise detalhada das vendas por fornecedor nesse período crítico de vendas.

--Categorias de Produtos na Black Friday
--Consulta SQL:

---- Analisa as vendas por categoria de produtos na Black Friday
--SELECT strftime("%Y", v.data_venda) AS "Ano", c.nome_categoria AS Nome_Categoria, COUNT(iv.produto_id) AS Qtd_Vendas
--FROM itens_venda iv
--JOIN vendas v ON v.id_venda = iv.venda_id
--JOIN produtos p ON p.id_produto = iv.produto_id
--JOIN categorias c ON c.id_categoria = p.categoria_id
--WHERE strftime("%m", v.data_venda) = "11"
--GROUP BY Nome_Categoria, "Ano"
--ORDER BY "Ano", Qtd_Vendas DESC;
--COPIAR CÓDIGO
--Explicação: Esta consulta fornece uma visão clara de quais categorias de produtos foram mais populares durante a Black Friday, organizadas por ano e quantidade de vendas.

--Durante a Reunião

--Validação das Consultas:

---- Validação da consistência das vendas registradas
--SELECT SUM(Qtd_Vendas)
--FROM(
--    SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
--    FROM itens_venda iv
--    JOIN vendas v ON v.id_venda = iv.venda_id
--    JOIN produtos p ON p.id_produto = iv.produto_id
--    JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--    GROUP BY Nome_Fornecedor, "Ano/Mes"
--    ORDER BY "Ano/Mes", Qtd_Vendas
--);
--COPIAR CÓDIGO
--Explicação: Esta consulta serve para validar a quantidade de vendas registradas, garantindo a precisão dos dados apresentados.

--Dever de Casa

--Análise de Desempenho do Fornecedor:

---- Análise da performance de vendas do fornecedor "NebulaNetworks" ao longo do tempo
--SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", COUNT(iv.produto_id) AS Qtd_Vendas
--FROM itens_venda iv
--JOIN vendas v ON v.id_venda = iv.venda_id
--JOIN produtos p ON p.id_produto = iv.produto_id
--JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--WHERE f.nome="NebulaNetworks"
--GROUP BY "Ano/Mes"
--ORDER BY "Ano/Mes", Qtd_Vendas;
--COPIAR CÓDIGO
--Explicação: Após identificar o fornecedor com menor desempenho em vendas, essa consulta permite avaliar como foi a performance dele ao longo dos anos, dando insights para estratégias futuras.

-- DISCUTIR NO FÓRUM
--PRÓXIMA ATIVIDADE

