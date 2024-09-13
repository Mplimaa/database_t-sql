--anscrição
--Já nos preparamos para a reunião trimestral da Zoop Megastore. Pegamos as pautas da reunião, as possíveis dúvidas que surgiriam, e preparamos as consultas (queries) para responder com agilidade qualquer questionamento. Agora que estamos preparados, vamos para a reunião?

--Respondendo dúvidas
--Igor: Olá, Mirla. Tudo bem? Sou o Igor, do time de análise de dados. Recebemos uma demanda do comercial sobre algumas dúvidas para a Black Friday deste ano. É isso mesmo?

--Mirla: Perfeito, Igor. Exatamente. Estamos começando a tomar decisões estratégicas para a nossa Black Friday, e para tomar essas decisões, vamos precisar de algumas respostas suas quanto aos dados que temos referentes à última Black Friday que aconteceu no ano passado.

--Vamos começar trazendo algumas perguntas em relação aos fornecedores. Gostaríamos de saber, para ter uma prioridade, quais foram os fornecedores que mais venderam, que mais trouxeram renda para nós na última Black Friday. Você consegue nos informar?

--Igor: Claro, preparamos algumas consultas já focadas nos fornecedores. Vou fazer uma pequena modificação para aplicar um filtro devido à questão da Black Friday.

--Vamos acessar a consulta e digitar o comando WHERE na linha 8 para aplicar o filtro. Como estamos falando de mês, precisaremos usar o strftime(), recebendo a especificação do mês (%m") entre aspas duplas. Em seguida, vamos acessar a data da venda entre parênteses (v.data_venda).

--Acessando o mês, já conseguimos aplicar o filtro na Black Friday do último ano, que será o mês de novembro. Então, podemos adicionar ao final = "11".

--banco_de_dados.db:

--SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
--FROM itens_venda iv
--JOIN vendas v ON v.id_venda = iv.venda_id
--JOIN produtos p ON p.id_produto = iv.produto_id
--JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--WHERE strftime("%m", v.data_venda) = "11"
--GROUP BY Nome_Fornecedor, "Ano/Mes"
--ORDER BY "Ano/Mes", Qtd_Vendas
--;
--COPIAR CÓDIGO
--Após selecionar e executar essa consulta, já conseguimos responder.

--Na última Black Friday, você quer saber quem vendeu mais, certo? Os dois fornecedores que se destacaram na Black Friday de 2022 foram a AstroSupply, com 1.830 vendas, e a HorizonDistributors, com 1.735 vendas. Estes foram os destaques da última Black Friday.

--Mirla: Nas conversas que tivemos no setor, surgiu a informação de que provavelmente o NebulaNetworks teve um desempenho inferior na última Black Friday. Gostaríamos de confirmar se realmente foi o NebulaNetworks que menos vendeu na última Black Friday.

--Igor: Podemos confirmar. Nessa mesma tabela, como a ordenação vai do menor para o maior, conseguimos ir no primeiro registro de 2022, no mês 11, e confirmar que foram eles. O NebulaNetworks teve 529 vendas. Portanto, foi uma performance bem abaixo, se compararmos com as melhores.

--Mirla: Também estamos planejando algumas categorias que queremos colocar na página inicial para torná-la mais atraente. Você consegue nos informar quais delas venderam mais na última Black Friday para tomarmos essa prioridade?

--Igor: Podemos fazer isso. Temos uma consulta que retorna as mesmas informações, mas do ponto de vista das categorias. Consigo aplicar um filtro semelhante para focar na Black Friday.

--Após o último JOIN, vamos adicionar o mesmo WHERE strftime() utilizado anteriormente.

--SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", c.nome_categoria AS Nome_Categoria, COUNT(iv.produto_id) AS Qtd_Vendas
--FROM itens_venda iv
--JOIN vendas v ON v.id_venda = iv.venda_id
--JOIN produtos p ON p.id_produto = iv.produto_id
--JOIN categorias c ON c.id_categoria = p.categoria_id
--WHERE strftime("%m", v.data_venda) = "11"
--GROUP BY Nome_Categoria, "Ano/Mes"
--ORDER BY "Ano/Mes", Qtd_Vendas
--;
--COPIAR CÓDIGO
--Após executar a consulta em "Run", ele traz o mesmo formato, mas agora com menos linhas, porque temos cinco categorias contra os dez fornecedores que tínhamos.

--Olhando para 2022, temos cinco resultados para novembro. Vendemos mais nas categorias de eletrônicos e vestuário, sendo "Eletrônicos" com 2.808 vendas e "Vestuário" com 2.609 vendas. Esses foram os dois destaques de categoria na última Black Friday.

--Mirla: Ótimo! Para fechar o planejamento, você consegue me informar quais dessas categorias menos venderam?

--Igor: Consigo. A categoria que teve menos venda foi a de "Livros", com 1.407 vendas. Porém, para deixá-la bem informada, existiu uma proximidade no número de vendas tanto em "Alimentos" quanto em "Esportes", respectivamente, 1.425 e 1.454. Então, por mais que "Livros" tenha sido a que menos vendeu, ela está bem próxima a essas outras duas categorias.

--Mirla: Isso vai me ajudar muito! Ainda há um ponto antes de encerrar. Você falou da NebulaNetworks e me veio a ideia de conversar com esse fornecedor, mas gostaríamos de levar dados para mostrar o desempenho de vendas deles, até para negociar novos valores.

--Você consegue trazer esse conjunto de dados para levarmos a eles?

--Igor: Sim, temos acesso a essa informação, mas não preparamos uma consulta para isso. Precisaríamos pensar com calma, montar essa consulta. Podemos fornecer esses dados posteriormente por e-mail?

--Mirla: Esses dados estão realmente atualizados, certo?

--Igor: É uma boa pergunta, Mirla. Vou confirmar junto com você. A partir das nossas análises, sabemos que o total de vendas nesses últimos anos deu 150 mil itens. Então, conseguimos usar essa consulta para fazer uma validação.

--Na parte dos dados dos fornecedores, vamos remover o filtro para novembro para considerar todo o ano, e vamos transformar essa consulta em uma sub consulta. Para isso, selecionamos a consulta e apertamos "Tab" para indentá-la à direita.

--Em seguida, vamos digitar o comando FROM na primeira linha, abrir parênteses e colocar a sub consulta.

--FROM (
--  SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id)   AS Qtd_Vendas
--  FROM itens_venda iv
--  JOIN vendas v ON v.id_venda = iv.venda_id
--  JOIN produtos p ON p.id_produto = iv.produto_id
--  JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--  GROUP BY Nome_Fornecedor, "Ano/Mes"
--  ORDER BY "Ano/Mes", Qtd_Vendas
--)
--;
--COPIAR CÓDIGO
--Agora podemos executar essa consulta e somar a quantidade de itens vendidos, já que temos todos os itens. Assim, vamos obter os 150 mil itens vendidos. Para isso, vamos adicionar o comando SELECT ao início da consulta e fazer um SUM() da quantidade de vendas (Qtd_Vendas).

