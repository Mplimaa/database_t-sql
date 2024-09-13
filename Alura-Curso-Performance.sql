
USE DB_VENDAS
ALTER DATABASE DB_VENDAS SET RECOVERY SIMPLE
DBCC SHRINKDATABASE ('DB_VENDAS', NOTRUNCATE)
DBCC SHRINKDATABASE ('DB_VENDAS', TRUNCATEONLY)
ALTER DATABASE DB_VENDAS SET RECOVERY FULL


/*arquivo Reduzinho-base.sql

Um ponto de atenção para o DBA é a verificação constante do espaço em disco disponível no servidor onde a base de dados está armazenada. 
Isso porque a base de dados do SQL Server tende a crescer muito, principalmente os arquivos de log e transações, à medida que o banco 
vai sendo utilizado.
A diminuição do espaço livre em disco pode afetar a performance do sistema. Por isso, o DBA também deve verificar o crescimento da base.

Na seção de atividade abaixo deste vídeo, há um link para download do script Reduzindo Base.sql. Vamos copiá-lo para o nosso diretório
de trabalho. Voltando ao Management Studio, vamos carregar esse novo script clicando em "Arquivo > Abrir > Arquivo > Reduzindo Base.sql
> Abrir". O script que se abre é o seguinte:

USE DB_VENDAS
ALTER DATABASE DB_VENDAS SET RECOVERY SIMPLE
DBCC SHRINKDATABASE ('DB_VENDAS', NOTRUNCATE)
DBCC SHRINKDATABASE ('DB_VENDAS', TRUNCATEONLY)
ALTER DATABASE DB_VENDAS SET RECOVERY FULLCOPIAR CÓDIGO

Note que ele está executando quatro comandos — o comando USE no início está apenas reposicionando o script para ser executado na base 
DB VENDAS. Esses quatro comandos irão reduzir o tamanho da base de dados do banco de dados porque, à medida que o banco vai sendo 
utilizado, muita coisa desnecessária será gravada nele.

Basicamente, o primeiro comando, ALTER DATABASE com o SET RECOVERY SIMPLE, é usado para modificar as configurações do banco de dados.
Quando usamos a função de recuperação definindo a opção SIMPLE, o SQL Server não mantém nenhum log de transação completo.

Isso significa que, ao recuperar os dados da base de dados, eliminará os dados de transações de log. Isso pode ser perigoso se você
tem a necessidade de um rollback dos dados. Por isso, ao rodar os comandos de redução da base de dados, é importante ter certeza de
que você realizou um backup do banco e que seus usuários não estão utilizando esse banco.

O segundo comando se chama DBCC SHRINKDATABASE. Com ele, reduzimos o tamanho do banco de dados removendo todo o espaço não utilizado.
O parâmetro NOTRUNCATE significa que o arquivo do banco de dados não será encurtado além do tamanho atual, mesmo que haja espaço 
inutilizado.

O terceiro comando também é o DBCC SHRINKDATABASE, mas com o parâmetro TRUNCATEONLY. Ele removerá apenas o espaço não utilizado no 
final do arquivo do banco de dados. Isso significa que o tamanho do arquivo será reduzido sem mover dados.

O último comando é o ALTER DATABASE novamente, dessa vez com o parâmetro SET RECOVERY FULL. Com essa opção definida, o SQL Server
mantém o log de transação completo — então, permite que você volte a gravar as transações do banco. Ou seja, se você não passar o
seu banco novamente para RECOVERY FULL, estará limitando a capacidade de salvar os logs de transação.

No entanto, para reduzir o tamanho, você precisa passar o banco para RECOVERY SIMPLE, ou seja, eliminar a necessidade de salvar o
log de transação, para então reduzir a base e, finalmente, voltar ao status original.

Então, vamos verificar o tamanho da base nesse momento. Para isso, clicamos no nome da base "DB_VENDAS" no menu lateral esquerdo 
com o botão direito do mouse e, em seguida, clicamos em "Propriedades". Na janela de propriedades, clicamos em "Arquivos" no menu
lateral esquerdo. Nessa tela, veremos todas as propriedades do nosso banco de dados. Na tabela, temos um campo chamado "Tamanho (MB)"
em que podemos ver o tamanho do banco:

3105 MB do banco de dados "DB_VENDAS"
4104 MB de log de transação
Podemos clicar em "Cancelar" para fechar essa janela de propriedades do banco de dados.

Agora, vamos executar os comandos do script Reduzindo Base.sql. Ele roda rapidamente e, se acessarmos novamente a janela de 
Propriedades do Banco, veremos que seu tamanho foi reduzido:

3068 MB do banco de dados "DB_VENDAS"
8 MB de log de transação
O tamanho do banco diminuiu pouco, mas o do log de transação reduziu bastante. Economizamos 4GB de espaço! Claro que, se quisermos
dar um rollback numa transação que estava parada no meio, não conseguiremos porque apagamos todo o log de transação. Mas, houve uma 
economia muito grande de espaço.

É importante que nós, como DBAs, tenhamos este script em mãos para reduzir periodicamente o tamanho da base de dados, economizando
espaço em disco e evitando que ele se esgote. Isso pode acontecer com a máquina onde o banco de dados SQL Server está salvo. 
Portanto, é fundamental manter um controle constante do espaço livre em disco disponível.

Um abraço e até o próximo vídeo!

*/


/*

A falta de espaço em disco em um servidor de banco de dados SQL Server pode afetar negativamente o desempenho e a integridade 
dos dados armazenados. O DBA deve monitorar o crescimento da base de dados ao longo do tempo, lembrando que esse crescimento
não é diretamente proporcional à quantidade de dados, pois o arquivo de LOG, que armazena as transações para posteriores 
COMMITs e ROLLBACKs, é o principal responsável pelo consumo de espaço em disco.

Das opções abaixo, quais são as alternativas verdadeiras?

A falta de espaço em disco pode levar à perda de desempenho do servidor.


A falta de espaço em disco pode levar à perda de desempenho do servidor, porque o SQL Server precisa alocar espaço em disco de
maneira fragmentada, o que pode levar a uma diminuição do desempenho de leitura e gravação.

Alternativa correta
A falta de espaço em disco pode levar à fragmentação do espaço em disco e diminuir o desempenho de leitura e gravação.


A falta de espaço em disco pode levar à fragmentação do espaço em disco, o que pode levar a uma diminuição do desempenho
de leitura e gravação.

Alternativa correta
A falta de espaço em disco pode levar à falha do servidor de banco de dados SQL Server.


A falta de espaço em disco pode levar à falha total do servidor de banco de dados SQL Server, se o espaço em disco for 
completamente esgotado.
*/