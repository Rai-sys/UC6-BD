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

CREATE TABLE Editora (
  id_editora SERIAL PRIMARY KEY,
  nome_editora VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Genero (
  id_genero SERIAL PRIMARY KEY,
  genero CHAR(18) NOT NULL UNIQUE
);

CREATE TABLE Usuario (
  id_usuario SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  --telefone VARCHAR(11) DEFAULT 'nenhuma',
  data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Livro (
  id_livro SERIAL PRIMARY KEY,
  titulo VARCHAR(150) NOT NULL UNIQUE,
  quantidade_disponivel INT NOT NULL CHECK (quantidade_disponivel >= 0),
  id_editora INT NOT NULL,
  id_genero INT NOT NULL,
  CONSTRAINT fk_livro_editora FOREIGN KEY (id_editora) REFERENCES Editora(id_editora) ON DELETE CASCADE,
  CONSTRAINT fk_livro_genero FOREIGN KEY (id_genero) REFERENCES Genero(id_genero) ON DELETE CASCADE
);

CREATE TABLE Emprestimo (
  id SERIAL PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_livro INT NOT NULL,
  data_emprestimo TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  data_devolucao TIMESTAMP NOT NULL,
  CONSTRAINT fk_emprestimo_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
  CONSTRAINT fk_emprestimo_livro FOREIGN KEY (id_livro) REFERENCES Livro(id_livro) ON DELETE CASCADE
);

-- ADICIONAR UM CAMPO PARA ADICIONAR O TELEFONE DOS USUARIOS

-- alter table Usuario add telefone char(11);
ALTER TABLE Usuario ADD column telefone CHAR(11) DEFAULT 'nenhum';
ALTER TABLE Livro ALTER column titulo TYPE VARCHAR(200);

-- REMOVER O CAMPO DATA_CADASTRO DA TABELA USUARIO 
ALTER TABLE Usuario DROP data_cadastro;

-- GARANTA QUE O MESMO TITULO NAO POSSA SER REGISTRADO NA MESMA EDITORA 
ALTER TABLE Livro ADD CONSTRAINT uq_livro_titulo_editora UNIQUE (titulo, id_editora);


-- GARANTA QUE AS DATAS DE EMPRESTIMO E DEVOLUÇÃO SEJAM DISTINTAS E VÁLIDAS
ALTER TABLE Emprestimo ADD CONSTRAINT chk_data_devolucao CHECK (data_devolucao >= data_emprestimo);

INSERT INTO Usuario(id_usuario, nome, email, telefone)
VALUES (1, 'Valtemir', 'valtemir@gmail.com', '9999-9999'), (2, 'valtemir Jr','valtemirjr@gmail.com', '8888-8888');
SELECT * FROM Usuario;

INSERT INTO Editora(id_editora, nome_editora)
VALUES (1, 'Senac'), (2, 'Sesc'), (3, 'Mundo'), (4, 'Dark Side'), (5, 'Leitura');
SELECT * FROM Editora;

INSERT INTO Genero (id_genero, genero)
VALUES (1, 'Terror'), (2, 'Romance'), (3, 'Drama'), (4, 'Fantasia'), (5, 'Infantil');
SELECT * FROM Genero;

INSERT INTO Livro (titulo, quantidade_disponivel, id_editora, id_genero)
VALUES 
('O Iluminado', '09', 3, 3),
('Orgulho e Preconceito', '15', 2, 2),
('Um Conto de Duas Cidades', '03', 1, 1),
('O Príncipe Cruel', '17', 4, 4),
('O Pequeno Príncipe', '10', 5, 5);
SELECT * FROM Livro;

INSERT INTO Emprestimo (id_usuario, id_livro, data_devolucao)
VALUES (1, 4, '2024-12-06'), (2, 5, '2024-12-07');
SELECT * FROM Emprestimo;