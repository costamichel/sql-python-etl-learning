-- Exemplo CTE recursivo

-- Exemplo de dados para a tabela funcionarios
CREATE TABLE funcionarios (
    id INT PRIMARY KEY,
    nome VARCHAR(50),
    chefe_id INT
);

INSERT INTO funcionarios (id, nome, chefe_id) VALUES
(1, 'Alice', NULL),      -- CEO
(2, 'Bruno', 1),         -- Gerente, subordinado de Alice
(3, 'Carla', 2),         -- Analista, subordinada de Bruno
(4, 'Daniel', 2),        -- Analista, subordinado de Bruno
(5, 'Eva', 1),           -- Gerente, subordinada de Alice
(6, 'Felipe', 5);        -- Analista, subordinado de Eva

-- Exemplo de CTE recursiva para hierarquia de funcionários
WITH RECURSIVE hierarquia_funcionarios AS (
    -- Seleciona o chefe (nível mais alto)		-- âncora (termo não recursivo)
    SELECT id, nome, chefe_id, 1 AS nivel
    FROM funcionarios
    WHERE chefe_id IS NULL

    UNION all

    -- Seleciona subordinados, conectando cada funcionário ao seu chefe		-- clásula recursiva (termo recursivo)
    SELECT f.id, f.nome, f.chefe_id, h.nivel + 1
    FROM funcionarios f
    INNER JOIN hierarquia_funcionarios h ON f.chefe_id = h.id
)
SELECT * FROM hierarquia_funcionarios
ORDER BY nivel, nome;