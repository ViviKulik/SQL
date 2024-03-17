USE Anticariat
GO


--validare an publicatie
CREATE OR ALTER FUNCTION dbo.TestAn(@an INT)
RETURNS BIT
BEGIN
	DECLARE @ret BIT = 0;
	if @an > 1900 and @an < YEAR(GETDATE()) SET @ret = 1;
	RETURN @ret;
END;
GO

--validare string
CREATE OR ALTER FUNCTION dbo.TestString(@str VARCHAR(50))
RETURNS BIT
BEGIN
	DECLARE @ret BIT=0;
	IF LEN(@str) > 0 SET @ret = 1;
	RETURN @ret;
END;
GO

--validare idcarte
CREATE OR ALTER FUNCTION dbo.TestCarteId(@id INT)
RETURNS BIT
BEGIN
	DECLARE @ret BIT = 0;
	IF EXISTS(SELECT id_carte FROM Carti WHERE id_carte=@id) SET @ret =1;
	RETURN @ret;
END;
GO

--validare idautor
CREATE OR ALTER FUNCTION dbo.TestAutoriId(@id INT)
RETURNS BIT
BEGIN
	DECLARE @ret BIT = 0;
	IF EXISTS(SELECT id_aut FROM Autori WHERE id_aut=@id) SET @ret = 1;
	RETURN @ret;
END;
GO

--validare idprodus
CREATE OR ALTER FUNCTION dbo.TestProdId(@id INT)
RETURNS BIT
BEGIN 
	DECLARE @ret BIT = 0;
	IF EXISTS(SELECT id_produs FROM Produse WHERE id_produs=@id) SET @ret=1;
	RETURN @ret;
END;
GO


--proceduri carti
CREATE OR ALTER PROCEDURE CreateCartiCRUD
	@titlu VARCHAR(50),
	@an_publicatie INT,
	@id_prod INT
AS
BEGIN
	IF(dbo.TestProdId(@id_prod) = 1 AND dbo.TestAn(@an_publicatie) = 1 AND dbo.TestString(@titlu) = 1)
	BEGIN
		INSERT INTO Carti(titlu, an_publicatie, id_prod)
		VALUES (@titlu, @an_publicatie, @id_prod);
		PRINT 'Cartea INSERATA cu succes'
	END
	ELSE
	BEGIN
		PRINT 'Eroare la INSERAREA unei carti'
		RETURN;
	END;
END;
GO

CREATE OR ALTER PROCEDURE ReadCartiCRUD
AS
BEGIN 
	SELECT * FROM Carti;
END;
GO

CREATE OR ALTER PROCEDURE UpdateCartiCRUD
	@titlu VARCHAR(50),
	@an_nou INT
AS 
BEGIN
	IF(dbo.TestString(@titlu)=1 AND dbo.TestAn(@an_nou) = 1)
	BEGIN
		UPDATE Carti SET an_publicatie=@an_nou
		WHERE titlu=@titlu;

		PRINT 'Cartea MODIFICATA cu succes';
	END;
	ELSE
	BEGIN
		PRINT 'Eroare la MODIFICAREA cartii';
		RETURN;
	END;
END;
GO

CREATE OR ALTER PROCEDURE DeleteCartiCRUD
	@titlu VARCHAR(50)
AS
BEGIN
	IF(dbo.TestString(@titlu) = 1)
	BEGIN
		DELETE FROM Carti
		WHERE titlu=@titlu;
		PRINT 'Cartea a fost STEARSA cu succes'
	END
	ELSE
	BEGIN
		PRINt 'Eroare la STERGEREA unei carti'
		RETURN;
	END;
END;
GO

exec ReadCartiCRUD
exec CreateCartiCRUD 'Joc secund', 1967, 15;
exec DeleteCartiCRUD 'Joc secund';
exec UpdateCartiCRUD 'Cartea Dede', 2023;

GO

--proceduri autori
CREATE OR ALTER PROCEDURE CreateAutoriCRUD
	@nume VARCHAR(50)
AS
BEGIN
	IF (dbo.TestString(@nume) = 1)
	BEGIN
		INSERT INTO Autori(nume_aut)
		VALUES (@nume)
		PRINT 'Autorul a fost CREAT'
	END
	ELSE
	BEGIN
		PRINT 'Eroare la CREAREA'
		RETURN;
	END;
END;
GO

CREATE OR ALTER PROCEDURE ReadAutoriCRUD
AS 
BEGIN
	SELECT * FROM Autori;
END;
GO

CREATE OR ALTER PROCEDURE UpdateAutoriCRUD
	@nume VARCHAR(50),
	@nume_nou VARCHAR(50)
