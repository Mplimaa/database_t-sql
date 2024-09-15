drop table T_heap;
CREATE TABLE T_heap (a int NOT NULL, b int NOT NULL, c int NOT NULL, d int NOT NULL, e int NOT NULL, f int NOT NULL); 

declare @contador int
declare @max int
SET @contador = 1
SET @max = 50
WHILE @contador <= @max
BEGIN
   insert into T_heap (a,b,c,d,e,f) values ([dbo].[NumeroAleatorio](1,100), [dbo].[NumeroAleatorio](1,100),[dbo].[NumeroAleatorio](1,100),[dbo].[NumeroAleatorio](1,100),[dbo].[NumeroAleatorio](1,100),@contador)
   set @contador = @contador + 1
END

SELECT b, c FROM t_heap where b = 68 and c= 55

CREATE NONCLUSTERED INDEX T_heap_a ON T_heap (a); 

SELECT b FROM t_heap WHERE b = 1

SELECT a FROM t_heap WHERE a = 1

CREATE INDEX T_heap_bc ON T_heap (b, c); 

SELECT b, c  FROM t_heap WHERE b = 1 and c = 1

SELECT b  FROM t_heap WHERE b = 1 and c = 1

SELECT a  FROM t_heap WHERE b = 1 and c = 1

CREATE INDEX T_heap_d ON T_heap (d) INCLUDE (e); 

SELECT d, e FROM t_heap WHERE d = 1 and e = 1

SELECT e, d FROM t_heap WHERE d = 1 and e = 1

SELECT e FROM t_heap WHERE d = 1 and e = 1

SELECT a FROM t_heap WHERE d = 1 and e = 1

CREATE UNIQUE INDEX T_heap_f ON T_heap (f); 

SELECT f FROM t_heap WHERE f = 1

SELECT a FROM t_heap WHERE f = 1

drop table T_clu;
CREATE TABLE T_clu (a int NOT NULL, b int NOT NULL, c int NOT NULL, d int NOT NULL, e int NOT NULL, f int NOT NULL); 

declare @contador int
declare @max int
SET @contador = 1
SET @max = 50
WHILE @contador <= @max
BEGIN
   insert into T_clu (a,b,c,d,e,f) values (@contador, [dbo].[NumeroAleatorio](1,100), [dbo].[NumeroAleatorio](1,100),[dbo].[NumeroAleatorio](1,100),[dbo].[NumeroAleatorio](1,100), @contador)
   set @contador = @contador + 1
END

CREATE UNIQUE CLUSTERED INDEX T_clu_a ON T_clu (a); 

SELECT * FROM T_clu where b = 68 and c= 55

SELECT * FROM T_clu where a = 50

CREATE INDEX T_clu_b ON T_clu (b, c); 

SELECT b, c FROM T_clu where b = 50 and c = 50

SELECT e FROM T_clu where b = 50 and c = 50

CREATE INDEX T_clu_d ON T_clu (d) INCLUDE (e); 

SELECT d, e FROM T_clu where d = 2 and e = 2

CREATE UNIQUE INDEX T_clu_f ON T_clu (f);

SELECT * FROM T_clu where f = 1 


