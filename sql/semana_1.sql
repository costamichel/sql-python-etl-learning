-- Semana 1

WITH pedidos_por_cliente AS (
    SELECT 
        cliente_id,
        COUNT(*) AS total_pedidos
    FROM etl_course.pedidos
    GROUP BY cliente_id
)
SELECT c.id, c.nome, total_pedidos
FROM pedidos_por_cliente p
JOIN etl_course.clientes c ON c.id = p.cliente_id
WHERE total_pedidos > 2;

-- STOP HERE