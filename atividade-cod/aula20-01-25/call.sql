-- Tabela categoria
CALL public.inserir_nova_categoria(
	'Comédia Romântica',
	'Comédia romântica é um gênero que combina humor e romance, explorando relacionamentos com leveza e finais felizes.'
);

-- Tabela autor
CALL public.inserir_novo_ator(
	'Paulo Freire',
	'Brasileiro',
	'1956-05-20'
);

-- Tabela usuario
CALL public.update_nome_usuario(
	2,
	'Júlia Souza'
);

-- Tabela livro
CALL public.deletar_livro(
	111
);