CREATE DATABASE ParcDeDistractii;
GO
USE ParcDeDistractii;
--crearea tabelelor
CREATE TABLE Sectiuni
(cod_s INT PRIMARY KEY IDENTITY(1,1),--IDENTITY genereaza automat o valoare pentru cod_s
nume VARCHAR(100),
descriere VARCHAR(300)
);
CREATE TABLE Atractii
(cod_a INT PRIMARY KEY IDENTITY,
nume VARCHAR(100),
descriere VARCHAR(300),
varsta_min INT,
cod_s INT FOREIGN KEY REFERENCES Sectiuni(cod_s)
);
CREATE TABLE Categorii
(cod_c INT PRIMARY KEY IDENTITY,
nume VARCHAR(70)
);
CREATE TABLE Vizitatori
(cod_v INT PRIMARY KEY IDENTITY,
nume VARCHAR(100),
email VARCHAR(100),
cod_c INT FOREIGN KEY REFERENCES Categorii(cod_c)
);
CREATE TABLE Note
(cod_a INT FOREIGN KEY REFERENCES Atractii(cod_a),
cod_v INT FOREIGN KEY REFERENCES Vizitatori(cod_v),
nota REAL,
CONSTRAINT pk_Note PRIMARY KEY (cod_a, cod_v)
);
ALTER TABLE Note
ADD CONSTRAINT check_nota CHECK (nota > 0 AND nota<11);