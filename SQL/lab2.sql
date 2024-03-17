USE Anticariat

INSERT INTO Clienti(id_client,nume,adresa_c, numar_tel) VALUES
(1,'Pop Alex', 'Str. Ravasaului nr.4', '0734567890');

INSERT INTO Clienti(id_client,nume,adresa_c, numar_tel) VALUES
(2,'Ungureanu Andrei', 'Str. Bucuresti nr.9', '073451234');

INSERT INTO Clienti(id_client,nume,adresa_c, numar_tel) VALUES
(3,'Goj Matei', 'Str. Tisa nr.2', '0733445560');

INSERT INTO Clienti(id_client,nume,adresa_c, numar_tel) VALUES
(4,'Rad Noris', 'Str. Tisa nr.2', '0712121098');

INSERT INTO Clienti(id_client,nume,adresa_c, numar_tel) VALUES
(5,'Rus Andrei', 'Str. Astronautilor nr. 4', '0778911560');

INSERT INTO Clienti(id_client,nume,adresa_c, numar_tel) VALUES
(6,'Pop Andreea', 'Str. Florilor nr.97', '0733657483');

INSERT INTO Clienti(id_client,nume,adresa_c, numar_tel) VALUES
(7,'Lorincz Denisa', 'Str. Eroilor nr.13', '0726680225');

INSERT INTO Clienti(id_client,nume,adresa_c, numar_tel) VALUES
(8,'Dumitru Damaris', 'Str. Golesti nr.42', '0787889231');





INSERT INTO Vanzator(id_van, nume_van, adresa, nume_firma, numar_tel) VALUES
(1, 'Grigore Paul', 'Str. Bistritei nr.12', 'Trored', '0745321978');

INSERT INTO Vanzator(id_van, nume_van, adresa, nume_firma, numar_tel) VALUES
(2, 'Troic Paul', 'Str. Crainic nr.13', 'Aurora', '0745440998');

INSERT INTO Vanzator(id_van, nume_van, adresa, nume_firma, numar_tel) VALUES
(3, 'Fodor Cristian', 'Str. Harghitei nr.47', 'Cylex', '0745909576');




INSERT INTO Pictori(nume_pic) VALUES
('James Ensor');

INSERT INTO Pictori(nume_pic) VALUES
('Carl Eytel');

INSERT INTO Pictori(nume_pic) VALUES
('Jan van Eyck');

INSERT INTO Pictori(nume_pic) VALUES
('Richard Estes');

INSERT INTO Pictori(nume_pic) VALUES
('Corneliu Baba');


DELETE FROM Pictori WHERE id_pic>=12;




INSERT INTO Genuri(nume_gen) VALUES
('Biografie');

INSERT INTO Genuri(nume_gen) VALUES
('Istorie');

INSERT INTO Genuri(nume_gen) VALUES
('Romantic');

INSERT INTO Genuri(nume_gen) VALUES
('Thriller');

INSERT INTO Genuri(nume_gen) VALUES
('Actiune');

INSERT INTO Genuri(nume_gen) VALUES
('Drama adolescentina');

DELETE FROM Genuri WHERE id_gen>=19;




INSERT INTO Autori(nume_aut) VALUES
('Gail Klingman');

INSERT INTO Autori(nume_aut) VALUES
('Claude Karnoouh');

INSERT INTO Autori(nume_aut) VALUES
('Eva Behring');

INSERT INTO Autori(nume_aut) VALUES
('Alexandra Laignel-Lavastine');

INSERT INTO Autori(nume_aut) VALUES
('Tom Gallagher');

DELETE FROM Autori WHERE id_aut>=6;



DELETE FROM Produse WHERE id_produs = 1;

INSERT INTO Produse(id_produs, pret, id_client, id_van) VALUES
(1,19, 1, 2);

INSERT INTO Produse(id_produs, pret, id_van) VALUES
(2,19, 1);




INSERT INTO Carti(titlu, an_publicatie, id_prod) VALUES
('Un nou inceput', 2020, 1);

INSERT INTO Carti(titlu, an_publicatie, id_prod) VALUES
('Jurnalul Annei Frank', 1947, 2);

INSERT INTO Carti(titlu, an_publicatie, id_prod) VALUES
('Povestea mea', 2001, 7);

