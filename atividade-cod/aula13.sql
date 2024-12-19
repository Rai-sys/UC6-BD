begin;
CREATE TABLE autor (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  data_nascimento DATE,
  CONSTRAINT chk_data_nascimento CHECK (data_nascimento <= CURRENT_DATE)
);

CREATE TABLE livro (
  id SERIAL PRIMARY KEY,
  id_autor SERIAL,
  titulo VARCHAR(60) NOT NULL,
  ano_publicacao INT,
  CONSTRAINT fk_autor_livro FOREIGN KEY (id_autor) REFERENCES autor(id),
  CONSTRAINT chk_ano_publicacao CHECK (ano_publicacao >= 1500 AND ano_publicacao <= EXTRACT(YEAR FROM CURRENT_DATE))
);

CREATE TABLE usuario (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  email VARCHAR(80) UNIQUE,
  data_adesao DATE,
  CONSTRAINT chk_data_adesao CHECK (data_adesao <= CURRENT_DATE)
);

CREATE TABLE emprestimo (
  id SERIAL PRIMARY KEY,
  id_livro SERIAL,
  id_usuario SERIAL,
  data_emprestimo DATE NOT NULL,
  data_devolucao DATE NOT NULL,
  CONSTRAINT fk_livro FOREIGN KEY (id_livro) REFERENCES livro(id),
  CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id),
  CONSTRAINT chk_data_devolucao CHECK (data_emprestimo <= data_devolucao),
  CONSTRAINT uq_livro_emprestimo UNIQUE (id_livro, id) 
);

-- CRIANDO AS INSERÇÕES
begin;
INSERT INTO autor (id, nome, data_nascimento)
VALUES (1, 'William Shakespeare', '23-04-1564'),
(2, 'Jane Austen', '16-12-1775'),
(3, 'Clarice Lispector', '10-12-1920'),
(4, 'Machado de Assis', '21-06-1839'),
(5, 'J.R.R. Tolkien', '03-01-1892');

INSERT INTO livro (id, id_autor, titulo, ano_publicacao)
VALUES (1, 1, 'Romeu e Julieta', '1597'),
(2, 2, 'Orgulho e Preconceito', '1813'),
(3, 3, 'A Hora da Estrela', '1977'),
(4, 4, 'Dom Casmurro', '1899'),
(5, 5, 'O Senhor dos Anéis', '1954');

INSERT INTO usuario (id, nome, email, data_adesao)
VALUES (1, 'Gustavo', 'gustavo01@gmail', '12-12-2023'),
(2, 'Ana Clara', 'anaclara02@gmail', '05-06-2022'),
(3, 'Pedro', 'pedro@gmail', '20-02-2020'),
(4, 'Joca', 'joca@gmail', '04-10-2021'),
(5, 'Maria Flor', 'mariaflor@gmail', '26-03-2023');

INSERT INTO emprestimo (id, id_livro, id_usuario, data_emprestimo, data_devolucao)
VALUES (1, 1, 1, '12-12-2022', '15-12-2022'),
(2, 2, 2, '10-11-2023', '14-11-2023'),
(3, 3, 3, '12-03-2011', '14-03-2011'),
(4, 4, 4, '02-02-2022', '05-02-2022'),
(5, 5, 5, '07-01-2021', '10-01-2021');

SELECT * FROM autor;
SELECT * FROM livro;
SELECT * FROM usuario;
SELECT * FROM emprestimo;