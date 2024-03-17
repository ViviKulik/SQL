USE Anticariat
GO

CREATE VIEW view1 AS
	SELECT id_carte, titlu, ani, id_prod FROM CartiT;
GO


CREATE VIEW view2 AS
	SELECT C.titlu, A.nume_aut
	FROM CartiT C
	INNER JOIN Carti_autoriT Ca ON
	C.id_carte=Ca.id_carte
	INNER JOIN AutoriT A ON
	Ca.id_aut=A.id_aut

GO 

CREATE VIEW view3 AS
	SELECT COUNT(C.id_carte) nr_carti
	FROM CartiT C
	INNER JOIN Carti_autoriT Ca ON
	C.id_carte=Ca.id_carte
	INNER JOIN AutoriT A ON
	Ca.id_aut=A.id_aut
	WHERE A.nume_aut='Valeriu'
	GROUP BY A.id_aut, A.nume_aut;

GO

DROP VIEW view3

insert into Views (Name) values('view1'),('view2'),('view3')
select * from Views

insert into Tables (Name) values('CartiT'),('AutoriT'),('Carti_autoriT')
select * from Tables


INSERT INTO Tests (Name)
VALUES	('DI_CartiAutori_view1'),
		('DI_Carti_view2'),
		('DI_Autori_view3');
SELECT * FROM Tests;

UPDATE Tests SET Name = 'DI_AutoriT_view3' WHERE TestID=3;

INSERT INTO TestTables (TestID, TableID, NoOfRows, Position)
VALUES	(3, 2, 100, 1),
		(2, 1, 50, 1),
		(1, 1, 100, 1),
		(1, 2, 100, 2),
		(1, 3, 100, 3);
GO


INSERT INTO TestViews (TestID, ViewID)
VALUES	(1, 1),
		(2, 2),
		(3, 3);
		
SELECT * FROM TestViews;
GO

CREATE OR ALTER PROCEDURE insertAutoriT @NoOfRows INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @nume_aut VARCHAR(50);
	DECLARE @n INT = 1;
	DECLARE @current_id INT = 1;

	WHILE @n <= @NoOfRows
	BEGIN
		SET @nume_aut = 'Autor' + CONVERT(VARCHAR(10), @current_id);
		INSERT INTO AutoriT(nume_aut)
		VALUES (@nume_aut);
		SET @current_id = @current_id + 1;
		SET @n = @n + 1;
	END

	PRINT 'S-au inserat ' + CONVERT(VARCHAR(10), @NoOfRows) + ' autori'; 
END
GO
EXEC insertAutoriT 100;
GO
SELECT * FROM  AutoriT

GO 

CREATE OR ALTER PROCEDURE insertCartiT @NoOfRows INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @fk INT = 
			(SELECT MAX(p.id_produs) FROM Produse p);
	DECLARE @titlu VARCHAR(50);
	DECLARE @ani INT;
	DECLARE @n INT = 1;
	DECLARE @current_id INT = 1;

	WHILE @n <= @NoOfRows
	BEGIN
		SET @titlu = 'Titlu' + CONVERT(VARCHAR(10), @current_id);
		SET @ani = 1900+@current_id;
		INSERT INTO CartiT(titlu, ani, id_prod)
		VALUES (@titlu, @ani, @fk);
		SET @current_id = @current_id + 1;
		SET @n = @n + 1;
	END

	PRINT 'S-au inserat ' + CONVERT(VARCHAR(10), @NoOfRows) + ' carti';
END
GO

EXEC insertCartiT 50;
SELECT * FROM CartiT

GO


SELECT * FROM AutoriT
go

