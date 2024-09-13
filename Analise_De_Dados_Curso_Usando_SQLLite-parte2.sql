--Transcrição
--Conseguimos participar da reunião e atendemos muito bem a demanda do time de negócios, mas ficou uma tarefa pendente. Precisamos trazer uma informação para eles, relacionada ao fornecedor que teve a pior performance na última Black Friday.

--Eles querem a informação desse fornecedor ao longo de todo o tempo que temos registrado, para poderem argumentar junto ao fornecedor sobre sua performance e negociar preços melhores. Então, queremos fornecer esse recurso de dados para os argumentos do time de negócios.

--Dever de casa
--De volta ao SQLite Online, podemos copiar a consulta que fizemos durante a reunião, onde conseguíamos calcular a performance dos fornecedores, e executá-la.

--SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
--FROM itens_venda iv
--JOIN vendas v ON v.id_venda = iv.venda_id
--JOIN produtos p ON p.id_produto = iv.produto_id
--JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--GROUP BY Nome_Fornecedor, "Ano/Mes"
--ORDER BY "Ano/Mes", Qtd_Vendas
--;
--COPIAR CÓDIGO
--Visualização dos cinco primeiros registros da tabela. Para visualizá-la na íntegra, execute a consulta na sua máquina.

--Ano/Mes	Nome_Fornecedor	Qtd_Vendas
--2020/01	OceanicOrigins	170
--2020/01	NebulaNetworks	193
--2020/01	PinnaclePartners	195
--2020/01	TerraTrade	204
--2020/01	InfinityImports	213
--A consulta mostra vários fornecedores e queremos focar apenas naquele que teve a pior performance na última Black Friday, que ocorreu em 2022 no mês de novembro. Os dados estão ordenados do menor para o maior, então procuramos pelo primeiro com a data 2022/11.

--Em 2022, no mês 11, o fornecedor com menor número de vendas durante a Black Friday foi a NebulaNetworks. Essa foi a informação que passamos na reunião e estava correta.

--Criando a nova consulta
--Vamos copiar o nome da NebulaNetwork e começar a criar uma consulta. Na consulta existente, que calcula, ao longo do tempo, cada fornecedor, queremos fazer um filtro.

--Após o último JOIN, vamos digitar o comando WHERE seguido do nome do fornecedor (Nome_Fornecedor). Queremos que ele seja igual a "NebulaNetworks". Dessa maneira, a consulta trará apenas os dados do fornecedor NebulaNetworks.

--SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
--FROM itens_venda iv
--JOIN vendas v ON v.id_venda = iv.venda_id
--JOIN produtos p ON p.id_produto = iv.produto_id
--JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--WHERE Nome_Fornecedor="NebulaNetworks"
--GROUP BY Nome_Fornecedor, "Ano/Mes"
--ORDER BY "Ano/Mes", Qtd_Vendas
--;
--COPIAR CÓDIGO
--Ao executar a consulta, verificamos que o nome do fornecedor se repete várias vezes na tabela e foram trazidos menos dados, pois agora falamos apenas de um fornecedor.

--A ordenação começa em 2020 e vai até 2023, mas os meses estão um pouco embaralhados. Se observarmos 2023, começamos no mês 1, passamos pelos meses 2, 3, 4 e vamos até o mês 9, pois essa Black Friday ainda não aconteceu no ano de 2023.

--Na tabela, temos o ano da venda, o mês, o nome do fornecedor e a quantidade de vendas. A quantidade de vendas é um valor importante, pois será usado para argumentação. No entanto, o nome do fornecedor é uma informação que se repete. Precisamos dessa informação no CSV? Acreditamos que não!

--Vamos ajustar a consulta. No local onde definíamos o apelido Nome_Fornecedor, vamos copiar f.nome, apagar essa coluna da consulta, e no local onde fazemos o WHERE, vamos usar f.nome em vez de Nome_Fornecedor. Da mesma forma, colocaremos f.nome onde fazemos o agrupamento (GROUP BY).

--SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", COUNT(iv.produto_id) AS Qtd_Vendas
--FROM itens_venda iv
--JOIN vendas v ON v.id_venda = iv.venda_id
--JOIN produtos p ON p.id_produto = iv.produto_id
--JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--WHERE f.nome="NebulaNetworks"
--GROUP BY f.nome, "Ano/Mes"
--ORDER BY "Ano/Mes", Qtd_Vendas
--;
--COPIAR CÓDIGO
--Ao executar a consulta novamente, temos a seguinte visualização:

--Visualização dos cinco primeiros registros da tabela. Para visualizá-la na íntegra, execute a consulta na sua máquina.

--Ano/Mes	Qtd_Vendas
--2020/01	193
--2020/02	90
--2020/03	96
--2020/04	106
--2020/05	165
--A ordenação ajuda o time da área de negócios a argumentar. Eles conseguem acompanhar desde 2020, no primeiro mês, com 193 vendas, até a venda mais recente, em outubro de 2023, com 139 vendas. Assim, o time pode argumentar e verificar essas datas-chave.

--Embora sejam fornecidas todas essas informações para conversarem sobre outros meses, se o time quiser focar apenas na Black Friday, estarão listados os meses para encontrar. Por exemplo: em novembro de 2021 (2021/11) foram 455 vendas, e em novembro de 2020 (2022/11) foram 307.

--Fornecendo a informação
--Acreditamos que, com essa informação, conseguimos atender a demanda de tarefa pendente, deixada para nós na reunião. Agora, precisamos fornecer essa informação para eles.

--Para extrairmos uma informação do SQLite Online, transformá-la em uma consulta e fornecer para outra pessoa, uma das maneiras é clicando no botão "Export" na barra de menu superior.

--No centro da barra, encontramos esse botão chamado "Export" que oferece algumas opções: "CSV", "XML", "JSON" e "SQL Schema". Estamos interessados no CSV.

--Ao clicar nessa opção, é aberta uma janela, onde informa que o tipo do arquivo será CSV, que o delimitador será uma vírgula, que o escape será aspas duplas, e o campo "Column name" está definido como "none".

--Este é o campo que queremos que você preste atenção, porque, dessa maneira, ele não especifica o nome das colunas. Vamos alterar de "none" para "First line". Assim, na primeira linha do CSV, será informado "Ano/Mes" e "Qtd_Vendas". Quem acessar esse CSV, facilmente saberá do que se trata.

--Ao confirmar, ele pergunta onde queremos salvar. Podemos criar uma pasta de "outputs" e nomear o arquivo como NebulaNetworks_vendas.csv. Salvamos essa informação, ela está no nosso computador, e agora podemos encaminhar por e-mail para todos que participaram da reunião. Assim, eles terão essa informação e quem for negociar terá argumentos baseados em dados.

--Conclusão
--Estamos felizes que conseguimos responder à reunião e atender à demanda dela! Agora estamos prontos para começar a construir nosso relatório.

--Chegamos nesse projeto com o intuito de criar um relatório que vai guiar as decisões da Black Friday. É isso que queremos fazer agora: explorar esses dados e decidir quais informações são importantes para colocar no relatório ou não.

--Até mais!