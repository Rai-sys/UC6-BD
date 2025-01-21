----- CRIANDO FUNÇÃO PARA CALCULAR TOTAL DE LIVROS ------------
CREATE OR REPLACE FUNCTION total_livros() RETURNS INT AS $$
declare   --  <- declarar função
  total_livros INT;  --  <- chamando função junto com o tipo (int)
begin
  SELECT COUNT(id) FROM livro;
  RETURN total_livros;  --  <- retornando a função
end;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION total_livros() RETURNS INT AS $$  --  <- forma mais simplificada
begin
  RETURN (SELECT COUNT(*) AS total_livros FROM livro);
end;
$$ LANGUAGE plpgsql;

----- CONTAGEM TOTAL DE USUARIOS -------------------------------
select * from usuario

CREATE OR REPLACE FUNCTION total_usuarios() RETURNS INT AS $$
begin
   RETURN (SELECT COUNT(id) AS total_usuarios FROM usuario);
end;
$$ LANGUAGE plpgsql;


----- RETORNANDO TUDO DA TABELA USUARIO -----------------------
CREATE OR REPLACE FUNCTION listar_usuarios()
RETURNS TABLE(id_user INTEGER, nome_user VARCHAR, email_user VARCHAR, telefone_user VARCHAR, endereco_user TEXT, data_cadastro_user TIMESTAMP)
AS $$
begin
   RETURN QUERY  -- retorno de vários valores
   SELECT usuario.id, usuario.nome, usuario.email, usuario.telefone, usuario.endereco, usuario.data_cadastro
   FROM usuario;
end;
$$ LANGUAGE plpgsql;

select nome_user from listar_usuarios();  -- retornando apenas os emails dos usuarios

----- LISTAR USUARIO POR ID --------------------------------
CREATE OR REPLACE FUNCTION listar_usuarios_por_id(id_user INTEGER)
RETURNS TABLE(id_usuario INTEGER, nome_user VARCHAR, email_user VARCHAR, telefone_user VARCHAR, endereco_user TEXT, data_cadastro_user TIMESTAMP)
AS $$
begin
   RETURN QUERY  -- retorno de vários valores
   SELECT *
   FROM usuario
   WHERE id = id_user;  -- não pode ser igual ao que está no return table
end;
$$ LANGUAGE plpgsql;

select * from listar_usuarios_por_id(2) -- retornando todas as informações do usuario 2

----- RETORNAR O LIVRO PELO ID ----------------------------
CREATE OR REPLACE FUNCTION listar_livro_por_id(id_book INTEGER) 
RETURNS TABLE (id_livro INTEGER, titulo_livro VARCHAR, id_autor_livro INTEGER, id_categoria_livro INTEGER, ano_publicacao_livro INTEGER,
numero_paginas_livro INTEGER, disponivel_livro BOOLEAN, id_unidade_livro INTEGER)
AS $$
begin
   RETURN QUERY
   SELECT *
   FROM livro
   WHERE id = id_book;
end;
$$ LANGUAGE plpgsql;

select * from listar_livro_por_id (110);  -- retornando dados do livro do id 110
