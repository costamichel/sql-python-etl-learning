-- Semana 1

-- Clientes com mais de 2 pedidos
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

--Valor total de pedidos por cliente
with total_por_cliente as ( 
	select 
		cliente_id, 
		sum(valor) as valor_total 
	from etl_course.pedidos 
	group by cliente_id
)
select c.id, c.nome, valor_total 
from total_por_cliente t 
join etl_course.clientes c on c.id = t.cliente_id 
order by valor_total desc;

-- Clientes que mais gastaram - Top 3 
with total_por_cliente as ( 
	select 
		cliente_id, 
		sum(valor) as valor_total 
	from etl_course.pedidos 
	group by cliente_id
)
select c.id, c.nome, valor_total 
from total_por_cliente t 
join etl_course.clientes c on c.id = t.cliente_id 
order by valor_total desc
limit 3;

-- Primeiro pedido de cada cliente
select 
	p.id as pedido_id, 
	c.nome, 
	p.data_pedido,
	p.valor
from (
	select 	
		id, 
		cliente_id, 
		valor, 
		data_pedido, 
		row_number() over(partition by cliente_id order by data_pedido asc) as rn
	from etl_course.pedidos 
) p
join etl_course.clientes c on p.cliente_id = c.id
where p.rn = 1;

-- Intervalo de dias entre compras de um cliente 
select 
	c.nome as cliente, 
	p.data_pedido,
	p.valor,
	p.data_pedido - lag(p.data_pedido) over(partition by cliente_id order by data_pedido asc) as dias_desde_anterior, 
	lag(p.valor) over(partition by cliente_id order by data_pedido asc) as valor_compra_anterior
from etl_course.pedidos p 
join etl_course.clientes c on c.id = p.cliente_id 
order by c.nome, p.data_pedido 

-- STOP HERE