-- 1 Crie uma Procedure para adicionar um novo autor ao banco de dados.
CREATE OR REPLACE PROCEDURE adicionar_autor(
    nome_autor VARCHAR, 
    nacionalidade_autor VARCHAR, 
    data_nascimento DATE
)
LANGUAGE SQL
AS $$
INSERT INTO autor (nome, nacionalidade, data_nascimento)
VALUES (nome_autor, nacionalidade_autor, data_nascimento);
$$;

-- 2 Crie uma Procedure para registrar um novo empréstimo, verificando se o livro está disponível.

CREATE OR REPLACE PROCEDURE registrar_emprestimo(
    p_id_usuario INT, 
    p_id_livro INT, 
    p_data_devolucao TIMESTAMP
)
	LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO emprestimo (id_usuario, id_livro, data_devolucao)
    VALUES (p_usuario, p_id_livro,p_data_devolucao);
    UPDATE livro SET disponivel = FALSE 
	WHERE id = p_id_livro;
END;
$$;

-- 3 Crie uma Procedure para devolver um livro, atualizando o status de devolução e disponibilidade.

CREATE OR REPLACE PROCEDURE devolver_livro(
    id_emprestimo INTEGER, 
    data_devolucao DATE
)
LANGUAGE SQL
AS $$
UPDATE emprestimo 
SET devolvido = TRUE, data_devolucao = data_devolucao
WHERE id = id_emprestimo;
UPDATE livro 
SET disponivel = TRUE 
WHERE id = (SELECT id_livro FROM emprestimo WHERE id = id_emprestimo);
$$;

-- 4 Crie uma Procedure para excluir uma unidade, garantindo que os livros relacionados sejam removidos.

CREATE OR REPLACE PROCEDURE excluir_unidade(
    id_unidade INTEGER
)
LANGUAGE SQL
AS $$
DELETE FROM livro WHERE id_unidade = id_unidade;
DELETE FROM unidade WHERE id = id_unidade;
$$;

-- 5 Crie uma Procedure para adicionar uma nova categoria à tabela de categorias.

CREATE OR REPLACE PROCEDURE adicionar_categoria(
    nome_categoria VARCHAR, 
    descricao_categoria TEXT
)
LANGUAGE SQL
AS $$
INSERT INTO categoria (nome, descricao)
VALUES (nome_categoria, descricao_categoria);
$$;

-- 6 Crie uma Procedure para atualizar o telefone de um usuário, identificando-o pelo ID.

CREATE OR REPLACE PROCEDURE atualizar_telefone_usuario(
    id_usuario INTEGER, 
    novo_telefone VARCHAR
)
LANGUAGE SQL
AS $$
UPDATE usuario 
SET telefone = novo_telefone
WHERE id = id_usuario;
$$;

-- 7 Crie uma Procedure para transferir um livro de uma unidade para outra. 

CREATE OR REPLACE PROCEDURE transferir_livro(
    id_livro INTEGER, 
    nova_unidade INTEGER
)
LANGUAGE SQL
AS $$
UPDATE livro 
SET id_unidade = nova_unidade
WHERE id = id_livro;
$$;

-- 8 Crie uma Procedure para remover um bibliotecário, verificando se ele está associado a alguma unidade.

CREATE OR REPLACE PROCEDURE remover_bibliotecario(
    id_bibliotecario INTEGER
)
LANGUAGE SQL
AS $$
DELETE FROM bibliotecario 
WHERE id = id_bibliotecario;
$$;

-- 9 Crie uma Procedure para atualizar a categoria de um livro, identidicando-o pelo ID.

CREATE OR REPLACE PROCEDURE atualizar_categoria_livro(
    id_livro INTEGER, 
    nova_categoria INTEGER
)
LANGUAGE SQL
AS $$
UPDATE livro 
SET id_categoria = nova_categoria
WHERE id = id_livro;
$$;

-- 10 Crie uma Procedure para adicionar um novo usuário ao banco de dados, passando os dados necessários como parâmetros.

CREATE OR REPLACE PROCEDURE adicionar_usuario(
    nome_usuario VARCHAR, 
    email_usuario VARCHAR, 
    telefone_usuario VARCHAR, 
    endereco_usuario TEXT, 
    data_cadastro DATE
)
LANGUAGE SQL
AS $$
INSERT INTO usuario (nome, email, telefone, endereco, data_cadastro)
VALUES (nome_usuario, email_usuario, telefone_usuario, endereco_usuario, data_cadastro);
$$;