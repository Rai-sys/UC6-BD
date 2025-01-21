-- PRIMEIRO VIEW
CREATE VIEW livros_com_autores_e_categorias AS
SELECT
   livro.id AS id_livro,
   livro.titulo,
   autor.nome AS autor_nome,
   categoria.nome AS categoria_nome
FROM
   livro
JOIN autor ON livro.id_autor = autor.id
JOIN categoria ON livro.id_categoria = categoria.id;

-- SEGUNDO VIEW
select * from livro
CREATE VIEW livros_disponiveis_titulo_unidade_categoria AS
SELECT 
   livro.id,
   livro.titulo,
   livro.disponivel,
   unidade.nome AS id_unidade,
   categoria.nome AS id_categoria
FROM livro
JOIN unidade ON livro.id_unidade = unidade.id
JOIN categoria ON livro.id_categoria = categoria.id
WHERE livro.disponivel = true;

-- TERCEIRO VIEW
CREATE VIEW usuario_e_total_emprestimo AS
SELECT
   usuario.nome,
COUNT
   (emprestimo.id) AS total_emprestimo
FROM usuario
JOIN emprestimo ON emprestimo.id_usuario = usuario.id
GROUP BY usuario.nome;

-- QUARTA VIEW
select * from emprestimo
CREATE VIEW emprestimos_atrasados AS
SELECT
   usuario.nome,
   emprestimo.devolvido,
   livro.titulo
FROM emprestimo
JOIN usuario ON emprestimo.id_usuario = usuario.id
JOIN livro ON emprestimo.id_livro = livro.id
WHERE emprestimo.devolvido = false;

-- QUINTA VIEW
select * from unidade
select * from livro
CREATE VIEW unidade_total_livros_disponiveis AS
SELECT
   unidade.nome,
COUNT (livro.id) AS total_livro_disponivel
FROM livro
JOIN unidade ON livro.id_unidade = unidade.id
GROUP BY unidade.nome;

-- SEXTA VIEW
CREATE VIEW autores_total_livros_publicados AS
SELECT
   autor.nome,
COUNT
   (livro.id) AS total_publicado
FROM livro
JOIN autor ON livro.id_autor = autor.id
GROUP BY autor.nome;

-- SETIMA VIEW
select * from emprestimo
CREATE VIEW emprestimo_status AS
SELECT 
   id,
   devolvido AS status_devolucao
FROM emprestimo
ORDER BY id;

-- OITAVA VIEW
CREATE VIEW