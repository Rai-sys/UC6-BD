-- TABELA DE CLIENTES
CREATE TABLE Clientes (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  telefone VARCHAR(20) UNIQUE NOT NULL,
  data_cadastro DATE NOT NULL 
);

-- TABELA DE SERVIÇOS
CREATE TABLE Servicos (
  id SERIAL PRIMARY KEY ,
  nome VARCHAR(100) NOT NULL,
  descricao TEXT NOT NULL,
  preco DECIMAL(10,2) NOT NULL CHECK (preco > 0),
  tipo_servico VARCHAR(50) NOT NULL CHECK (tipo_servico in ('consultoria', 'suporte', 'manutencao'))
);

-- TABELA DE TECNICOS
CREATE TABLE Tecnicos (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  especialidade VARCHAR(50) NOT NULL,
  data_contratacao DATE NOT NULL
);

-- TABELA DE CHAMADOS
CREATE TABLE Chamados (
  id SERIAL PRIMARY KEY,
  cliente_id INT,
  tecnico_id INT,
  servico_id INT,
  data_chamado DATE NOT NULL,
  status VARCHAR(20) NOT NULL CHECK (status in ('pendente', 'em andamento', 'finalizado')),
  descricao TEXT NOT NULL
);

-- TABELA DE PAGAMENTOS
CREATE TABLE Pagamentos (
  id SERIAL PRIMARY KEY,
  cliente_id INT,
  chamado_id INT,
  valor_pago DECIMAL(10,2) NOT NULL CHECK (valor_pago > 0),
  data_pagamento DATE NOT NULL,
  forma_pagamento VARCHAR(50) NOT NULL CHECK (forma_pagamento in ('cartão de crédito', 'transferencia bancaria'))
);

-- CONSTRAINT DAS TABELAS
ALTER TABLE Chamados ADD CONSTRAINT fk_cliente FOREIGN KEY (cliente_id) REFERENCES Clientes(id) ON DELETE CASCADE;
ALTER TABLE Chamados ADD CONSTRAINT fk_tecnico FOREIGN KEY (tecnico_id) REFERENCES Tecnicos(id) ON DELETE CASCADE;
ALTER TABLE Chamados ADD CONSTRAINT fk_servico FOREIGN KEY (servico_id) REFERENCES Servicos(id) ON DELETE CASCADE;
ALTER TABLE Pagamentos ADD CONSTRAINT fk_cliente_pagamento FOREIGN KEY (cliente_id) REFERENCES Clientes(id) ON DELETE CASCADE;
ALTER TABLE Pagamentos ADD CONSTRAINT fk_chamado_pagamento FOREIGN KEY (chamado_id) REFERENCES Chamados(id) ON DELETE CASCADE;

-- COLOCANDO DADOS
INSERT INTO Clientes (id,nome, email, telefone, data_cadastro)
VALUES
(1,'João Silva', 'joao@email.com', '(11) 98765-4321', '2023-01-15'),
(2,'Maria Oliveira', 'maria@email.com', '(21) 99654-3210', '2023-02-20'),
(3,'Pedro Souza', 'pedro@email.com', '(31) 99765-1234', '2023-03-10'),
(4,'Ana Costa', 'ana@email.com', '(41) 98888-9999', '2023-04-25'),
(5,'Lucas Almeida', 'lucas@email.com', '(61) 99123-4567', '2023-05-30');
SELECT * FROM Clientes;

INSERT INTO Servicos (id, nome, descricao, preco, tipo_servico)
VALUES
(1,'Consultoria em TI', 'Consultoria especializada em infraestrutura de TI', '500.00', 'consultoria'),
(2, 'Manutenção de Equipamentos', 'Manutenção preventiva e corretiva de equipamentos', '300.00', 'manutencao'),
(3, 'Suporte Técnico', 'Suporte remoto e presencial para empresas', '200.00', 'suporte');
SELECT * FROM Servicos;

INSERT INTO Tecnicos (id,nome, especialidade, data_contratacao)
VALUES
(1, 'Carlos Oliveira', 'Consultoria TI', '2022-10-10'),
(2, 'Fernanda Souza', 'Manutenção', '2021-06-15'),
(3, 'Roberto Costa', 'Suporte Técnico', '2020-08-20');
SELECT * FROM Tecnicos;

INSERT INTO Chamados (cliente_id, tecnico_id, servico_id, data_chamado, status, descricao)
VALUES
(1, 1, 1, '2023-06-01', 'pendente', 'Fiação da casa queimada'),
(2, 2, 2, '2023-07-10', 'em andamento', 'Vazamento na tubulação'),
(3, 3, 2, '2023-08-05', 'finalizado', 'Reparação no ar-condicionado'),
(4, 1, 3, '2023-09-20', 'pendente', 'Manutenção no servidor'),
(5, 2, 3, '2023-10-15', 'finalizado', 'Suporte para software');
SELECT * FROM Chamados;

INSERT INTO Pagamentos (cliente_id, chamado_id, valor_pago, data_pagamento, forma_pagamento)
VALUES
(1, 1, '350.00', '2023-06-15', 'transferencia bancaria'), (2, 2, '450.00', '2023-07-15', 'cartão de crédito'),
(3, 3, '600.00', '2023-08-10', 'cartão de crédito'), (4, 4, '300.00', '2023-09-25', 'transferencia bancaria');
SELECT * FROM Pagamentos;

-- 4. LISTE O NOME E E-MAIL DE TODOS OS CLIENTES CADASTRADOS
SELECT nome, email FROM Clientes;

-- 5. RECUPERE OS NOMES DOS SERVIÇOS DISPONÍVEIS E SEUS RESPECTIVOS PREÇOS.
SELECT nome, preco FROM Servicos;

-- 6. EXIBA OS NOMES E ESPECIALIDADES DE TODOS OS TÉCNICOS.
SELECT nome, especialidade FROM Tecnicos;

-- 7. MOSTRE A DESCRIÇÃO E O STATUS DE TODOS OS CHAMADOS REGISTRADOS.
SELECT descricao, status FROM Chamados;

-- 8. LISTE OS VALORES PAGOS E AS DATAS DE PAGAMENTO DE TODOS OS REGISTROS NA TABELA DE PAGAMENTOS.
SELECT valor_pago, data_pagamento FROM Pagamentos;

-- 9. LISTE OS NOMES DOS CLIENTES E AS DESCRIÇÕES DE SEUS CHAMADOS QUE ESTÃO COM O STATUS "EM ANDAMENTO".
SELECT Clientes.nome, Chamados.descricao
FROM Clientes JOIN Chamados
ON Clientes.id = Chamados.cliente_id
WHERE Chamados.status = 'em andamento';

-- 10. RECUPERE OS NOMES DOS TÉCNICOS QUE REALIZARAM SERVIÇOS COM O TIPO "MANUTENÇÃO"
SELECT Tecnicos.nome, Servicos.tipo_servico
FROM Tecnicos JOIN Servicos
ON Servicos.id = Tecnicos.id
WHERE tipo_servico = 'manutencao';

-- 11. MOSTRE OS NOMES DOS CLIENTES E O VALOR TOTAL PAGO POR CADA UM DELES.
SELECT Clientes.nome, Pagamentos.valor_pago
FROM Clientes JOIN Pagamentos
ON Pagamentos.id = Clientes.id

-- 12. LISTE OS CLIENTES E OS SERVIÇOS QUE ELES SOLICITARAM, INCLUINDO A DESCRIÇÃO DO SERVIÇO.