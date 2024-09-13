--No vídeo anterior fizemos o backup da nossa base de dados em determinados dias. Nesse vídeo, entenderemos como recuperar esses backups.

--Recuperando backups
--Voltando para o Management Studio, onde criaremos uma nova consulta conectada à base dbVendas. Nela colaremos o seguinte código para recuperarmos o backup:

RESTORE HEADERONLY FROM DISK = 'F:\DATA\BACKUP\DBVENDAS_3.BAK';

USE MASTER
DROP DATABASE dbVendas
RESTORE DATABASE dbVendas FROM DISK = 'F:\DATA\BACKUP\DBVENDAS_3.BAK' WITH RECOVERY;

--Criando uma nova entrada
--Como o último backup que salvamos foi o DBVENDAS_3.BAK, onde incluímos as notas fiscais do dia 02/03/2022, antes de recuperarmos esse backup, incluiremos notas para o dia 03/05/2022. Então, antes do código acima, escreveremos EXEC IncluiNotasDia '2022-03-03' e executaremos essa linha.
--Em seguida, podemos executar o SELECT COUNT(*) FROM tb_nota para descobrir quantas notas temos agora, no caso, 3564. Aproveitamos para anotar esse valor em forma de comentário, como fizemos na aula anterior.

EXEC IncluiNotasDia '2022-03-03'
SELECT COUNT(*) FROM tb_nota
-- 3564

--código omitido


--Digamos que nesse dia 03, tivemos um problema na pasta e o pessoal do sistema avisa para o Marcos que ele precisa recuperar o backup anterior aos dados do dia 03, ou seja, o DBVENDAS_3.BAK. Como o Marcos fará isso?

--Analisando o último backup
--Primeiramente Marcos irá verificar o que existe nesse arquivo de backup, rodando a linha com o comando RESTORE HEADERONLY, usando o FROM DISK para passar o caminho completo do arquivo de backup:

--Ao executarmos o código RESTORE HEADERONLY FROM DISK = 'F:\DATA\BACKUP\DBVENDAS_3.BAK';, temos como retorno uma tabela com apenas uma linha de dados. Nela vemos que o tipo de backup (BackupType) é 1, ou seja, backup full (backup completo). Avançando para direita, temos também os dados de quando o backup foi iniciado (StartDate) e quando foi finalizado (FinishDate).

--Saindo da base de dados
--Para recuperarmos esse backup, precisamos sair da base dbVendas primeiro e não ter nenhuma pessoa usuária conectada à base. No momento, eu tenho algumas abas abertas no Management Studio, além da consulta atual. Cada uma dessas janelas está conectada com a base dbVendas.

--Portanto, nosso primeiro passo será sair da base dbVendas, rodando a linha de comando USE MASTER. Dessa forma, fomos para base Master.

--Excluindo a base de dados


--Excluindo a base de dados
--Em seguida, vamos excluir a base dbVendas. Porém, ao invés de executarmos a linha de comando DROP DATABASE dbVendas manualmente, faremos a execução através do Management Studio.

--Isso porque, para rodarmos o comando DROP DATABASE dbVendas, primeiramente precisaríamos fechar todas as janelas que estão conectadas ao banco de dados. Dessa forma, seria como se desconectássemos todas as seções conectadas ao dbVendas.

--Antes disso, executaremos o DROP DATABASE pelo Management Studio. Isso porque, clicando com o botão direito do mouse sobre o banco "dbVendas" e selecionando a opção "Excluir", na parte inferior da janela que se abre temos a opção "Fechar conexões existentes".

--Marcaremos a caixa de seleção dessa opção, todas as conexões serão desligadas no momento em que apagarmos a base de dados dbVendas. Em seguida, clicamos no botão "OK", no canto inferior direito da janela.

--Feito isso, nossa base de dados desaparece, tanto da barra lateral esquerda no Management Studio, quanto das pastas "LOG_TRANSACOES" e "ARQUIVO_DADOS", no nosso computador.

--Restaurando o backup
--Nosso próximo passo será restaura o backup, executando:

RESTORE DATABASE dbVendas FROM DISK = 'F:\DATA\BACKUP\DBVENDAS_3.BAK' WITH RECOVERY;


--Nessa linha temos o comando RESTORE DATABASE, seguido do nome do banco de dados. Também temos o FROM DISK com o caminho completo do backup. Por fim, temos a cláusula WITH RECOVERY, que é muito importante.

--Vamos supor que nossa base de dados está sendo usada e tiramos um backup. Pode ser que no momento em que o backup esteja acontecendo, também tenhamos transações sendo executadas, portanto essas transações não serão salvas no backup.

--Ao recuperarmos o backup, precisamos adicionar a cláusula WITH RECOVERY para sabermos se essas transações que estavam sendo concluídas são levadas ou não em consideração no momento de recuperação desse backup. No caso, ao escrevermos essa cláusula, garantimos que tudo o que foi salvo por esse backup completo será recuperado.

--Executando esse código, ele recupera o backup, então dentro das pastas "LOG_TRANSACOES" e "ARQUIVO_DADOS" o arquivo dbVendas.MDF voltou. Com isso, na parte superior do Management Studio, podemos voltar a nos conectar com o base de dados dbVendas.

--Em seguida, depois da última linha de código, pressionaremos "Enter" duas vezes e codaremos SELECT COUNT(*) FROM tb_nota. Ao executarmos esse código, percebemos que temos 3469 notas, que é o mesmo valor que tínhamos quando fizemos o backup do dia 02/03/2022, como podemos conferir na consulta passada.

--Vamos recuperar o segundo backup. Para isso, vamos copiar o bloco de código de recuperação de backup e o colar ao final do código, lembrando de mudar o nome do arquivo para DBVENDAS_2.BAK.

--código omitido

USE MASTER
DROP DATABASE dbVendas
RESTORE DATABASE dbVendas FROM DISK = 'F:\DATA\BACKUP\DBVENDAS_2.BAK' WITH RECOVERY;

--Em seguida, na coluna da esquerda, clicaremos na pasta "Banco de Dados" com o botão direito do mouse e selecionaremos a opção "Atualizar". Ao fazermos isso, a opção "dbVendas" volta a aparecer na lista.

--Clicaremos com o botão direito do mouse sobre dbVendas e selecionaremos a opção "Excluir". Na janela que é aberta, marcaremos novamente a opção "Fechar conexões existentes" e clicaremos no botão "OK". Por fim, executamos a linha de código de recuperação do backup.

--Em seguida, podemos selecionar novamente a base de dados "dbVendas" na parte superior da janela. Após o bloco de código, vamos colar o comando SELECT COUNT(*) FROM tb_nota e o executar. Dessa vez o retorno foi de 3322 notas, que é o número salvo no backup 2.

--Conclusão
--É dessa forma que recuperamos backups:

--Saímos da base;
--Deletamos a base, com código DROP DATABASE ou através do Management Studio;
--Recuperamos o backup com o RESTORE DATABASE;
--Voltamos para base de dados, deixando-a disponível.
--Precisamos considerar que se fizermos o backup completo, todas as características da base, incluindo a localização dos arquivos de dados e de log, são recuperados nos diretórios onde estavam quando o backup foi feito.


-- DISCUTIR NO FÓRUM
--PRÓXIMA ATIVIDADE
--ícone Microsoft SQL Server 2022: administrando o banco de dados Microsoft SQL Server 2022: administrando o banco de dados
--42% 
--AULA
--03
-- Criando e restaurando Backups
-- AULA ATUAL


