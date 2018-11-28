use master
go

drop database aulaTransaction
go

create database aulaTransaction
go

use aulaTransaction
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

insert into tb_departamento (nome) values 
('Marketing'),
('Financeiro'),
('Comercial'),
('Departamento Pessoal'),
('Operacional')
go

insert into tb_pessoas (nomeP) values 
('Ana'),
('Bianca'),
('Carla'),
('Daniel'),
('Elisangela')
go

insert into tb_relPesDpto (id_dpto, id_pessoa) values 
(2, 3),
(3, 4),
(4, 5),
(5, 1),
(1, 2)
go

if OBJECT_ID ('trg_AfterInsertPessoa') is not null
drop TRIGGER trg_AfterInsertPessoa
go

create trigger trg_AfterInsertPessoa on tb_departamento for insert as
declare @IdDpto int;
begin
	declare @IdPessoa int;
	select @IdPessoa = max (id_pessoa) from tb_pessoas;
	
	IF NOT EXISTS (select id_pessoa from tb_relPesDpto where id_pessoa = @IdPessoa)
		begin			
			declare @NmDpto nvarchar(180);
			declare @auditAction nvarchar(180);
			
			select @IdDpto = i.id_dpto from inserted i;
					
			set @auditAction = 'Registro inserido';				
						
			insert into tb_relPesDpto (id_dpto, id_pessoa)
			values (@IdDpto, @IdPessoa);
		end;
	ELSE 
		begin
			rollback;
			set @auditAction = 'Registro não inserido';
		end;
end
go

begin transaction
	insert into tb_pessoas (nomeP) values ('Leandro')
	go
	insert into tb_departamento (nome) values ('RH')
	go
commit
go

select * from tb_departamento
select * from tb_pessoas
select * from tb_relPesDpto