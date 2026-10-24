-- ==================================================
-- EJERCICIO 1
with productos_costosos as (
	select
		p.id_producto, 
        p.nombre, 
		p.categoria, 
        p.precio
	from
		productos as p
	where
		p.precio >= 20000
)

select
	p.id_producto,
    p.nombre,
    p.categoria,
	p.precio
from
	productos_costosos as p
order by
	p.precio desc;
-- ==================================================

-- ==================================================
-- EJERCICIO 2
with resumen_categorias as (
	select
		p.categoria,
        count(*) as cantidad_productos,
        avg(p.precio) as precio_promedio
	from
		productos as p
	group by
		p.categoria
)

select
	r.categoria,
    r.cantidad_productos,
    r.precio_promedio
from
	resumen_categorias as r
where
	r.precio_promedio > 30000
order by
    r.precio_promedio desc;
-- ==================================================

-- ==================================================
-- EJERCICIO 3
with promedios_categoria as(
	select
		pr.categoria,
		avg(pr.precio) as promedio_cat
	from
		productos as pr
	group by
		pr.categoria
)

select
	p.nombre,
    p.categoria,
    p.precio,
    pr.promedio_cat
from
	productos as p
join
	promedios_categoria as pr
    on p.categoria = pr.categoria;
-- ==================================================

-- ==================================================
-- EJERCICIO 4
with ventas_por_cliente as (
	select
		v.id_cliente,
		count(v.id_venta) as cantidad_ventas
	from
		ventas as v
	group by
		v.id_cliente
)

select
	c.nombre,
    vc.cantidad_ventas
from
	clientes as c
join 
	ventas_por_cliente as vc
	on c.id_cliente = vc.id_cliente;	
-- ==================================================

-- ==================================================
-- EJERCICIO 5
with promedios_categorias as(
	select
		p.categoria,
        avg(p.precio) as promedio
	from
		productos as p
	group by
		p.categoria
)

select
	p.nombre,
    p.categoria,
    p.precio,
    pc.promedio
from
	productos as p
join
	promedios_categorias as pc
	on p.categoria = pc.categoria
where
	p.precio > pc.promedio;
-- ==================================================

-- ==================================================
-- EJERCICIO 6
with clientes_mdp as(
	select
		c.id_cliente,
		c.nombre,
        c.ciudad
	from
		clientes as c
	where
		c.ciudad = 'Mar del Plata'
),
ventas_por_cliente as(
	select
		v.id_cliente,
		count(*) as cantidad_ventas
	from
		ventas as v
	group by
		v.id_cliente
)
select
	cm.nombre,
    cm.ciudad,
    coalesce(vc.cantidad_ventas,0) as cantidad_ventas
from
	clientes_mdp as cm
left join
	ventas_por_cliente as vc
    on cm.id_cliente = vc.id_cliente
-- ==================================================

-- ==================================================
-- EJERCICIO 7
-- ==================================================