AS
BEGIN
	IF(dbo.TestString(@nume) = 1 AND dbo.TestString(@nume_nou) = 1)
	BEGIN
		UPDATE Autori SET nume_aut = @nume_nou
		WHERE nume_aut=@nume;
		PRINT 'Autor  MODIFICAT cu succes'
	END
	ELSE
	BEGIN
		PRINT 'Eroare la MODIFICARE la autor'
		RETURN;
	END;
END;
GO

CREATE OR ALTER PROCEDURE DelteAutoriCRUD
	@nume VARCHAR(50)
AS
BEGIN
	IF(dbo.TestString(@nume) = 1)
	BEGIN
		DELETE FROM Autori
		WHERE nume_aut=@nume;
		PRINT 'Autor STERS cu succes'
	END
	ELSE
	BEGIN
		PRINT 'Eroare la STERGEREA unui autor'
		RETURN;
	END;
END;
GO

exec ReadAutoriCRUD
exec CreateAutoriCRUD 'Bobby'
exec DelteAutoriCRUD 'Bobby'
exec UpdateAutoriCRUD  'Bob Marley','Bob M.';
exec UpdateAutoriCRUD  'Bob M.','Bob Marley'
GO

--Proceduri cartiautori

CREATE OR ALTER PROCEDURE CreateCartiAutoriCRUD
	@id_carte INT,
	@id_aut INT
AS
BEGIN
	IF(dbo.TestCarteId(@id_carte) = 1 AND dbo.TestAutoriId(@id_aut) =1)
	BEGIN
		INSERT INTO Carti_autori(id_carte, id_aut)
		VALUES (@id_carte, @id_aut);
		PRINT 'CarteAutor INSERAT cu succes'
	END
	ELSE
	BEGIN
		PRINT 'Eroare la INSERARE carteautor'
		RETURN;
	END;
END;
GO

CREATE OR ALTER PROCEDURE ReadCartiAutoriCRUD
AS
BEGIN
	SELECT * FROM Carti_autori;
END;
GO

CREATE OR ALTER PROCEDURE DeleteCartiAutoriCRUD
	@id_carte INT,
	@id_aut INT
AS
BEGIN
	IF(dbo.TestCarteId(@id_carte) = 1 AND dbo.TestAutoriId(@id_aut) =1)
	BEGIN
		DELETE FROM Carti_autori
		WHERE id_carte = @id_carte;
		PRINT 'CarteAutor STERS cu succes'
	END
	ELSE
	BEGIN
		PRINT 'Eroare la STERGEREA unei cartiautori'
		RETURN;
	END;
END;
GO

CREATE OR ALTER PROCEDURE UpdateCartiAutoriCRUD
	@id_carte INT,
	@id_autor INT,
	@id_nou INT
AS
BEGIN
	IF(dbo.TestCarteId(@id_carte) = 1 AND dbo.TestAutoriId(@id_autor) = 1)
	BEGIN
		UPDATE Carti_autori SET id_aut= @id_nou
		WHERE id_carte=@id_carte AND id_aut=@id_autor;
		PRINT 'CartiAutori MODIFICAT cu succes';
	END
	ELSE
	BEGIN
		PRINT 'Eroare la MODIFICAREA unei cartiautori'
		RETURN;
	END;
END;
GO

exec ReadCartiAutoriCRUD
exec ReadCartiCRUD
exec CreateCartiAutoriCRUD 10, 2
exec UpdateCartiAutoriCRUD 14, 1, 2
exec DeleteCartiAutoriCRUD 14, 2;
GO


-- views

CREATE OR ALTER VIEW CartiView
AS
	SELECT an_publicatie, COUNT(*) an_publicstie FROM Carti
	GROUP BY an_publicatie
GO

SELECT * FROM CartiView
GO


IF EXISTS (SELECT NAME FROM sys.indexes	WHERE name = 'N_idx_carti_an')
DROP INDEX N_idx_carti_an ON Carti
CREATE NONCLUSTERED INDEX N_idx_carti_an ON Carti(an_publicatie);

GO

CREATE OR ALTER VIEW CartiAutoriView
AS
	SELECT A.nume_aut, C.titlu
	FROM Autori A
	INNER JOIN Carti_autori CA ON
	A.id_aut=CA.id_aut
	INNER JOIN Carti C ON
	C.id_carte=CA.id_carte
GO

SELECT * FROM CartiAutoriView


IF EXISTS (SELECT NAME FROM sys.indexes	WHERE name = 'N_idx_autori')
DROP INDEX N_idx_autori ON Autori
CREATE NONCLUSTERED INDEX N_idx_autori ON Autori(nume_aut);

