-- 1. Crie uma view para listar todos os livros com seus autores e categorias.

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

-- 2. Crie uma view que exiba os livros disponíveis com título, unidade e categoria.

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

-- 3. Crie uma view que mostre os empréstimos atrasados com os nomes dos usuários e
-- os títulos dos 
CREATE VIEW usuario_e_total_emprestimo AS
SELECT
   usuario.nome,
COUNT
   (emprestimo.id) AS total_emprestimo
FROM usuario
JOIN emprestimo ON emprestimo.id_usuario = usuario.id
GROUP BY usuario.nome;

-- 4. Crie uma view que mostre os empréstimos atrasados com os nomes dos usuários e
-- os títulos dos livros

CREATE VIEW emprestimos_atrasados AS
SELECT
   usuario.nome,
   emprestimo.devolvido,
   livro.titulo
FROM emprestimo
JOIN usuario ON emprestimo.id_usuario = usuario.id
JOIN livro ON emprestimo.id_livro = livro.id
WHERE emprestimo.devolvido = false;

-- 5. Crie uma view para exibir o nome das unidades e o total de livros disponíveis em
-- cada uma.

CREATE VIEW unidade_total_livros_disponiveis AS
SELECT
   unidade.nome,
COUNT (livro.id) AS total_livro_disponivel
FROM livro
JOIN unidade ON livro.id_unidade = unidade.id
GROUP BY unidade.nome;

-- 6. Crie uma view que exiba todos os autores com o número total de livros publicados.

CREATE VIEW autores_total_livros_publicados AS
SELECT
   autor.nome,
COUNT
   (livro.id) AS total_publicado
FROM livro
JOIN autor ON livro.id_autor = autor.id
GROUP BY autor.nome;

-- 7. Crie uma view para listar todos os empréstimos com o status de devolução
-- (devolvido ou não).

CREATE VIEW emprestimo_status AS
SELECT 
   id,
   devolvido AS status_devolucao
FROM emprestimo
ORDER BY id;

-- 8. Crie uma view para listar os livros categorizados por ano de publicação, ordenados
-- do mais recente para o mais antigo.

CREATE VIEW livros_categorizados AS
SELECT
   titulo,
   ano_publicacao
FROM livro
ORDER BY ano_publicacao DESC;

-- 9. Crie uma view que mostre os bibliotecários e as unidades às quais estão associados.

CREATE VIEW bibliotecarios_e_unidades_associados AS
SELECT
   bibliotecario.nome,
   unidade.nome as unidade
FROM bibliotecario
JOIN unidade ON bibliotecario.id_unidade = unidade.id;

-- 10. Crie uma view para exibir os usuários que nunca realizaram empréstimos.

CREATE VIEW usuarios_sem_emprestimos AS
SELECT 
    usuario.nome, 
    usuario.email
FROM 
    usuario
JOIN emprestimo ON usuario.id = emprestimo.id_usuario
WHERE emprestimo.id IS NULL;