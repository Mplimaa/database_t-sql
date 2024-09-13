BACKUP DATABASE dbVendas TO DISK = 'C:\DATA\BACKUP\DBVENDAS.BAK';

EXEC IncluiNotasDia '2022-03-01'

--Na primeira linha temos o comando BACKUP DATABASE, o nome da base de dados (dbVendas), o comando TO DISK para indicar o local que queremos salvar a base de dados, e o caminho completo com o nome do backup e a extensão ".BAK".

--Antes de executarmos esse backup, contaremos o número de notas fiscais que temos na base neste momento, executando o comando SELECT COUNT(*) FROM tb_nota;. O retorno foi 3253, mas se lembrem que esse número pode ser diferente do seu resultado. Entretanto, vamos criar um comentário com essa valor antes do código.


SELECT COUNT(*) FROM tb_nota;

-- 3253 notas

BACKUP DATABASE dbVendas TO DISK = 'F:\DATA\BACKUP\DBVENDAS. BAK';

EXEC IncluiNotasDia '2022-03-01'


--Agora vamos selecionar e executar o comando BACKUP DATABASE dbVendas TO DISK = 'F:\DATA\BACKUP\DBVENDAS.BAK';. Fazendo isso, salvamos nosso backup na pasta que criamos, tanto que, se acessarmos essa pasta, encontraremos o arquivo DBVENDAS.BAK, que tem um tamanho de 10.360 KB.

--Nesse caso, incluímos as notas de janeiro e fevereiro. Agora executaremos o comando EXEC IncluiNotasDia '2022-03-01' para incluirmos notas no dia 01/03/2022, simulando uma entrada de dados de notas fiscais nesse dia.

--Em seguida, copiaremos o comando SELECT COUNT(*) FROM tb_nota; e vamos colar na linha abaixo do EXEC. Depois, selecionaremos esse código e clicaremos no botão de executar, para contarmos novamente o número de notas. O resultado agora é 3322 notas, então vamos salvar esse valor em forma de comentário.

-- código omitido

EXEC IncluiNotasDia '2022-03-01'
SELECT COUNT(*) FROM tb_nota;

-- 3322


--Após o comentário, pressionaremos "Enter" duas vezes e colaremos o comando de backup novamente, mudando apenas o nome do arquivo para DBVENDAS_2.BAK. Depois selecionamos a linha BACKUP DATABASE dbVendas TO DISK = 'F:\DATA\BACKUP\DBVENDAS_2.BAK'; e clicamos no botão de Executar, criando um novo arquivo de backup.

--Criaremos agora notas fiscais para o dia 02/03/2022, com o comando EXEC IncluiNotasDia '2022-03-02'. Em seguida, consultaremos o novo valor total de notas, com o SELECT, que é 3469, e escreveremos como um comentário no código. Por fim, faremos um novo backup, salvando no arquivo DBVENDAS_3.BAK';.



-- código omitido

EXEC IncluiNotasDia '2022-03-02'
SELECT COUNT(*) FROM tb_nota;

-- 3469

BACKUP DATABASE dbVendas TO DISK = 'F:\DATA\BACKUP\DBVENDAS.BAK';


--Temos agora três backups: o primeiro com 3253 notas, o segundo com 3322 notas e o terceiro com 3469 notas. Abrindo a pasta "BACKUP", encontramos os três arquivos, como se tivéssemos feito um backup ao final de dia.

--Se tivermos problemas em um determinado dia, temos como perguntar para pessoa usuária qual é o dia de backup que ela quer recuperar. Pode ser o mais atual, que é o DBVENDAS_3.BAK, ou o de dois dias antes, que é o DBVENDAS_2, e assim por diante.

--Talvez o Marcos poderia colocar um dia de referência concatenado ao nome dos backups. De toda forma, ele pode fazer backups todos os dias e os guardar para uma eventual emergência, na qual esses dados precisam ser recuperados.

--Vamos parar o vídeo por aqui e, a seguir, aprenderemos como recuperar o backup.













