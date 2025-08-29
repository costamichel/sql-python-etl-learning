-- Exemplos de funções de janela (window functions) no PostgreSQL
-- Tabelas usadas: clientes, pedidos

-- 1. ROW_NUMBER(): numera as linhas dentro de cada cliente
SELECT cliente_id, id, ROW_NUMBER() OVER (PARTITION BY cliente_id ORDER BY data_pedido) AS numero_pedido
FROM pedidos;
-- Retorna o número sequencial de cada pedido por cliente

-- 2. RANK(): ranking dos valores dos pedidos por cliente
SELECT cliente_id, id, valor, RANK() OVER (PARTITION BY cliente_id ORDER BY valor DESC) AS rank_valor
FROM pedidos;
-- Retorna o ranking dos pedidos por valor, pulando posições em caso de empate

-- 3. DENSE_RANK(): ranking dos valores dos pedidos por cliente, sem pular posições
SELECT cliente_id, id, valor, DENSE_RANK() OVER (PARTITION BY cliente_id ORDER BY valor DESC) AS dense_rank_valor
FROM pedidos;
-- Retorna o ranking dos pedidos por valor, sem pular posições em caso de empate

-- 4. NTILE(4): divide os pedidos em quartis por cliente
SELECT cliente_id, id, valor, NTILE(4) OVER (PARTITION BY cliente_id ORDER BY valor) AS quartil
FROM pedidos;
-- Retorna o quartil de cada pedido por cliente

-- 5. SUM(): soma acumulada dos valores dos pedidos por cliente
SELECT cliente_id, id, valor, SUM(valor) OVER (PARTITION BY cliente_id ORDER BY data_pedido) AS soma_acumulada
FROM pedidos;
-- Retorna a soma acumulada dos valores dos pedidos por cliente

-- 6. AVG(): média acumulada dos valores dos pedidos por cliente
SELECT cliente_id, id, valor, AVG(valor) OVER (PARTITION BY cliente_id ORDER BY data_pedido) AS media_acumulada
FROM pedidos;
-- Retorna a média acumulada dos valores dos pedidos por cliente

-- 7. MIN() e MAX(): menor e maior valor de pedido por cliente
SELECT cliente_id, id, valor,
       MIN(valor) OVER (PARTITION BY cliente_id) AS menor_valor,
       MAX(valor) OVER (PARTITION BY cliente_id) AS maior_valor
FROM pedidos;
-- Retorna o menor e o maior valor de pedido para cada cliente

-- 8. COUNT(): contagem acumulada de pedidos por cliente
SELECT cliente_id, id, COUNT(*) OVER (PARTITION BY cliente_id ORDER BY data_pedido) AS contagem_acumulada
FROM pedidos;
-- Retorna a contagem acumulada de pedidos por cliente

-- 9. FIRST_VALUE() e LAST_VALUE(): primeiro e último valor de pedido por cliente
SELECT cliente_id, id, valor,
       FIRST_VALUE(valor) OVER (PARTITION BY cliente_id ORDER BY data_pedido) AS primeiro_valor,
       LAST_VALUE(valor) OVER (PARTITION BY cliente_id ORDER BY data_pedido ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ultimo_valor,
       LAST_VALUE(valor) OVER (PARTITION BY cliente_id ORDER BY data_pedido) AS valor_atual
FROM pedidos;
-- Retorna o primeiro e o último valor de pedido para cada cliente

-- 10. NTH_VALUE(): terceiro valor de pedido por cliente
SELECT cliente_id, id, valor,
       NTH_VALUE(valor, 3) OVER (PARTITION BY cliente_id ORDER BY data_pedido ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS terceiro_valor,
       NTH_VALUE(valor, 3) OVER (PARTITION BY cliente_id ORDER BY data_pedido ROWS BETWEEN UNBOUNDED PRECEDING AND unbounded following) AS terceiro_valor_total
FROM pedidos;
-- Retorna o terceiro valor de pedido para cada cliente (se existir)

-- 11. LAG() e LEAD(): valor anterior e próximo de cada pedido
SELECT cliente_id, id, valor,
       LAG(valor) OVER (PARTITION BY cliente_id ORDER BY data_pedido) AS valor_anterior,
       LEAD(valor) OVER (PARTITION BY cliente_id ORDER BY data_pedido) AS valor_proximo
FROM pedidos;
-- Retorna o valor do pedido anterior e do próximo para cada cliente

-- 12. CUME_DIST(): distribuição acumulada dos valores dos pedidos
SELECT cliente_id, id, valor,
       CUME_DIST() OVER (PARTITION BY cliente_id ORDER BY valor) AS dist_acumulada
FROM pedidos;
-- Retorna a posição relativa do pedido dentro da distribuição dos valores

-- 13. PERCENT_RANK(): percentil do valor do pedido
SELECT cliente_id, id, valor,
       PERCENT_RANK() OVER (PARTITION BY cliente_id ORDER BY valor) AS percentil
FROM pedidos;
-- Retorna o percentil do valor do pedido por cliente
