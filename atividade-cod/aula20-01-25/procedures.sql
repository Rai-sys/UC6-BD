-- Procedures - Procedimentos
CREATE OR REPLACE PROCEDURE inserir_novo_ator(
  nome VARCHAR,
  nacionalidade VARCHAR,
  data_nascimento DATE
) LANGUAGE SQL
AS $$
INSERT INTO autor(nome, nacionalidade, data_nascimento)
VALUES (nome, nacionalidade, data_nascimento)
$$;

-- Procedimento para criar uma nova categoria
select * from categoria

CREATE OR REPLACE PROCEDURE inserir_nova_categoria(
  nome VARCHAR,
  descricao TEXT
) LANGUAGE SQL
AS $$
INSERT INTO categoria(nome, descricao)
VALUES (nome, descricao)
$$;


-- ALTERAR TELEFONE DA TABELA UNIDADE
select * from unidade

CREATE OR REPLACE PROCEDURE update_telefone_unidade (
  id_unidade INTEGER,
  telefone_unidade VARCHAR
) LANGUAGE SQL
as $$
  UPDATE unidade
  SET telefone = telefone_unidade
  WHERE id = id_unidade
$$;

-- ALTERAR NOME DA TABELA USUARIO
select * from usuario

CREATE OR REPLACE PROCEDURE update_nome_usuario (
  id_usuario INTEGER,
  nome_usuario VARCHAR
) LANGUAGE SQL
as $$
  UPDATE usuario
  SET nome = nome_usuario
  WHERE id = id_usuario
$$;

-- DELETAR LIVRO 
select * from livro

CREATE OR REPLACE PROCEDURE deletar_livro (
  id_livro INTEGER
) LANGUAGE SQL
as $$
  DELETE FROM livro
  WHERE id = id_livro
$$;

