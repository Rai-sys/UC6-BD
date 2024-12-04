-- CRIANDO UM BANCO DE DADOS (DATABASE)
-- create database aula06

-- CRIANDO UMA TABELA
-- create table if not exists produto(
--   id int primary key,
--   cod varchar(4) unique,
--   nome varchar(100) not null,
--   preco real check(preco > 0)
-- );

-- --\dt; (descrição das estruturas do banco) 
-- \d produto; (console.log pra tabela)

-- -- DELETANDO UMA BASE DE DADOS
-- -- drop database aula06;

-- -- DELETANDO UMA TABELA
-- drop table produto;

-- \dt;

-------------------------------------------------------------------------------------

-- -- CRIAR DUAS TABELAS
-- Professor (id*, nome, cpf)
-- Turma (id*, numero*, duracao_dias)

create table if not exists Professor(
  id int primary key,
  nome varchar(70) not null,
  cpf char(11) unique not null
);



create table if not exists Turma (
  id int,
  numero int,
  duracao_dias int,
  id_professor int,
  primary key (id, numero),
  constraint fk_prof foreign key(id_professor) references Professor(id)
);

\dt;
\d Turma;
\d Professor;


-----------------------------------------------------------------------------------------------------------------

create table if not exists Fornecedor (
  id serial primary key,
  nome varchar(60) not null,
  cidade varchar(60)
);

create table if not exists Peca (
  id serial primary key,
  nome varchar(60) not null,
  descricao varchar(200)
);

create table if not exists Venda (
  idFornecedor serial,
  idPeca serial,
  data date,
  quantidade int,
  foreign key (idFornecedor) references Fornecedor(id),
  foreign key (idPeca) references Peca(id)
);

\d Fornecedor;
\d Peca;
\dt;

alter table Fornecedor add Telefone char(9);
\d Fornecedor;

alter table Peca add Preco money;
\d Peca;

alter table Fornecedor drop column cidade;  
\d Fornecedor;