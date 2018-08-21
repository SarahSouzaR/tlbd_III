use master;
go
drop database banco_scratch;
go
create database banco_scratch;
go
use banco_scratch;
go

create table tb_pessoas (
id_pessoa int NOT NULL identity (1,1),
nome varchar (50),
email varchar (100) unique,
sexo char(1),

primary key (id_pessoa),
)

create table tb_tarefa (
id_tarefa int NOT NULL identity (1,1),
titulo varchar (200) unique,
prazo_estimado date,
descricao varchar (200),
dt_inicio date NOT NULL,
dt_termino date, 

primary key (id_tarefa),
)

create table tb_metodologia (
id_metodologia int NOT NULL identity (1,1), 
metodo_nome varchar (50),

primary key (id_metodologia),
)

create table tb_time (
id_time int NOT NULL primary key identity (1,1),
nm_time varchar(100),
id_pessoa int NOT NULL,	

foreign key (id_pessoa) references tb_pessoas(id_pessoa),
)

create table tarefa_participantes (
id_participante int NOT NULL primary key identity (1,1),
id_tarefa int NOT NULL,
id_pessoa int NOT NULL, 

foreign key (id_tarefa) references tb_tarefa (id_tarefa), 
foreign key (id_pessoa) references tb_pessoas(id_pessoa), 
)

-- insert tb_pessoas

go 
insert into tb_pessoas (nome, email, sexo)
values ('Sarah de Souza', 'sarah.souza@gmail.com', 'F')
insert into tb_pessoas (nome, email, sexo)
values ('Adrielle Santos', 'adrielle.santos@hotmail.com', 'F')
insert into tb_pessoas (nome, email, sexo)
values ('Lucas Silva', 'lucas.s@outlook.com', 'M')
insert into tb_pessoas (nome, email, sexo)
values ('Anderson Oliveira', 'oliver.anderson@gmail.com', 'M')
insert into tb_pessoas (nome, email, sexo)
values ('Paulo Almeida', 'paulo.all@yahoo.com', 'M')
insert into tb_pessoas (nome, email, sexo)
values ('Fernanda Santos', 'feh.santos@hotmail.com', 'F')
insert into tb_pessoas (nome, email, sexo)
values ('Alexandre Pereira', 'alex.p.s@outlook.com', 'M')

-- insert tb_tarefas

go
insert into tb_tarefa (titulo, prazo_estimado,descricao, dt_inicio, dt_termino)
values ('Trabalho de Matematica', '2018-08-20', 'Resolver exercicios de calculo I', '2018-08-07', '2018-08-07')
insert into tb_tarefa (titulo, prazo_estimado,descricao, dt_inicio, dt_termino)
values ('Topico do TCC', '2018-08-08', 'Adicionar o indice de figuras', '2018-08-07', '2018-08-07')
insert into tb_tarefa (titulo, prazo_estimado,descricao, dt_inicio, dt_termino)
values ('Redação', '2018-08-18', 'Dissertacao argumentativa sobre a saude no Brasil','2018-08-04', '2018-08-05')
insert into tb_tarefa (titulo, prazo_estimado,descricao, dt_inicio, dt_termino)
values ('Calculadora em JAVA', '2018-08-09', 'Calculadora com soma, subtracao, multiplicacao e divisao', '2018-08-05', '2018-08-15')
insert into tb_tarefa (titulo, prazo_estimado,descricao, dt_inicio, dt_termino)
values ('Enviar documentos', '2018-08-08', 'Enviar documentos para isencao da taxa do vestibular', '2018-08-06', '2018-08-06')

-- insert tarefa_participantes

go 
insert into tarefa_participantes (id_tarefa, id_pessoa)
values (1,1)
insert into tarefa_participantes (id_tarefa, id_pessoa)
values (4,2)
insert into tarefa_participantes (id_tarefa, id_pessoa)
values (1,3)
insert into tarefa_participantes (id_tarefa, id_pessoa)
values (2,4)
insert into tarefa_participantes (id_tarefa, id_pessoa)
values (3,2)

-- insert tb_metodologia

go 
insert into tb_metodologia (metodo_nome)
values ('Scrum')
insert into tb_metodologia (metodo_nome)
values ('Pomodoro')
insert into tb_metodologia (metodo_nome)
values ('Scrum')
insert into tb_metodologia (metodo_nome)
values ('Scrum')

select * from tb_pessoas

select * from tb_tarefa

select * from tb_metodologia

select * from tarefa_participantes

--Exercício 1

select p.id_pessoa, p.nome, t.id_tarefa from tb_pessoas as p
left join tb_tarefa as t on p.id_pessoa=t.id_tarefa where id_tarefa is null


--Exercício 2

select metodo_nome as Metodologia, count (metodo_nome) as Quantidade from tb_metodologia group by metodo_nome order by count(metodo_nome) desc;


--Exercício 3 

--mulheres
select count(*) as Mulheres from tb_tarefa as t 
left join tb_pessoas as p on t.id_tarefa = p.id_pessoa where sexo = 'F';

--homem
select count(titulo) as Homens from tb_tarefa as t 
left join tb_pessoas as p on t.id_tarefa = p.id_pessoa where sexo = 'M';


--Exercício 4 - OK

select p.nome, p.id_pessoa, t.id_tarefa, t.prazo_estimado, t.dt_termino
from tb_tarefa as t
inner join tarefa_participantes as tp on t.id_tarefa=tp.id_tarefa
inner join tb_pessoas as p on p.id_pessoa=tp.id_pessoa
where t.dt_termino > t.prazo_estimado

