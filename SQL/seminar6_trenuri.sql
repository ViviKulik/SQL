CREATE DATABASE Trenuri
GO
 
USE Trenuri
GO
 
CREATE TABLE Tipuri
  ( id_tip int PRIMARY KEY IDENTITY,
  descriere varchar(100)
  );
 
CREATE TABLE Trenuri
  ( id_tren int PRIMARY KEY IDENTITY,
  id_tip int FOREIGN KEY REFERENCES Tipuri(id_tip),
  nume varchar(100)
  );
 
CREATE TABLE Rute
  ( id_ruta int PRIMARY KEY IDENTITY,
  nume varchar(100),
  id_tren int FOREIGN KEY REFERENCES Trenuri(id_tren),
  );
 
CREATE TABLE Statii
  ( id_statie int PRIMARY KEY IDENTITY,
  nume varchar(100),
  );
 
CREATE TABLE Trasee
  ( id_ruta int FOREIGN KEY REFERENCES Rute(id_ruta)
  ON UPDATE CASCADE  ON DELETE CASCADE,
  id_statie int FOREIGN KEY REFERENCES Statii(id_statie)
  ON UPDATE CASCADE  ON DELETE CASCADE,
  ora_sosire TIME,
  ora_plecare TIME,
  CONSTRAINT pk_trasee PRIMARY KEY (id_ruta, id_statie)
  );

INSERT INTO Tipuri(descriere) VALUES ('calatori'), ('marfa'), ('de mare viteza');

INSERT INTO Trenuri(id_tip, nume) VALUES (1, 'Locomotiva Thomas'), (1, 'Trenul Foamei'), (2, 'CFR 1'), (3,'TGV'), (2,'CFR 2');


INSERT INTO Rute(id_tren, nume) VALUES (1, 'Ruta vesela'), (2,'Iasi-Timisoara'), (3, 'Cluj-Oradea'), (4, 'Cluj-Suceava'), (5, 'Cluj-Constanta'), (1, 'Cluj-Budapesta');

INSERT INTO Statii(nume) VALUES ('Saratel'), ('Bistrita Nord'), ('Cluj Vest'), ('Veresti'), ('Mangalia'), ('Budapesta Nord'), ('Timisoara Vest'), ('Suceava Nord');
INSERT INTO Statii(nume) VALUES ('Oradea Sud')
SELECT * FROM Statii

INSERT INTO Trasee(id_ruta, id_statie, ora_plecare, ora_sosire) VALUES (1,1,'6:00','6:05'), (2,4,'5:15','5:30'), (3,9,'7:00','8:00'),
(4,7,'10:00','10:30'), (4,3,'6:00','6:05'), (5,5,'10:10','10:25'),(6,3,'17:00','17:10'),(6,6,'20:20','20:45')
SELECT * FROM Trasee

GO

CREATE OR ALTER PROCEDURE adauga_statie @id_ruta int, @id_statie int, @ora_sosire time, @ora_plecare time
AS
BEGIN
	If (EXISTS(SELECT 1 FROM Trasee WHERE id_ruta = @id_ruta AND id_statie=@id_statie))
	BEGIN
		UPDATE Trasee
		SET ora_plecare = @ora_plecare, ora_sosire=@ora_sosire
		WHERE id_statie=@id_statie AND id_ruta=@id_ruta;
	END
	ELSE
	BEGIN
		INSERT INTO Trasee(id_ruta, id_statie, ora_sosire, ora_plecare)
		VALUES (@id_ruta, @id_statie, @ora_sosire, @ora_plecare);
	END
END
GO

SELECT * FROM Trasee
EXEC adauga_statie 1, 4, '4:00', '4:30'
EXEC adauga_statie 1, 4, '3:00', '3:05'

exec adauga_statie 1, 2, '1:00','1:05'
exec adauga_statie 1, 3, '1:05','1:15'
exec adauga_statie 1, 5, '1:25','1:40'
exec adauga_statie 1, 6, '3:45','4:00'
exec adauga_statie 1, 7, '5:25','5:30'
exec adauga_statie 1, 8, '6:00','6:15'
exec adauga_statie 1, 9, '12:00','12:20'

GO
CREATE OR ALTER VIEW viewRute
AS
  SELECT r.nume FROM Rute r
  INNER JOIN Trasee t ON t.id_ruta = r.id_ruta
  GROUP BY r.id_ruta, r.nume
  HAVING COUNT(*) = (SELECT COUNT(*) FROM Statii);  
  
SELECT * FROM viewRute