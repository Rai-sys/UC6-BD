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

SELECT unidade.nome AS nome_unidade, COUNT (emprestimo.id) AS total_emprestimo
FROM emprestimo
JOIN livro ON emprestimo.id_livro = livro.id
JOIN unidade ON livro.id_unidade = unidade.id
GROUP BY unidade.nome;

-- 5. Quantidade total de usuários cadastrados no sistema.
SELECT COUNT (id) AS total_usuarios
FROM usuario
ORDER BY total_usuarios;

-- 6. Quantidade total de livros cadastrados no sistema
SELECT COUNT (id) AS total_livros
FROM livro
ORDER BY total_livros;

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
GROUP BY categoria.nome;

-- 11. Liste os livros cujos autores possuem nacionalidade americana.
SELECT livro.titulo, autor.nome
FROM livro
JOIN autor ON livro.id_autor = autor.id
WHERE autor.nacionalidade = 'Americana';

-- 12. Quantidade de livros emprestados atualmente (não devolvidos).
SELECT COUNT (id_livro) AS total_livros_emprestados
FROM emprestimo
WHERE emprestimo.devolvido = false;

-- 13. Unidades com mais de 60 livros cadastrados.
SELECT unidade.nome AS unidade, COUNT (livro.disponivel) AS total_livros
FROM livro
JOIN unidade ON livro.id_unidade = unidade.id
GROUP BY unidade.nome
HAVING COUNT (livro.disponivel) > 60
ORDER BY total_livros;

-- 14. Quantidade de livros por autor. Ordene pelo total e em ordem decrescente
SELECT autor.nome AS autor, COUNT (livro.disponivel) AS total_livros
FROM livro
JOIN autor ON livro.id_autor = autor.id
GROUP BY autor.nome
ORDER BY total_livros DESC;

-- 15. Categorias que possuem mais de 5 livros disponíveis atualmente.
SELECT categoria.nome AS categoria, COUNT (livro.disponivel) AS total_livros_disponiveis
FROM livro
JOIN categoria ON livro.id_categoria = categoria.id
GROUP BY categoria.nome
HAVING COUNT (livro.disponivel) > 5
ORDER BY total_livros_disponiveis;

-- 16. Unidades com pelo menos um empréstimo em aberto
select * from emprestimo

SELECT DISTINCT unidade.nome AS nome_unidade
FROM emprestimo
JOIN livro ON emprestimo.id_livro = livro.id
JOIN unidade ON livro.id_unidade = unidade.id
WHERE emprestimo.devolvido = false;