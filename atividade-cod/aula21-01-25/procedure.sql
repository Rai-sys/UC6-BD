-- 1. Crie uma procedure para adicionar um novo autor ao banco de dados.

CREATE OR REPLACE PROCEDURE add_autor (
	id INTEGER,
	nome VARCHAR,
	nacionalidade VARCHAR,
	data_nascimento DATE
) LANGUAGE SQL
AS $$
	INSERT INTO autor(id, nome, nacionalidade, data_nascimento)
	VALUES (id, nome, nacionalidade, data_nascimento)
$$;

-- 2. Crie uma procedure para registrar um novo empréstimo, verificando se o livro está
-- disponível.

CREATE OR REPLACE PROCEDURE registrar_emprestimo (
	
)