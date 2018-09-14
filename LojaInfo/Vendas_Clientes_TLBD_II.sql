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

create table tb_hardware (
id_hardware int primary key identity(1,1) not null,
descricao nvarchar(200),
preco decimal,
qtde int,
qtde_min int
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

insert into tb_clientes(nome, endereco, fone, email)
values('Huguinho', 'Rua das Flores', '2620-4859', 'hugo.rodrigues@outlook.com')
insert into tb_clientes(nome, endereco, fone, email)
values('Maria', 'Rua 14', '8597-6249', 'maria.santos@gmail.com')
insert into tb_clientes(nome, endereco, fone, email)
values('Andre', 'Rua Jardim', '2659-8946', 'andre153@outlook.com')

insert into tb_hardware(descricao, preco, qtde, qtde_min)
values ('mouses', '49.90', '500', '150')
insert into tb_hardware(descricao, preco, qtde, qtde_min)
values ('teclado', '44.90', '500', '150')
insert into tb_hardware(descricao, preco, qtde, qtde_min)
values ('mousepad', '10.00', '500', '150')

insert into tb_vendas (id_cliente, data, valor_total, desconto,valor_pago)
values ('1' ,'03/01/2018', '200', '20', '180')
insert into tb_vendas (id_cliente, data, valor_total, desconto, valor_pago)
values ('2' ,'04/01/2018', '100', '5', '95')
insert into tb_vendas (id_cliente, data, valor_total, desconto, valor_pago)
values ('3', '05/01/2018', '150', '10', '140')

insert into tb_vendas_itens(id_vendas, id_hardware, qtde_item, total_item)
values ('1', '1', '100', '200')
insert into tb_vendas_itens(id_vendas, id_hardware, qtde_item, total_item)
values ('2', '2', '50', '100')
insert into tb_vendas_itens(id_vendas, id_hardware, qtde_item, total_item)
values ('3', '3', '150', '300')


--exemplo de stored procedure
if OBJECT_ID ('dbo.proc_exemplo') is not null
drop proc dbo.selec_produtos_com_algum_desconto
go

create procedure dbo.selec_produtos_com_algum_desconto
(
@desc_min as decimal (10,2),
@desc_max as decimal (10,2)
)
as 
begin
select @desc_min as "Desconto Mínimo", @desc_max as "Desconto Máximo"
--fazer aqui um select dos nomes dos produtos e seus respectivos descontos
end

-----------------------------------------------------------------------------------------------------------

exec dbo.selec_produtos_com_algum_desconto

--exec sp_tables

--exec sp_help tb_clientes

select * from tb_clientes

--exec sp_help tb_hardware

select * from tb_hardware

--exec sp_help tb_vendas

select * from tb_vendas

--exec sp_help tb_vendas_itens

select * from tb_vendas_itens