INSERT INTO Carti(titlu, an_publicatie, id_prod) VALUES
('Fata din tren', 2015, 8);

INSERT INTO Carti(titlu, an_publicatie, id_prod) VALUES
('Dublura', 2013, 11);

INSERT INTO Carti(titlu, an_publicatie, id_prod) VALUES
('Cartea Dede', 2004, 12);

DELETE FROM Carti WHERE id_carte>=5;




INSERT INTO Carti_autori(id_carte,id_aut) VALUES
(3,1);

INSERT INTO Carti_autori(id_carte,id_aut) VALUES
(4,2);


INSERT INTO Carti_autori(id_carte,id_aut) VALUES
(7,3);

INSERT INTO Carti_autori(id_carte,id_aut) VALUES
(8,4);

INSERT INTO Carti_autori(id_carte,id_aut) VALUES
(9,4);

INSERT INTO Carti_autori(id_carte,id_aut) VALUES
(10,5);
***********************************************************

INSERT INTO Carti_genuri(id_carte, id_gen) VALUES
(3, 15)

INSERT INTO Carti_genuri(id_carte, id_gen) VALUES
(3, 18)

INSERT INTO Carti_genuri(id_carte, id_gen) VALUES
(4, 14)

INSERT INTO Carti_genuri(id_carte, id_gen) VALUES
(4, 13)

INSERT INTO Carti_genuri(id_carte, id_gen) VALUES
(7, 18)

INSERT INTO Carti_genuri(id_carte, id_gen) VALUES
(7, 13)

INSERT INTO Carti_genuri(id_carte, id_gen) VALUES
(8, 16)

INSERT INTO Carti_genuri(id_carte, id_gen) VALUES
(8, 17)

INSERT INTO Carti_genuri(id_carte, id_gen) VALUES
(9, 16)

INSERT INTO Carti_genuri(id_carte, id_gen) VALUES
(9, 14)

INSERT INTO Carti_genuri(id_carte, id_gen) VALUES
(10, 16)

INSERT INTO Carti_genuri(id_carte, id_gen) VALUES
(10, 15)


INSERT INTO Produse(id_produs, pret, id_client, id_van) VALUES
(3,30, 1, 2);

INSERT INTO Produse(id_produs, pret, id_van) VALUES
(4,50, 1);



INSERT INTO Portelan(greutate, descriere, id_prod) VALUES
(1, 'Peste multicolor', 3);

INSERT INTO Portelan(greutate, descriere, id_prod) VALUES
(2, 'Invitatie la dans', 4);

INSERT INTO Portelan(greutate, descriere, id_prod) VALUES
(3, 'Porumbei', 15);

INSERT INTO Portelan(greutate, descriere, id_prod) VALUES
(2, 'Ingeras', 14);

DELETE FROM Portelan WHERE id_por>=4;




INSERT INTO Produse(id_produs, pret, id_client, id_van) VALUES
(5,25, 2, 3);

INSERT INTO Produse(id_produs, pret, id_van) VALUES
(6,49, 3);

INSERT INTO Tablouri(tip_tablou, lungime, latime, id_pic, id_prod) VALUES
('Portret', 60, 40, 7, 5);

INSERT INTO Tablouri(tip_tablou, lungime, latime, id_pic, id_prod) VALUES
('Peisaj', 100, 60, 8, 6);

INSERT INTO Tablouri(tip_tablou, lungime, latime, id_pic, id_prod) VALUES
('Portret', 70, 50, 10, 7);

INSERT INTO Tablouri(tip_tablou, lungime, latime, id_pic, id_prod) VALUES
('Portret', 30, 30, 9, 8);

INSERT INTO Tablouri(nume_tablou, lungime, latime, id_pic, id_prod) VALUES
('Seara pe-nserate', 120, 85, 9, 13);

DELETE FROM Tablouri WHERE id_tablou>=3;