--SELECT SUM(Qtd_Vendas)
--FROM (
--  SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id)   AS Qtd_Vendas
--  FROM itens_venda iv
--  JOIN vendas v ON v.id_venda = iv.venda_id
--  JOIN produtos p ON p.id_produto = iv.produto_id
--  JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--  GROUP BY Nome_Fornecedor, "Ano/Mes"
--  ORDER BY "Ano/Mes", Qtd_Vendas
--)
--;
--COPIAR CÓDIGO
--Após selecionar a consulta e apertar "Run", é retornado o valor de 150.034 vendas. Sendo assim, os dados estão atualizados, Mirla, pode ficar tranquila!

--Mirla: Perfeito, Igor. Agora que temos essa confiança de que os dados realmente estão atuais, vamos ficar no aguardo de você mandar esse conjunto de dados, certo?

--Até a próxima. Muito obrigada pelo seu tempo!

--Igor: Obrigado, Mirla. Tchau!

--Conclusão
--Conseguimos fazer a reunião com a Mirla da área de negócios e foi uma reunião muito produtiva. Respondemos os principais questionamentos dela usando as consultas que preparamos. Foi uma conversa bem ágil, onde conseguimos trazer dados e informações para ela tomar decisões para a Black Friday.

--Um ponto importante é que uma das demandas exigia uma consulta mais elaborada que precisávamos construir para falar do fornecedor da NebulaNetwork e como foi a performance dela ao longo desses anos.

--Isso ficou como tarefa para nós e vamos resolvê-la daqui a pouco!