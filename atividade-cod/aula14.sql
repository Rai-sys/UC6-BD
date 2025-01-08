begin;
-- CRIANDO TABELA CLIENTE
CREATE TABLE cliente (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(60) NOT NULL,
  cpf CHAR(14) NOT NULL UNIQUE,
  email VARCHAR(130) UNIQUE,
  telefone CHAR(11),
  data_cadastro DATE DEFAULT CURRENT_DATE
);

-- CRIANDO TABELA PRODUTO
CREATE TABLE produto (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(30) NOT NULL,
  descricao TEXT,
  preco DECIMAL(10,2) NOT NULL,
  estoque_quantidade INT NOT NULL,
  data_cadastro DATE DEFAULT CURRENT_DATE NOT NULL,
  CONSTRAINT chk_preco CHECK (NOT preco < 0),
  CONSTRAINT chk_estoque_quantidade CHECK (NOT estoque_quantidade < 0)
);

-- CRIANDO TABELA FUNCIONARIO
CREATE TABLE funcionario (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(60) NOT NULL,
  cpf CHAR(14) NOT NULL UNIQUE,
  cargo VARCHAR(25) NOT NULL,
  data_admissao DATE NOT NULL,
  email VARCHAR(120) UNIQUE,
  salario DECIMAL(10,2) NOT NULL,
  CONSTRAINT chk_salario CHECK (NOT salario < 0)
);

-- CRIANDO TABELA VENDA
CREATE TABLE venda (
  id SERIAL PRIMARY KEY,
  data_venda DATE DEFAULT CURRENT_DATE,
  total_venda DECIMAL(10,2) NOT NULL,
  id_cliente SERIAL NOT NULL,
  id_funcionario SERIAL,
  CONSTRAINT chk_total_venda CHECK (NOT total_venda < 0),
  CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id),
  CONSTRAINT fk_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario(id) ON DELETE CASCADE
);

-- CRIANDO TABELA ITEM VENDA
CREATE TABLE item_venda (
  id SERIAL PRIMARY KEY,
  id_venda SERIAL,
  id_produto SERIAL,
  quantidade_item INT NOT NULL,
  preco_unitario DECIMAL(10,2) NOT NULL,
  subtotal DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_venda FOREIGN KEY (id_venda) REFERENCES venda(id) ON DELETE CASCADE,
  CONSTRAINT fk_produto FOREIGN KEY (id_produto) REFERENCES produto(id) ON DELETE CASCADE,
  CONSTRAINT chk_quantidade_item CHECK (quantidade_item > 0),
  CONSTRAINT chk_preco_unitario CHECK (NOT preco_unitario < 1),
  CONSTRAINT chk_subtotal CHECK (NOT subtotal < 0)
);

-- INSERÇAO DAS TABELAS
INSERT INTO cliente (id, nome, cpf, email, telefone, data_cadastro) 
VALUES (1, 'João Silva', '123.456.789-00', 'joao.silva@gmail.com', '11987654321', '2025-01-01'),
(2, 'Maria Oliveira', '987.654.321-00', 'maria.oliveira@gmail.com', '21987654321', '2025-01-02'),
(3, 'Carlos Pereira', '111.222.333-44', 'carlos.pereira@yahoo.com', '31987654321', '2025-01-03'),
(4, 'Ana Santos', '222.333.444-55', 'ana.santos@hotmail.com', '41987654321', '2025-01-04'),
(5, 'Paulo Costa', '333.444.555-66', 'paulo.costa@outlook.com', '51987654321', '2025-01-05');

INSERT INTO produto (id, nome, descricao, preco, estoque_quantidade, data_cadastro) 
VALUES (1, 'Notebook', 'Notebook de alta performance com 16GB de RAM e SSD de 512GB.', 4500.00, 10, '2025-01-01'),
(2, 'Smartphone', 'Smartphone Android com 128GB de armazenamento.', 2500.00, 50, '2025-01-02'),
(3, 'Headset Gamer', 'Fone de ouvido com microfone embutido e som estéreo.', 350.00, 100, '2025-01-03'),
(4, 'Monitor 4K', 'Monitor 28" com resolução 4K Ultra HD.', 1800.00, 25, '2025-01-04'),
(5, 'Teclado Mecânico', 'Teclado gamer com switches mecânicos RGB.', 650.00, 30, '2025-01-05');

INSERT INTO funcionario (id, nome, cpf, cargo, data_admissao, email, salario) 
VALUES (1, 'João Almeida', '123.456.789-00', 'Gerente', '2023-05-15', 'joao.almeida@empresa.com', 7500.00),
(2, 'Maria Silva', '987.654.321-00', 'Analista', '2022-03-20', 'maria.silva@empresa.com', 4800.00),
(3, 'Carlos Pereira', '111.222.333-44', 'Desenvolvedor', '2021-07-10', 'carlos.pereira@empresa.com', 5200.00),
(4, 'Ana Santos', '222.333.444-55', 'Assistente', '2024-01-02', 'ana.santos@empresa.com', 3000.00),
(5, 'Paulo Costa', '333.444.555-66', 'Coordenador', '2020-12-01', 'paulo.costa@empresa.com', 6200.00);