CREATE OR ALTER PROCEDURE insertCarti_autoriT @NoOfRows INT 
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @n INT = 0;
	DECLARE @fk1 INT;
	INSERT INTO AutoriT(nume_aut)
	VALUES ('Valeriu');
	DECLARE @fk2 INT = 
			(SELECT MAX(s.id_aut) FROM AutoriT s WHERE s.nume_aut = 'Valeriu');
	
	DECLARE cursorCarti CURSOR FAST_FORWARD FOR
	SELECT c.id_carte FROM CartiT c WHERE c.titlu LIKE 'titlu%';
	
	OPEN cursorCarti;
	
	FETCH NEXT FROM cursorCarti INTO @fk1;
	WHILE (@n < @NoOfRows) AND (@@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO Carti_autoriT(id_carte, id_aut)
		VALUES (@fk1, @fk2);
		SET @n = @n + 1;
		FETCH NEXT FROM cursorCarti INTO @fk1;
	END

	CLOSE cursorCarti;
	DEALLOCATE cursorCarti;

	PRINT 'S-au inserat ' + CONVERT(VARCHAR(10), @n) + ' carti_autor';
END
GO




CREATE PROCEDURE insertTable @idTest INT
AS
BEGIN
	DECLARE @numeTest NVARCHAR(50) =
			(SELECT t.Name FROM Tests t WHERE t.TestID = @idTest);
	DECLARE @numeTabel NVARCHAR(50);
	DECLARE @NoOfRows INT;
	DECLARE @procedura VARCHAR(50);

	DECLARE cursorTabele CURSOR FORWARD_ONLY FOR
	SELECT ta.Name, te.NoOfRows 
	FROM TestTables te INNER JOIN Tables ta ON te.TableID = ta.TableID
	WHERE te.TestID = @idTest
	ORDER BY te.Position;

	OPEN cursorTabele;

	FETCH NEXT FROM cursorTabele INTO @numeTabel, @NoOfRows;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @procedura = 'insert' + @numeTabel;
		EXEC @procedura @NoOfRows;
		FETCH NEXT FROM cursorTabele INTO @numeTabel, @NoOfRows;
	END

	CLOSE cursorTabele;
	DEALLOCATE cursorTabele;
END
GO





CREATE PROCEDURE deleteAutoriT
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM AutoriT;

	PRINT 'S-au sters ' + CONVERT(VARCHAR(10), @@ROWCOUNT) + ' autori';
END
GO
EXEC deleteAutoriT;
GO
SELECT * FROM AutoriT


GO

CREATE OR ALTER PROCEDURE deleteCartiT
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM CartiT;

	PRINT 'S-au sters ' + CONVERT(VARCHAR(10), @@ROWCOUNT) + ' carti';
END
GO
EXEC deleteCartiT;
GO

CREATE OR ALTER PROCEDURE deleteCarti_autoriT
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE FROM Carti_autoriT;
	DELETE FROM AutoriT
	WHERE nume_aut = 'Valeriu';

	PRINT 'S-au sters ' + CONVERT(VARCHAR(10), @@ROWCOUNT) + ' carti_autor';
END
GO
EXEC deleteCarti_autoriT;
GO


CREATE PROCEDURE deleteTable @idTest INT
AS
BEGIN
	DECLARE @numeTest NVARCHAR(50) =
			(SELECT t.Name FROM Tests t WHERE t.TestID = @idTest);
	DECLARE @numeTabel NVARCHAR(50);
	DECLARE @procedura VARCHAR(50);

	DECLARE cursorTabele CURSOR FORWARD_ONLY FOR
	SELECT ta.Name 
	FROM TestTables te INNER JOIN Tables ta ON te.TableID = ta.TableID
	WHERE te.TestID = @idTest
	ORDER BY te.Position DESC;

	OPEN cursorTabele;

	FETCH NEXT FROM cursorTabele INTO @numeTabel;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @procedura = 'delete' + @numeTabel;
		EXEC @procedura;
		FETCH NEXT FROM cursorTabele INTO @numeTabel;
	END

	CLOSE cursorTabele;
	DEALLOCATE cursorTabele;
END
GO



CREATE PROCEDURE selectView @idTest INT
AS
BEGIN
	DECLARE @viewName NVARCHAR(50) =
			(SELECT v.Name FROM Views v INNER JOIN TestViews tv on tv.ViewID = v.ViewID
			 WHERE tv.TestID = @idTest);
	DECLARE @select VARCHAR(50) = 'SELECT * FROM ' + @viewName;

	EXEC (@select);
END
GO




CREATE or ALTER PROCEDURE runTest2
AS
BEGIN
	DECLARE @ds DATETIME;
	DECLARE @de DATETIME;
	DECLARE @dsAll DATETIME = NULL;
	DECLARE @idTest INT = 1;
	DECLARE @tableID INT;
	DECLARE @viewID INT;

	INSERT INTO TestRuns (Description, StartAt, EndAt)
	VALUES ('Test Database', null, null);

	DECLARE @testRunID INT =
			(SELECT MAX(tr.TestRunID) FROM TestRuns tr);

	WHILE @idTest < 4
	BEGIN
		SET @ds = GETDATE();
		IF(@dsAll is NULL)
		BEGIN
			SET @dsAll = @ds;
		END;

		EXEC deleteTable @idTest;
		EXEC insertTable @idTest;

		SET @de = GETDATE();

		SET @tableID =
			(SELECT ta.TableID FROM Tests te
			INNER JOIN TestTables tt ON tt.TestID = te.TestID
			INNER JOIN Tables ta ON ta.TableID = tt.TableID
			WHERE tt.TestID = @idTest AND
			te.Name LIKE 'DI_' + ta.Name + '_%');
	
		INSERT INTO TestRunTables (TestRunID, TableID, StartAt, EndAt)
		VALUES (@testRunID, @tableID, @ds, @de);

		SET @idTest = @idTest + 1;
	END

	UPDATE TestRuns SET StartAt = @dsAll WHERE TestRunID = @testRunID;

	SET @idTest = 1;
	WHILE @idTest < 4
	BEGIN
		SET @ds = GETDATE();

		EXEC selectView @idTest;

		SET @de = GETDATE();

		SET @viewID =
			(SELECT v.ViewID FROM Views v
			INNER JOIN TestViews tv ON tv.ViewID = v.ViewID
			WHERE tv.TestID = @idTest);
	
		INSERT INTO TestRunViews (TestRunID, ViewID, StartAt, EndAt)
		VALUES (@testRunID, @viewID, @ds, @de);

		SET @idTest = @idTest + 1;
	END

	UPDATE TestRuns SET EndAt = @de WHERE TestRunID = @testRunID;	

	PRINT 'Testul a rulat pentru ' + CONVERT(VARCHAR(10), DATEDIFF(millisecond, @de, @dsAll)) + ' milisecunde';
END
GO


----- gresit-------
GO
CREATE OR ALTER PROCEDURE runTest @idTest INT
AS
BEGIN
	DECLARE @ds DATETIME;
	DECLARE @di DATETIME;
	DECLARE @de DATETIME;

	SET @ds = GETDATE();

	EXEC deleteTable @idTest;

	EXEC insertTable @idTest;

	SET @di = GETDATE();

	EXEC selectView @idTest;

	SET @de = GETDATE();
	
	DECLARE @testName NVARCHAR(50) = 
	(SELECT t.Name FROM Tests t WHERE t.TestID = @idTest);
	INSERT INTO TestRuns (Description, StartAt, EndAt)
	VALUES (@testName, @ds, @de)
	DECLARE @viewID INT =
			(SELECT v.ViewID FROM Views v
			INNER JOIN TestViews tv ON tv.ViewID = v.ViewID
			WHERE tv.TestID = @idTest);
	DECLARE @tableID INT =
			(SELECT ta.TableID FROM Tests te
			INNER JOIN TestTables tt ON tt.TestID = te.TestID
			INNER JOIN Tables ta ON ta.TableID = tt.TableID
			WHERE tt.TestID = @idTest AND
			te.Name LIKE 'DI_' + ta.Name + '[_]%');
	DECLARE @testRunID INT =
			(SELECT MAX(tr.TestRunID) FROM TestRuns tr
			WHERE tr.Description = @testName);


	PRINT(@testRunID)
	INSERT INTO TestRunTables (TestRunID, TableID, StartAt, EndAt)
	VALUES (@testRunID, @tableID, @ds, @di);
	
	INSERT INTO TestRunViews (TestRunID, ViewID, StartAt, EndAt)
	VALUES (@testRunID, @viewID, @di, @de);

	PRINT 'Testul a rulat pentru ' + CONVERT(VARCHAR(10), DATEDIFF(millisecond, @de, @ds)) + ' milisecunde';

	--DELETE FROM TestRuns WHERE  TestRunID = (SELECT MAX(TestRunID) FROM TestRuns)

END
GO
----gresit-----
CREATE OR ALTER PROCEDURE runTestMain 
AS
BEGIN
	DECLARE @ds DATETIME;
	DECLARE @de DATETIME;
	SET @ds = GETDATE();

	INSERT INTO TestRuns (Description, StartAt, EndAt)
	VALUES ('test', @ds, null);

	EXEC runTest 1;
	EXEC runTest 2;
	EXEC runTest 3;

	--DECLARE @testid INT
	--SET @testid = (SELECT MAX(TestRunID) FROM TestRuns)

	SET @de = GETDATE();
	UPDATE TestRuns SET EndAt=@de  WHERE Description='test'
END
GO

EXEC runTest2;

DELETE FROM TestRuns
SELECT * FROM TestRuns
SELECT * FROM TestRunTables
SELECT * FROM TestRunViews
GO



























INSERT INTO AutoriT(nume_aut) VALUES
('Gail Klingman');

INSERT INTO AutoriT(nume_aut) VALUES
('Claude Karnoouh');

INSERT INTO AutoriT(nume_aut) VALUES
('Eva Behring');

INSERT INTO AutoriT(nume_aut) VALUES
('Alexandra Laignel-Lavastine');

INSERT INTO AutoriT(nume_aut) VALUES
('Tom Gallagher');

INSERT INTO CartiT(titlu, ani, id_prod) VALUES
('Un nou inceput', 2020, 1);

INSERT INTO CartiT(titlu, ani, id_prod) VALUES
('Jurnalul Annei Frank', 1947, 2);

INSERT INTO CartiT(titlu, ani, id_prod) VALUES
('Povestea mea', 2001, 7);

INSERT INTO CartiT(titlu, ani, id_prod) VALUES
('Fata din tren', 2015, 8);

INSERT INTO CartiT(titlu, ani, id_prod) VALUES
('Dublura', 2013, 11);

INSERT INTO CartiT(titlu, ani, id_prod) VALUES
('Cartea Dede', 2004, 12);

INSERT INTO Carti_autoriT(id_carte,id_aut) VALUES
(3,1);

INSERT INTO Carti_autoriT(id_carte,id_aut) VALUES
(4,2);


INSERT INTO Carti_autoriT(id_carte,id_aut) VALUES
(1,3);

INSERT INTO Carti_autoriT(id_carte,id_aut) VALUES
(2,4);

INSERT INTO Carti_autoriT(id_carte,id_aut) VALUES
(5,4);

INSERT INTO Carti_autoriT(id_carte,id_aut) VALUES
(6,5);


SELECT * FROM CartiT
SELECT * FROM AutoriT
SELECT * FROM Carti_autoriT