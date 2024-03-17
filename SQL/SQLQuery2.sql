USE Anticariat


ALTER TABLE Clienti
ADD CONSTRAINT fk_id_client FOREIGN KEY (id_client) REFERENCES Anticariat_Antique(id_anticariat)

ALTER TABLE Clienti
DROP CONSTRAINT fk_id_anticariat

ALTER TABLE Produse
ADD id_client INT;

ALTER TABLE Produse
ADD CONSTRAINT fk_id_produs FOREIGN KEY (id_client) REFERENCES Clienti(id_client)

ALTER TABLE Produse
DROP CONSTRAINT fk_id_produs

ALTER TABLE Produse
ADD CONSTRAINT fk_id_produs FOREIGN KEY (id_produs) REFERENCES Clienti(id_client)

ALTER TABLE Carti
ADD id_autor INT;
ALTER TABLE Carti
ADD CONSTRAINT fk_id_carte FOREIGN KEY (id_autor) REFERENCES Autori(id_aut)


ALTER TABLE Carti
DROP CONSTRAINT fk_id_carte

CREATE TABLE Carti_autori
(id_carte INT FOREIGN KEY REFERENCES Carti(id_carte),
id_aut INT FOREIGN KEY REFERENCES Autori(id_aut),
CONSTRAINT pk_Carti_autori PRIMARY KEY(id_carte, id_aut)
);


ALTER TABLE CartiT
DROP COLUMN id_autor






ALTER TABLE Tablouri
ADD id_pic INT;
ALTER TABLE Tablouri
ADD CONSTRAINT fk_id_tab FOREIGN KEY (id_pic) REFERENCES Pictori(id_pic)

DROP TABLE Anticariat_Antique


ALTER TABLE Produse
ADD id_van INT;

ALTER TABLE Produse
ADD CONSTRAINT fk_id_prod FOREIGN KEY (id_van) REFERENCES Vanzator(id_van)

ALTER TABLE Produse
ADD CONSTRAINT fk_id_prod_tab FOREIGN KEY (id_produs) REFERENCES Tablouri(id_tablou)

ALTER TABLE Produse
ADD CONSTRAINT fk_id_prod_port FOREIGN KEY (id_produs) REFERENCES Portelan(id_por)

ALTER TABLE Produse
ADD CONSTRAINT fk_id_prod_car FOREIGN KEY (id_produs) REFERENCES Carti(id_carte)


ALTER TABLE Produse
DROP CONSTRAINT fk_id_prod_car;

ALTER TABLE Produse
DROP CONSTRAINT fk_id_prod_port;

ALTER TABLE Produse
DROP CONSTRAINT fk_id_prod_tab;


ALTER TABLE Tablouri
ADD CONSTRAINT fk_id_tab_prod FOREIGN KEY (id_tablou) REFERENCES Produse(id_produs)

ALTER TABLE Portelan
ADD CONSTRAINT fk_id_por_prod FOREIGN KEY (id_por) REFERENCES Produse(id_produs)

ALTER TABLE Carti
ADD CONSTRAINT fk_id_car_prod FOREIGN KEY (id_carte) REFERENCES Produse(id_produs)



ALTER TABLE Carti
DROP COLUMN ani;

ALTER TABLE Carti
ADD an_publicatie INT;


ALTER TABLE CartiT
ADD id_prod INT;

ALTER TABLE CartiT
ADD CONSTRAINT fk_id_car_prodT FOREIGN KEY (id_prod) REFERENCES Produse(id_produs)



ALTER TABLE Portelan
ADD id_prod INT;

ALTER TABLE Portelan
ADD CONSTRAINT fk_id_por_prod FOREIGN KEY (id_prod) REFERENCES Produse(id_produs)



ALTER TABLE Tablouri
ADD id_prod INT;

ALTER TABLE Tablouri
ADD CONSTRAINT fk_id_tab_prod FOREIGN KEY (id_prod) REFERENCES Produse(id_produs)


ALTER TABLE Tablouri
ADD nume_tablou VARCHAR(50);