INSERT INTO venda (data_venda, total_venda, id_cliente, id_funcionario) 
VALUES ('2025-01-01', 4500.00, 1, 1),
('2025-01-02', 2500.00, 2, 2),
('2025-01-03', 350.00, 3, 3),
('2025-01-04', 1800.00, 4, 4),
('2025-01-05', 650.00, 5, 5);

INSERT INTO item_venda (id, id_venda, id_produto, quantidade_item, preco_unitario, subtotal) 
VALUES (1, 1, 1, 1, 4500.00, 4500.00),
(2, 2, 2, 1, 2500.00, 2500.00),
(3, 3, 3, 2, 175.00, 350.00),
(4, 4, 4, 1, 1800.00, 1800.00),
(5, 5, 5, 1, 650.00, 650.00);

SELECT * FROM cliente;
SELECT * FROM produto;
SELECT * FROM funcionario;
SELECT * FROM venda;
SELECT * FROM item_venda;

rollback;

-- QUESTÃO 01. Liste o total de vendas realizadas por cada cliente.
SELECT cliente.nome, COUNT(venda.id_cliente) AS total_vendas
FROM venda JOIN cliente ON venda.id = cliente.id
GROUP BY cliente.nome
ORDER BY cliente.nome ASC;

-- QUESTAO 02. Liste o total de vendas realizadas por cada funcionário.
SELECT funcionario.nome , COUNT(venda.id_funcionario) AS total_vendas_funcionarios
FROM venda JOIN funcionario ON venda.id_funcionario = funcionario.id
GROUP BY funcionario.nome
ORDER BY funcionario.nome ASC;

-- QUESTÃO 03. Liste a quantidade total de produtos vendidos por cada venda.
SELECT id_venda, SUM (quantidade_item) AS quantidade_item_total
FROM item_venda
GROUP BY id_venda;

-- QUESTÃO 05. Liste os clientes que realizaram mais de 5 compras.
SELECT cliente.nome, COUNT (venda.id_cliente)
FROM venda 
JOIN item_venda ON venda.id_cliente = item_venda.id_venda
JOIN cliente ON cliente.id = venda.id_cliente
GROUP BY cliente.nome
HAVING COUNT (venda.id_cliente) >= 1;

-- 6. Liste os produtos que possuem mais de 50 unidades em estoque.
select * from produto;

SELECT nome, estoque_quantidade
FROM produto
WHERE estoque_quantidade > 10;

-- 7. Liste os funcionários que participaram de mais de 10 vendas.
SELECT funcionario.nome, COUNT (venda.id_funcionario)
FROM venda
JOIN funcionario ON funcionario.id = venda.id_funcionario
GROUP BY funcionario.nome
HAVING COUNT (venda.id_funcionario) > 0;


-- 8. Liste os produtos cujo total vendido (quantidade) seja superior a 100
-- unidades.
SELECT produto.nome, SUM (item_venda.quantidade_item) AS total_produto
FROM item_venda
JOIN produto ON item_venda.id_produto = produto.id
GROUP BY produto.nome
HAVING SUM (item_venda.quantidade_item) > 0
ORDER BY total_produto DESC;

-- 9. Calcule o valor total das vendas de cada cliente.
select * from venda;

SELECT cliente.nome, SUM (venda.total_venda) AS total_venda
FROM venda
JOIN cliente ON cliente.id = venda.id_cliente
GROUP BY cliente.nome
ORDER BY cliente.nome DESC;

-- 10.Calcule o valor total das vendas realizadas por cada funcionário.
-- 11.Calcule o total de itens vendidos por venda.
-- 12.Calcule o total de produtos vendidos agrupados por categoria (se
-- adicionarmos uma coluna de categoria na tabela de produtos).
-- 13.Calcule o total arrecadado com vendas para cada cliente.
-- 14.Calcule o preço médio dos produtos em estoque.
-- 15.Calcule o preço médio dos produtos vendidos por venda.
-- 16.Calcule a média de salários dos funcionários.
-- 17.Calcule a média do total das vendas por funcionário.
-- 18.Conte quantas vendas foram realizadas por cliente.
-- 19.Conte quantas vendas cada funcionário participou.
-- 20.Conte quantos produtos estão cadastrados no banco.
-- 21.Conte quantas vendas foram realizadas em cada dia.
-- 22.Liste os clientes que realizaram mais de 5 compras, ordenados pelo
-- total de vendas.
-- 23.Liste os produtos mais vendidos (em quantidade) cujo total vendido
-- ultrapassa 50 unidades.
-- 24.Calcule a média de preço dos produtos vendidos em cada venda.
-- 25.Liste os funcionários que participaram de vendas cujo total médio é
-- superior a R$ 5.000,00.