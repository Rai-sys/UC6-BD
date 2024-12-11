-- QUESTÃO 01
CREATE TABLE IF NOT EXISTS usuarios(
    id serial primary key,
    nome varchar(60) NOT NULL,
    email varchar(100) NOT NULL UNIQUE,
    senha varchar(16) NOT NULL,
    data_cadastro DATE DEFAULT(CURRENT_DATE)
);

-- QUESTÃO 02
CREATE TABLE IF NOT EXISTS categorias(
    id serial primary key,
    descricao varchar(150) NOT NULL UNIQUE
);

-- QUESTÃO 03
create table if not exists transacao( 
   id SERIAL primary key, 
   id_usuario int, 
   id_categoria int, 
   Tipo char(8) not null check (tipo in ('Receita'), ('Despesa')), 
   Valor numeric (10,2) not null, 
   Data DATE DEFAULT(CURRENT_DATE), 
   Descricao text,  
   Constraint fk_usuario foreign key (id_usuario) references usuarios(id) on delete cascade, 
   Constraint fk_categoria foreign key (id_categoria) references categoria(id) on delete cascade SET NULL
 );

-- QUESTÃO 04
 ALTER TABLE TRANSACAO ADD CONSTRAINT 
 BLOQUEAR_TRANSACAO_REPETIDA UNIQUE (id_usuario, descricao, data); 

-- QUESTÃO 05
ALTER TABLE TRANSACAO
 ADD CONSTRAINT BLOQUEAR_DESPESA CHECK tipo = 'Receita' OR (tipo = 'Despesa' AND VALOR <= 10000);

-- QUESTÃO 06
Insert into usuarios (id, nome, email, senha) 
Values (1, 'João', 'joao@gmail.com', '012345'), (2, 'Pedro', 'pedro@gmail.com', '1234567'), (3, 'Gabriel', 'gabriel@gmail.com', '23456789'); 

-- QUESTÃO 07
Insert into categorias (id, descricao) 
Values (1, 'Salário'), (2, 'Alimentação'), (3,'Transporte'), (4,'Educação'), (5,'Lazer'); 

-- QUESTÃO 08
Insert into transacao(id_usuario, id_categoria, tipo, valor, descricao) 
Values(1, 1, 'Receita', 3000, 'Salario mensal'), 
(1, 2, 'Despesa', 500, 'Alimentação'), 
(1, 2, 'Despesa', 1000, 'Carro');

-- QUESTÃO 09
SELECT transacao.*, usuarios FROM transacao JOIN
usuarios ON transacao.id_usuario = usuarios.id
WHERE usuarios.nome = 'João';

-- QUESTÃO 10
SELECT categorias.descricao, valor FROM transacao
JOIN categorias ON id_categoria = categoria.id
WHERE tipo = 'Despesa';

-- QUESTÃO 11
SELECT *
FROM transacao
order by transacao.valor descricao

-- QUESTÃO 12
SELECT SUM(valor) 
FROM transacao WHERE transacao.tipo = despesas;