DECLARE @NOME VARCHAR (200)
DECLARE CURSOR1 CURSOR FOR SELECT TOP 4 NOME FROM [TABELA DE CLIENTES]
OPEN CURSOR1
FETCH NEXT FROM CURSOR1 INTO @NOME
WHILE @@FETCH_STATUS = 0 
BEGIN
	PRINT @NOME
	FETCH NEXT FROM CURSOR1 INTO @NOME
END



DECLARE @FUNCIONARIOS  TABLE  
(NOME VARCHAR(50), SALARIO FLOAT)

INSERT INTO @FUNCIONARIOS (NOME,SALARIO)values ('MARIA', 5628.00),('VALESKA', 3454.99), ('Michele', 3900.00)
DECLARE CURSOR2 CURSOR FOR SELECT NOME FROM @FUNCIONARIOS
OPEN CURSOR2
FETCH NEXT FROM CURSOR2 INTO @NOME
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT @NOME
	FETCH NEXT FROM CURSOR2 INTO @NOME
END


--DECLARE @nome VARCHAR(50)
--DECLARE funcionario_cursor CURSOR FOR
--    SELECT nome
--    FROM funcionarios

--OPEN funcionario_cursor

--FETCH NEXT FROM funcionario_cursor INTO @nome

--WHILE @@FETCH_STATUS = 0
--BEGIN
--    PRINT 'Nome: ' + @nome
--    FETCH NEXT FROM funcionario_cursor INTO @nome
--END

--CLOSE funcionario_cursor
--DEALLOCATE funcionario_cursor


---Exercício cursor
--Podemos criar um cursor e jogar a consulta mostrada no enunciado para um cursor e, ao percorrer linha a linha, 

--efetuar um PRINT mostrando o nome do funcionário.
DECLARE @nome VARCHAR(50)
declare @FUNCIONARIOS  TABLE  
(NOME VARCHAR(50), SALARIO FLOAT)
 INSERT INTO @FUNCIONARIOS (NOME,SALARIO)values ('MARIA', 5628.00),('VALESKA', 3454.99), ('Michele', 3900.00)

DECLARE funcionario_cursor CURSOR FOR
    SELECT nome
    FROM @FUNCIONARIOS

OPEN funcionario_cursor

FETCH NEXT FROM funcionario_cursor INTO @nome

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Nome: ' + @nome
    FETCH NEXT FROM funcionario_cursor INTO @nome
END

CLOSE funcionario_cursor
DEALLOCATE funcionario_cursor
SELECT nome, SALARIO
    FROM @FUNCIONARIOS