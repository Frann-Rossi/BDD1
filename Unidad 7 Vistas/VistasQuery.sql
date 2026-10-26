-- =======================================================
-- EJERCICIO 1
create  view v_productos_tecnologia  as
select
	p.id_producto,
	p.nombre,
	p.precio
from
	productos as p
where
	p.categoria= 'Tecnologia';

select 
	*
from
	v_productos_tecnologia;
-- =======================================================

-- =======================================================
-- EJERCICIO 2
select
	vt.nombre,
    vt.precio
from
	v_productos_tecnologia as vt
where
	vt.precio > 10000
order by
    vt.precio desc;
-- =======================================================

-- =======================================================
-- EJERCICIO 3
create view v_ventas_clientes as
select
	v.id_venta,
    v.fecha,
    c.id_cliente,
    c.nombre as cliente, 
    c.ciudad
from
	ventas as v
join
	clientes as c
	on v.id_cliente = c.id_cliente;
    
select
	*
from
	v_ventas_clientes as vc
where
	vc.ciudad = 'Mar del Plata';
-- =======================================================

-- =======================================================
-- EJERCICIO 4
create view v_resumen_categorias as
select
	p.categoria,
    count(*) as cantidad_productos,
    avg(p.precio) as promedio
from
	productos as p
group by
	p.categoria;
    
select
	*
from
	v_resumen_categorias as vrc
where
	vrc.promedio > 30000;
-- =======================================================

-- =======================================================
-- EJERCICIO 5
create or replace view v_productos_tecnologia as
select
	p.id_producto,
    p.nombre,
    p.precio,
    p.categoria
from
	productos as p
where
	p.categoria= 'Tecnologia';
    
show create view v_productos_tecnologia;

-- =======================================================

-- =======================================================
-- EJERCICIO 6
create view v_totales_cliente as
select
	v.id_cliente,
    sum(d.cantidad * d.precio_unitario) as total_gastado
from
	ventas as v
join
	detalle_ventas as d
    on v.id_venta = d.id_venta
group by
	v.id_cliente;
    
select
	*
from
	v_totales_cliente as vtc
where
	vtc.total_gastado > 50000
-- =======================================================