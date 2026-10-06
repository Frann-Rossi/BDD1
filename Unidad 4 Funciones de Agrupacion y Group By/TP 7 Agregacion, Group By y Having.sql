-- *******************************************************
-- EJERCICIO 1
select
	count(*) as cantidad_total_importe,
    sum(total) as suma_importe,
    avg(total) as promedio_importe,
    min(total) as menor_importe,
    max(total) as mayor_importe
from
	pedidos;
-- *******************************************************

-- *******************************************************
-- EJERCICIO 2
select
	count(*) as cantida_total_pedidos,
    count(observaciones) as obs_no_nulas,
    count(distinct id_cliente) as clientes_unicos
from
	pedidos;
-- *******************************************************

-- *******************************************************
-- EJERCICIO 3
select
	count(*) as cantidad_total,
    sum(total) as suma_pedidos,
    avg(total) as promedio_pedidos,
    max(total) as max_pedido,
    min(total) as min_pedido
from
	pedidos as p
where
	p.estado = 'Pagado';
-- *******************************************************

-- *******************************************************
-- EJERCICIO 4
select
	p.estado,
    count(*) as cantidad_pedidos,
    sum(total) as suma_pedidos,
    avg(total) as promedio_pedidos
from
	pedidos as p
group by
	p.estado
order by
	sum(total) desc;
-- *******************************************************


-- *******************************************************
-- EJERCICIO 5
select
	p.canal,
    p.estado,
    count(*) as cantidad_total_pedidos,
    sum(total) as suma_pedidos
from
	pedidos as p
group by
	p.canal,p.estado
order by
	p.canal,p.estado;
-- *******************************************************


-- *******************************************************
-- EJERCICIO 6
select
	c.id_cliente,
    c.nombre,
    count(*) as cantidad_total_pedidos,
    sum(total) as suma_pedidos,
    avg(total) as promedio_pedidos
from
	pedidos as p
join
	clientes as c
    on p.id_cliente = c.id_cliente
group by
	c.id_cliente,c.nombre
order by
	suma_pedidos desc;
-- *******************************************************


-- *******************************************************
-- EJERCICIO 7
select
	c.id_cliente,
    c.nombre,
	count(*) as cantidad_total_pedidos,
    coalesce(sum(p.total), 0) as suma_pedidos,
    coalesce(avg(p.total), 0) as promedio_pedidos
from
	pedidos as p
left join
	clientes as c
	on p.id_cliente = c.id_cliente
group by
	c.id_cliente,c.nombre
order by
	suma_pedidos desc;

-- *******************************************************