INSERT INTO Produse(id_produs, pret, id_van) VALUES
(7,40, 1);
INSERT INTO Produse(id_produs, pret, id_van) VALUES
(8,35, 1);
INSERT INTO Produse(id_produs, pret, id_van) VALUES
(9,27, 1);
INSERT INTO Produse(id_produs, pret, id_van) VALUES
(10,31, 1);
INSERT INTO Produse(id_produs, pret, id_van) VALUES
(11,9, 1);
INSERT INTO Produse(id_produs, pret, id_van) VALUES
(12,10, 1);
INSERT INTO Produse(id_produs, pret, id_van) VALUES
(13,12, 1);
INSERT INTO Produse(id_produs, pret, id_van) VALUES
(14,17, 1);
INSERT INTO Produse(id_produs, pret, id_client, id_van) VALUES
(15,25, 3, 3);



UPDATE Carti SET id_prod=10
WHERE id_prod=8;

USE Anticariat

SELECT Po.descriere, Pr.pret, V.nume_van
FROM Portelan Po 
INNER JOIN Produse Pr ON
Po.id_prod=Pr.id_produs
INNER JOIN Vanzator V ON
Pr.id_van=V.id_van
WHERE V.nume_van='Grigore Paul'



SELECT COUNT(*) nr_carti, A.nume_aut
FROM Carti C
INNER JOIN Carti_autori Ca ON
C.id_carte=Ca.id_carte
INNER JOIN Autori A ON
Ca.id_aut=A.id_aut
WHERE A.nume_aut='Alexandra Laignel-Lavastine'
GROUP BY A.id_aut, A.nume_aut;


SELECT COUNT(*) nr_tablouri, P.nume_pic
FROM Tablouri T
INNER JOIN Pictori P ON
T.id_pic=P.id_pic
INNER JOIN Produse Pr ON
T.id_prod=Pr.id_produs
GROUP BY P.id_pic,  P.nume_pic
HAVING COUNT(*)<2

SELECT  G.nume_gen, COUNT(*) nr_carti_de_gen
FROM Carti C
INNER JOIN Carti_genuri Cg ON
C.id_carte=Cg.id_carte
INNER JOIN Genuri G ON
G.id_gen=Cg.id_gen
WHERE C.an_publicatie>2000 AND (nume_gen='Drama Adolescentina' OR nume_gen='Romantic')
GROUP BY G.nume_gen HAVING COUNT(*)>1


/*toate tablourile pictate de Jan van Eyck*/
SELECT T.nume_tablou, P.nume_pic
FROM Tablouri T
INNER JOIN Pictori P ON
P.id_pic=T.id_pic
INNER JOIN Produse Pr ON
T.id_prod=Pr.id_produs
WHERE P.nume_pic='Jan van Eyck'


/* toti clienti care si au cumparat carti*/
SELECT DISTINCT C.nume 
FROM Clienti C
INNER JOIN Produse P ON
C.id_client=P.id_client
INNER JOIN Carti Ca ON 
Ca.id_prod=P.id_produs;

SELECT COUNT(*), C.titlu
FROM Produse P
INNER JOIN Carti C ON
C.id_prod=P.id_produs
WHERE id_client IS NOT NULL
GROUP BY C.titlu

/*autorii care au scris carti istorice sau biografice*/
SELECT A.nume_aut, G.nume_gen
FROM Genuri G
INNER JOIN  Carti_genuri CG ON
G.id_gen=CG.id_gen
INNER JOIN Carti C ON
C.id_carte=CG.id_carte
INNER JOIN Carti_autori CA ON
C.id_carte=CA.id_carte
INNER JOIN Autori A ON
A.id_aut=CA.id_aut
WHERE G.nume_gen='Biografie' OR G.nume_gen='Istorie'



/*Datele clientilor*/
SELECT DISTINCT C.nume, C.adresa_c, C.numar_tel
FROM Clienti C
INNER JOIN Produse P ON
P.id_client=C.id_client


/*fiecare client cat a cheltuit la anticariat*/
SELECT C.nume, SUM(P.pret) AS 'Cumparaturi in valoare de:'
FROM Produse P
INNER JOIN Clienti C ON
C.id_client=P.id_client
GROUP BY C.nume HAVING SUM(P.pret)>50


/*
SELECT DISTINCT C.nume, V.nume_van
FROM Clienti C
INNER JOIN Produse P ON
C.id_client=P.id_client
INNER JOIN Vanzator V ON
V.id_van=P.id_van
*/

SELECT *
FROM Clienti

SELECT *
FROM Pictori

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
FROM Carti_Autori