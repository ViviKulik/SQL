USE Anticariat

CREATE TABLE Tablouri
(id_tablou INT PRIMARY KEY IDENTITY(1,1),
tip_tablou VARCHAR(50) NOT NULL,
lungime INT,
latime INT
);

CREATE TABLE Pictori
(id_pic INT PRIMARY KEY IDENTITY,
nume_pic VARCHAR(50) NOT NULL
);

CREATE TABLE Portelan
(id_por INT PRIMARY KEY IDENTITY,
greutate INT,
descriere VARCHAR(50) NOT NULL
);

CREATE TABLE Carti
(id_carte INT PRIMARY KEY IDENTITY(1,1),
titlu VARCHAR(50) NOT NULL,
ani INT
);

CREATE TABLE Autori
(id_aut INT PRIMARY KEY IDENTITY,
nume_aut VARCHAR(50)
);

CREATE TABLE Genuri
(id_gen INT PRIMARY KEY IDENTITY,
nume_gen VARCHAR(50) NOT NULL
);

CREATE TABLE Carti_genuri
(id_carte INT FOREIGN KEY REFERENCES Carti(id_carte),
id_gen INT FOREIGN KEY REFERENCES Genuri(id_gen),
carte_gen CHAR(2),
CONSTRAINT pk_Carti_genuri PRIMARY KEY(id_carte, id_gen)
);


SELECT *
FROM Clienti

SELECT *
FROM Genuri

SELECT *
FROM Autori

SELECT *
FROM Produse

SELECT *
FROM Carti

SELECT *
FROM Portelan

SELECT *
FROM Tablouri

SELECT *
FROM Pictori