USE Anticariat

CREATE TABLE Versiuni
(
	cod_v INT PRIMARY KEY IDENTITY,
	versiune_curenta INT
);
INSERT INTO Versiuni(versiune_curenta) VALUES(0)




ALTER PROCEDURE ModificaTip
AS 
BEGIN
ALTER TABLE Clienti 
ALTER COLUMN numar_tel CHAR(10);
END;


ALTER PROCEDURE ModificaTipInapoi
AS 
BEGIN
ALTER TABLE Clienti 
ALTER COLUMN numar_tel VARCHAR(10);
END;

EXEC ModificaTip
EXEC ModificaTipInapoi



ALTER PROCEDURE AdaugaConstrangere
AS
BEGIN
ALTER TABLE Clienti
ADD CONSTRAINT df_adresa_c DEFAULT 'Adresa:necunoscuta' for adresa_c;
END

GO
EXEC AdaugaConstrangere;

GO

ALTER PROCEDURE StergeConstrangere
AS
BEGIN
ALTER TABLE Clienti
DROP CONSTRAINT df_adresa_c;
END

GO
EXEC StergeConstrangere

GO

ALTER PROCEDURE CreareTabel
AS
BEGIN
CREATE TABLE Jucarii
(id_juc INT PRIMARY KEY,
material VARCHAR(20),
tip VARCHAR(20),
categorie_varsta VARCHAR(20)
)
END;

GO
EXEC CreareTabel


ALTER PROCEDURE StergeTabel
AS
BEGIN
DROP TABLE Jucarii;
END

GO
EXEC StergeTabel


ALTER PROCEDURE AdaugaCamp
AS 
BEGIN
ALTER TABLE Autori
ADD perioada VARCHAR(20);
END

GO
EXEC AdaugaCamp

ALTER PROCEDURE StergeCamp
AS
BEGIN 
ALTER TABLE Autori
DROP COLUMN perioada;
END

GO 
EXEC StergeCamp


ALTER PROCEDURE AdaugaFK
AS
BEGIN
ALTER TABLE Portelan
ADD CONSTRAINT fk_id_por_id_client FOREIGN KEY (id_por) REFERENCES Clienti(id_client)
END

GO
EXEC AdaugaFK

ALTER PROCEDURE StergeFK
AS
BEGIN
ALTER TABLE Portelan
DROP CONSTRAINT fk_id_por_id_client
END

GO
EXEC StergeFK


CREATE PROCEDURE ExecutaVersiuneCresc @versiune INT
AS
BEGIN
	IF @versiune=0
		EXEC ModificaTip
	IF @versiune=1
		EXEC AdaugaConstrangere
	IF @versiune=2
		EXEC CreareTabel
	IF @versiune=3
		EXEC AdaugaCamp
	IF @versiune=4
		EXEC AdaugaFK
END


CREATE PROCEDURE ExecutaVersiuneDescresc @versiune INT
AS
BEGIN
	IF @versiune=1
		EXEC ModificaTipInapoi
	IF @versiune=2
		EXEC StergeConstrangere
	IF @versiune=3
		EXEC StergeTabel
	IF @versiune=4
		EXEC StergeCamp
	IF @versiune=5
		EXEC StergeFK
END



CREATE OR ALTER PROCEDURE SchimbaVersiunea @versiune_dorita INT
AS
BEGIN
DECLARE @versiune_curenta INT;
SELECT @versiune_curenta = versiune_curenta FROM Versiuni;
IF @versiune_dorita<0 OR @versiune_dorita>5
BEGIN
	PRINT 'Versiunea nu este valida!'
	RETURN;
END
IF @versiune_curenta < @versiune_dorita
BEGIN
	WHILE @versiune_curenta < @versiune_dorita
	BEGIN
		EXEC ExecutaVersiuneCresc @versiune_curenta
		SET @versiune_curenta = @versiune_curenta + 1;
	END;	
END
ELSE WHILE @versiune_curenta > @versiune_dorita
	BEGIN
		EXEC ExecutaVersiuneDescresc @versiune_curenta
		SET @versiune_curenta = @versiune_curenta - 1;
	END;
UPDATE Versiuni SET versiune_curenta = @versiune_curenta;
END;


EXEC SchimbaVersiunea 7;
SELECT * FROM Versiuni


SELECT * FROM INFORMATION_SCHEMA.COLUMNS;
