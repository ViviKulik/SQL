CREATE DATABASE Anticariat;
GO
USE Anticariat;

CREATE TABLE Clienti
(id_client INT PRIMARY KEY,
nume VARCHAR(50) NOT NULL,
adresa_c VARCHAR(50)
--numar telefon
);

CREATE TABLE Produse
(id_produs INT PRIMARY KEY,
pret FLOAT NOT NULL,
);

CREATE TABLE Vanzator
(id_van INT PRIMARY KEY,
nume_van VARCHAR(50) NOT NULL,
adresa VARCHAR(50),
nume_firma VARCHAR(50)
--numar telefon
);

ALTER TABLE Vanzator
ADD numar_tel VARCHAR(10);