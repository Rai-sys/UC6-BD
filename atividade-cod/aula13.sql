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
  CONSTRAINT chk_data_devolucao CHECK (data_emprestimo <= data_devolucao)
);