create database Cluburi
go
use Cluburi
go


create table tara
(
id int identity(1,1) primary key,
nume varchar(50),
continent varchar(50),
)

create table tanar
(
id int identity(1,1) primary key,
nume varchar(50),
email varchar(50),
ocupatie varchar(50),
data_nasterii date not null,
id_tara int,
constraint fk_tara foreign key (id_tara) references tara(id)
)

create table categorie
(
id int identity(1,1) primary key,
denumire varchar(50)
)

create table club
(
id int identity(1,1) primary key,
nume varchar(50),
descr varchar(50),
adr varchar(50),
website varchar(50),
tel varchar(15),
id_categ int,
constraint fk_categ foreign key (id_categ) references categorie(id)
)

create table cheltuieli
(
id_tanar int,
id_club int,
suma int check(suma>0),
zi date
constraint pk_cheltuieli primary key (id_tanar, id_club),
constraint fk_tanar foreign key (id_tanar) references tanar(id),
constraint fk_club foreign key (id_club) references club(id)
)


insert into tara(nume, continent) values ('Romania','Europa'),('Finlanda','Europa'),('Thailanda','Asia')
select * from tara

insert into tanar(nume, email, ocupatie, data_nasterii, id_tara) values ('Alex', 'alex@gmail.com','student','2003-10-10',1)
insert into tanar(nume, email, ocupatie, data_nasterii, id_tara) values ('Samuel', 'samuel@gmail.com', 'politist', '2001-08-12', 2),
('Lee','lee@gmail.com','student','2002-09-02',3), ('Maria','maria@gmail.com','student','2004-11-11',1)
select * from tanar

insert into categorie(denumire) values ('cat1'),('cat2'),('cat3')
select * from categorie

insert into club(nume, descr, adr, website, tel, id_categ) values ('club1','descr1','str.1 nr.1', 'www.club1.ro', '0712345678', 1),
('club2','descr2','str.2 nr.2', 'www.club2.ro', '0733345678', 2), ('club3','descr3','str.3 nr.3', 'www.club3.ro', '0712333378', 3),
('club4','descr4','str.4 nr.4', 'www.club4.ro', '0712345444', 2)
select * from club


insert into cheltuieli(id_tanar, id_club, suma, zi) values (1,1,750,'2024-01-19'), (2,2,1000,'2024-01-17'),(3,3,900,'2024-01-18'),
(4,4,1200,'2024-01-20'),(1,4,1500,'2023-12-12')
select * from cheltuieli

go

create or alter procedure vizita
	@id_tanar int,
	@id_club int,
	@suma int,
	@zi date
as 
begin
	if exists(select id_tanar from cheltuieli where id_tanar=@id_tanar and id_club=@id_club and zi=@zi)
	begin
		update cheltuieli set suma = @suma where id_tanar=@id_tanar and id_club=@id_club and zi=@zi
	end;
	else
	begin
		insert into cheltuieli(id_tanar, id_club, suma, zi) values (@id_tanar, @id_club, @suma, @zi)
	end;
end;
exec vizita 2, 1, 3000, '2024-01-19'

go

create or alter function functie()
returns table 
as
return
(
	select
		t.nume, t.email, suma= sum(c.suma), nr_vizite=count(c.id_club)
	from
		tanar t
	inner join cheltuieli c on t.id=c.id_tanar
	group by t.nume, t.email
	having sum(suma) >2000 and count(id_club) <> 3
)

select * from functie() order by suma desc