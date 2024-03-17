create database Spa
use Spa

create table oras
(
id int identity(1,1) primary key,
nume varchar(50)
)

create table spa
(
id int identity(1,1) primary key,
nume varchar(50),
site varchar(50),
id_oras int,
constraint fk_oras foreign key(id_oras) references oras(id)
)

create table servicii
(id int identity(1,1) primary key,
nume varchar(50),
descriere varchar(50),
pret int,
recomandare varchar(50),
id_spa int,
constraint fk_spa foreign key(id_spa) references spa(id)
)

create table clienti
(
id int identity(1,1) primary key,
nume varchar(50),
prenume varchar(50),
ocupatie varchar(50),
)

create table servicii_clienti
(
id_serv int,
id_client int,
nota int,
constraint pk_servicii_clienti primary key (id_serv, id_client),
constraint fk_serv foreign key(id_serv) references servicii(id),
constraint fk_clienti foreign key(id_client) references clienti(id)
)

go

-- Populează tabela 'oras'
INSERT INTO oras (nume) VALUES
('Bucuresti'),
('Cluj-Napoca'),
('Timisoara'),
('Iasi'),
('Brasov');

-- Populează tabela 'spa'
INSERT INTO spa (nume, site, id_oras) VALUES
('Spa Relax', 'www.sparelax.ro', 1),
('Zen Spa', 'www.zenspa.com', 2),
('Aqua Wellness', 'www.aquawellness.com', 3),
('Elysium Spa', 'www.elysiumspa.ro', 4),
('Mountainside Retreat', 'www.mountainsideretreat.com', 5);

-- Populează tabela 'servicii'
INSERT INTO servicii (nume, descriere, pret, recomandare, id_spa) VALUES
('Masaj de relaxare', 'O ora de masaj pentru relaxare profunda', 100, 'Recomandat pentru stres', 1),
('Tratament facial', 'Curatare faciala si masca de hidratare', 80, 'Recomandat pentru ten uscat', 2),
('Pachet Detox', 'Sauna, masaj detoxifiant si ceaiuri', 120, 'Recomandat pentru eliminarea toxinelor', 3),
('Tratament Spa de lux', 'O experienta de relaxare completa', 150, 'Recomandat pentru rasfat', 4),
('Yoga si meditatie', 'Sesiuni de yoga si meditatie ghidate', 60, 'Recomandat pentru echilibrare', 5);

-- Populează tabela 'clienti'
INSERT INTO clienti (nume, prenume, ocupatie) VALUES
('Popescu', 'Ion', 'Inginer'),
('Ionescu', 'Maria', 'Profesor'),
('Radulescu', 'Andrei', 'Student'),
('Dumitru', 'Elena', 'Medic'),
('Gheorghescu', 'Gabriel', 'Antreprenor');

-- Populează tabela 'servicii_clienti'
INSERT INTO servicii_clienti (id_serv, id_client, nota) VALUES
(1, 1, 4),
(2, 3, 5),
(3, 2, 3),
(4, 4, 5),
(5, 5, 4);

go

create or alter procedure serviciu_client
	@id_serv int,
	@id_client int,
	@nota int
as
begin
	if exists (select * from servicii_clienti where id_serv=@id_serv and id_client=@id_client)
	begin
		update servicii_clienti set nota=@nota where id_serv=@id_serv and id_client=@id_client
	end;
	else
	begin
		insert into servicii_clienti(id_serv, id_client, nota) values (@id_serv, @id_client, @nota)
	end;
end;


select *from servicii_clienti
exec serviciu_client 1, 5, 5

go

create or alter function AfiseazaServiciiCuDescriereNotNull()
returns table
as
return
(
    select
        spa.nume as 'nume_spa',
        servicii.nume as 'nume_serviciu',
        servicii.descriere,
        servicii_clienti.nota,
        clienti.nume, 
		clienti.prenume
    from
        servicii
    join
        spa ON servicii.id_spa = spa.id
    join
        servicii_clienti ON servicii.id = servicii_clienti.id_serv
    join
        clienti ON servicii_clienti.id_client = clienti.id
    where
        servicii.descriere IS NOT NULL
);

select * from AfiseazaServiciiCuDescriereNotNull();
