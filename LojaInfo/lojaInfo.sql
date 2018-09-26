use master
go

drop database lojainfo

create database lojainfo
go

use lojainfo 
go

create table tb_clientes (
id_cliente int primary key identity(1,1) not null,
nome nvarchar(80),
endereco nvarchar(50),
fone nvarchar(20),
email nvarchar(70)

)
go

create table tb_cliente_auditoria (
id_cliente int primary key identity(1,1) not null,
nome nvarchar(180),
endereco nvarchar(180),
fone nvarchar(80),
email nvarchar(180),
acao_auditoria nvarchar(180),
data_auditoria nvarchar(180)
)
go

create table tb_hardware (
id_hardware int primary key identity(1,1) not null,
descricao nvarchar(200),
preco decimal,
qtde int,
qtde_min int,
promo char(1)
) 
go

create table tb_vendas (
id_vendas int primary key identity(1,1) not null,
id_cliente int,
data date,
valor_total decimal,
desconto decimal,
valor_pago decimal
)
go

create table tb_vendas_itens (
id_item int primary key identity(1,1) not null,
id_vendas int,
id_hardware int, 
qtde_item int,
total_item int
)
go

alter table tb_vendas add constraint fk_id_cliente foreign key (id_cliente) references tb_clientes (id_cliente)
alter table tb_vendas_itens add constraint fk_id_vendas foreign key (id_vendas) references tb_vendas (id_vendas)
alter table tb_vendas_itens add constraint fk_id_hardware foreign key (id_hardware) references tb_hardware (id_hardware)

--------------------------------------------------------------------------------------------------------------------------

insert into tb_clientes(nome, endereco, fone, email)
values('Huguinho', 'Rua das Flores', '2620-4859', 'hugo.rodrigues@outlook.com')
insert into tb_clientes(nome, endereco, fone, email)
values('Maria', 'Rua 14', '8597-6249', 'maria.santos@gmail.com')
insert into tb_clientes(nome, endereco, fone, email)
values('Andre', 'Rua Jardim', '2659-8946', 'andre153@outlook.com')

-------------------------------------------------------------------------------------------------------------

insert into tb_cliente_auditoria (nome, endereco, fone, email, acao_auditoria, data_auditoria)  
values ('Mariazinha','Rua das Abelhas, 158','98564-4632','maria.almeida@gmail.com','blablabla', GETDATE())

-------------------------------------------------------------------------------------------------------------

insert into tb_hardware(descricao, preco, qtde, qtde_min, promo)
values ('mouses', '49.90', '500', '150', 'N')
insert into tb_hardware(descricao, preco, qtde, qtde_min, promo)
values ('teclado', '44.90', '500', '150', 'N')
insert into tb_hardware(descricao, preco, qtde, qtde_min, promo)
values ('mousepad', '10.00', '500', '150', 'N')

-------------------------------------------------------------------------------------------------------------

insert into tb_vendas (id_cliente, data, valor_total, desconto,valor_pago)
values ('1' ,'03/01/2018', '200', '20', '180')
insert into tb_vendas (id_cliente, data, valor_total, desconto, valor_pago)
values ('2' ,'04/01/2018', '100', '5', '95')
insert into tb_vendas (id_cliente, data, valor_total, desconto, valor_pago)
values ('3', '05/01/2018', '150', '10', '140')

-------------------------------------------------------------------------------------------------------------

insert into tb_vendas_itens(id_vendas, id_hardware, qtde_item, total_item)
values ('1', '1', '100', '200')
insert into tb_vendas_itens(id_vendas, id_hardware, qtde_item, total_item)
values ('2', '2', '50', '100')
insert into tb_vendas_itens(id_vendas, id_hardware, qtde_item, total_item)
values ('3', '3', '150', '300')

-----------------------------------------------------------------------------------------------------------
--PROCEDURE

if OBJECT_ID ('dbo.desconto_max') is not null
drop proc dbo.desconto_max 
go

create procedure dbo.desconto_max as
begin 
		
	update tb_hardware set preco=preco-(preco*0.10) where promo='N'
	update tb_hardware set promo='S'
	select id_hardware as 'ID do Hardware', descricao as 'Produto', preco as 'Preço' from tb_hardware
	
end
go

-----------------------------------------------------------------------------------------------------------

exec dbo.desconto_max

update tb_hardware set preco='49.90' where descricao='mouses'
update tb_hardware set preco='44.90' where descricao='teclado'
update tb_hardware set preco='10.00' where descricao='mousepad'
update tb_hardware set promo='N'

select * from tb_hardware

-------------------------------------------------------------------------------------------------------------
--TRIGGER
GO

CREATE TRIGGER trg_AfterInsert ON tb_clientes
FOR INSERT AS
BEGIN
	declare @CliId int;
	declare @CliNome nvarchar(180);
	declare @CliEnd nvarchar(180);
	declare @CliFone nvarchar(180);
	declare @CliEmail nvarchar(180);
	declare @audit_action nvarchar(180);
	
	select @CliId = i.id_cliente from inserted i;
	select @CliNome = i.nome from inserted i;
	select @CliEnd = i.endereco from inserted i;
	select @CliEmail = i.email from inserted i;
	
	set @audit_action='Registro Inserido';
	insert into tb_cliente_auditoria (id_cliente, nome, endereco, fone, email, acao_auditoria, data_auditoria)  
	values (@CliId, @CliNome, @CliEnd, @CliFone, @CliEmail, @audit_action, GETDATE());
END
GO

-------------------------------------------------------------------------------------------------------------