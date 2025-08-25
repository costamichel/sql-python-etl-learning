-- Criar schema
CREATE SCHEMA IF NOT EXISTS etl_course;

-- Tabela clientes
CREATE TABLE etl_course.clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    cidade VARCHAR(100)
);

-- Tabela pedidos
CREATE TABLE etl_course.pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES etl_course.clientes(id),
    valor NUMERIC(10,2) NOT NULL,
    data_pedido DATE NOT NULL
);

-- Dados fictícios, gerados pelo ChatGPT

-- Inserir clientes
INSERT INTO etl_course.clientes (nome, email, cidade) VALUES
('Ana Souza', 'ana.souza@email.com', 'São Paulo'),
('Bruno Lima', 'bruno.lima@email.com', 'Rio de Janeiro'),
('Carla Mendes', 'carla.mendes@email.com', 'Belo Horizonte'),
('Diego Ferreira', 'diego.ferreira@email.com', 'Porto Alegre'),
('Elisa Martins', 'elisa.martins@email.com', 'Curitiba');

-- Inserir pedidos
INSERT INTO etl_course.pedidos (cliente_id, valor, data_pedido) VALUES
(1, 250.00, '2023-01-10'),
(1, 320.00, '2023-03-15'),
(2, 150.00, '2023-02-05'),
(2, 180.00, '2023-04-12'),
(2, 210.00, '2023-06-20'),
(3, 500.00, '2023-01-25'),
(3, 700.00, '2023-02-28'),
(3, 350.00, '2023-05-10'),
(4, 100.00, '2023-03-02'),
(4, 120.00, '2023-05-18'),
(5, 900.00, '2023-02-14');