-- *******************************************************
-- EJERCIO 1
select
	id_producto,
    nombre,
    categoria,
    precio
from
	productos 
where precio > (
	select
		avg(precio)
	from
		productos		
);
-- *******************************************************

-- *******************************************************
-- EJERCIO 2
select
	nombre,
    categoria,
    precio
from
	productos
where precio = (
	select
		max(precio) as precio_max
	from
		productos
);
-- *******************************************************

-- *******************************************************
-- EJERCIO 3
select
	id_cliente,
    nombre,
    ciudad
from
	clientes
where id_cliente in(
	select
		id_cliente
	from
		ventas
);
-- *******************************************************

-- *******************************************************
-- EJERCIO 4
select
	c.*
from
	clientes as c
where not exists(
	select
		1
	from
		ventas as v
	where
		c.id_cliente = v.id_cliente
);
-- *******************************************************

-- *******************************************************
-- EJERCIO 5
select
	*
from
	productos
where
	precio > any (
		select
			precio
		from
			productos
		where
			categoria = 'Libreria'
);

select
	*
from
	productos
where
	precio > some (
		select
			precio
		from
			productos
		where
			categoria = 'Libreria'
);

select
	*
from
	productos
where
	precio > all (
		select
			precio
		from
			productos
		where
			categoria = 'Libreria'
);
-- *******************************************************

-- *******************************************************
-- EJERCIO 6
select
	resumen.*
from (
	select
		v.id_cliente,
		sum(d.cantidad * d.precio_unitario) as importe_total
	from
		detalle_ventas as d
	join
		ventas as v
		on d.id_venta = v.id_venta
	group by
		v.id_cliente
) as resumen
where 
	resumen.importe_total > 50000;
-- *******************************************************

-- *******************************************************
-- EJERCIO 7
select
	p.id_producto,
    p.nombre,
    p.categoria
from
	productos as p
where exists(
    select 
		1
    from 
		detalle_ventas AS d
    where 
		p.id_producto = d.id_producto
);
-- *******************************************************

-- *******************************************************
-- EJERCIO 8
-- *******************************************************