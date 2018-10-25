drop database aulaTransaction
go

create database aulaTransaction
go

use master
go

create table tb_departamento (
id_dpto int primary key identity(1,1) not null,
nome varchar(100),
)
go

create table tb_pessoas (
id_pessoa int primary key identity(1,1) not null,
nomeP varchar(100),
)
go

create table tb_relPesDpto (
id_Rel int primary key identity(1,1) not null,
id_dpto int not null,
id_pessoa int not null,

foreign key (id_dpto) references tb_departamento(id_dpto),
foreign key (id_pessoa) references tb_pessoas(id_pessoa)
)
go

--------------------------------------------------------------------------------------------------------------------------

	--SEM TRANSACTION

--insert into tb_departamento (nome) values ('Marketing'),('Financeiro'), ('Comercial'), ('Departamento Pessoal'), ('Operacional')
--go

--insert into tb_pessoas (nomeP) values ('Ana'), ('Bianca'), ('Carla'), ('Daniel'), ('Elisangela')
--go

--insert into tb_relPesDpto (id_dpto, id_pessoa) values (2, 3), (3, 4), (4, 5), (5, 1), (1, 2)
--go

--------------------------------------------------------------------------------------------------------------------------

	--COM TRANSACTION

begin transaction
	insert into tb_departamento (nome) values ('Facilities')
	go
	insert into tb_pessoas (nomeP) values ('Fernando')
	go
	insert into tb_relPesDpto (id_dpto, id_pessoa) values (2, 4)
	go
commit

--------------------------------------------------------------------------------------------------------------------------

select * from tb_departamento
select * from tb_pessoas
select * from tb_relPesDpto