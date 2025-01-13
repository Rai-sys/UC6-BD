-- 1. Quantidade de bibliotecários responsáveis por cada unidade.
select * from autor
select * from bibliotecario
select * from categoria
select * from emprestimo
select * from livro
select * from unidade
select * from usuario

SELECT unidade.nome AS unidade, COUNT (bibliotecario.id) AS total_bibliotecarios
FROM bibliotecario
JOIN unidade ON bibliotecario.id_unidade = unidade.id
GROUP BY unidade.nome
ORDER BY total_bibliotecarios;

-- 2. Quantidade de livros disponíveis em cada unidade.
SELECT unidade.nome AS unidade, COUNT (livro.disponivel) AS total_livros
FROM livro
JOIN unidade ON livro.id_unidade = unidade.id
GROUP BY unidade.nome
ORDER BY total_livros;

-- 3. Quantidade de empréstimos realizados em cada unidade
select * from emprestimo
select * from unidade

SELECT id, SUM (emprestimo.data_emprestimo) AS aaa
FROM emprestimo
JOIN unidade
GROUP BY id
ORDER  BY aaa

-- 5. Quantidade total de usuários cadastrados no sistema.
SELECT COUNT (id) AS total_usuarios
FROM usuario
ORDER BY total_usuarios

-- 6. Quantidade total de livros cadastrados no sistema
SELECT COUNT (id) AS total_livros
FROM livro
ORDER BY total_livros

-- 7. Quantidade de livros emprestados por cada usuário. Ordene pelo total encontrado e em
-- ordem decrescente. 
SELECT usuario.nome AS usuario, COUNT (id_livro) AS total_emprestimo
FROM emprestimo
JOIN usuario ON emprestimo.id_usuario = usuario.id
GROUP BY usuario.nome
ORDER BY total_emprestimo DESC;

-- 8. Quantidade de empréstimos realizados por mês. Use EXTRACT(MONTH FROM
-- data_emprestimo) para extrair o mês.
SELECT EXTRACT(MONTH FROM data_emprestimo) AS mes, COUNT (id) AS total_emprestimo
FROM emprestimo
GROUP BY mes
ORDER BY mes;

-- 9. Média do número de páginas dos livros cadastrados no sistema.
SELECT round(AVG (numero_paginas), 2) AS media_paginas
FROM livro;

-- 10. Quantidade de livros cadastrados em cada categoria
SELECT categoria.nome AS categoria, COUNT (livro.disponivel) AS total_livros
FROM livro
JOIN categoria ON livro.id_categoria = categoria.id
GROUP BY categoria.nome

-- 11. Liste os livros cujos autores possuem nacionalidade americana.
select * from autor
SELECT titulo, COUNT (nome) AS nome
FROM livro
JOIN autor 
HAVING COUNT (nome) ON nacionalidade = 'Americana'
GROUP BY titulo