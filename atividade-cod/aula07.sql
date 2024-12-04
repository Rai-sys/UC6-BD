-- ATIVIDADE 06 - 04/12


-- create table Editora (
--   id serial primary key,
--   nome_editora varchar(20) not null unique
-- );

-- create table Genero (
--   id serial primary key,
--   genero char(18) not null unique
-- );

-- create table Usuario (
--   id serial primary key,
--   nome varchar(60) not null,
--   email varchar(30) not null unique,
--   telefone varchar(11) not null,
--   data_cadastro date not null
-- );

-- create table Livro (
--   id serial primary key,
--   titulo text not null unique,
--   quantidade_disponivel int check (quantidade_disponivel >= 0),
--   editora int references Editora(id),
--   genero int references Genero(id)
-- );

-- create table Emprestimo (
--   id serial primary key,
--   data_emprestimo date not null
-- );

-- \d Usuario;
-- \d Livro;
-- \d Emprestimo;
-- \d Editora;
-- \d Genero;


---------------------- CORREÇÃO ---------------------------------------------------------

create table Editora (
  id_editora serial primary key,
  nome_editora varchar(100) not null unique
);

create table Genero (
  id_genero serial primary key,
  genero char(18) not null unique
);

create table Usuario (
  id_usuario serial primary key,
  nome varchar(100) not null,
  email varchar(100) not null unique,
  --telefone varchar(11) default 'nenhuma',
  data_cadastro timestamp default current_timestamp
);

create table Livro (
  id_livro serial primary key,
  titulo varchar(150) not null unique,
  quantidade_disponivel int not null check (quantidade_disponivel >= 0),
  id_editora int not null,
  id_genero int not null,
  constraint fk_livro_editora foreign key (id_editora) references Editora(id_editora) on delete cascade,
  constraint fk_livro_genero foreign key (id_genero) references Genero(id_genero) on delete cascade
);

create table Emprestimo (
  id serial primary key,
  id_usuario int not null,
  id_livro int not null,
  data_emprestimo timestamp default current_timestamp,
  data_devolucao timestamp not null,
  constraint fk_emprestimo_usuario foreign key (id_usuario) references Usuario(id_usuario) on delete cascade,
  constraint fk_emprestimo_livro foreign key (id_livro) references Livro(id_livro) on delete cascade
);

-- ADICIONAR UM CAMPO PARA ADICIONAR O TELEFONE DOS USUARIOS
\d Livro;
-- alter table Usuario add telefone char(11);
alter table Usuario add column telefone char(11) default 'nenhum';
alter table Livro alter column titulo type varchar(200);
\d Livro;

-- REMOVER O CAMPO DATA_CADASTRO DA TABELA USUARIO 
alter table Usuario drop data_cadastro;
\d Usuario

-- GARANTA QUE O MESMO TITULO NAO POSSA SER REGISTRADO NA MESMA EDITORA 
alter table Livro add constraint uq_livro_titulo_editora unique (titulo, id_editora);
\d Livro;

-- GARANTA QUE AS DATAS DE EMPRESTIMO E DEVOLUÇÃO SEJAM DISTINTAS E VÁLIDAS
alter table Emprestimo add constraint chk_data_devolucao check (data_devolucao >= data_emprestimo);

insert into Usuario(id_usuario, nome, email)
values (1, 'Valtemir', 'valtemir@gmail.com'), (2, 'valtemir Jr','valtemirjr@gmail.com');
select *from Usuario
