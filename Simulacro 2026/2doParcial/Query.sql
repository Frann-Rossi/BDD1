-- ==================================================
-- EJERCICIO 1
select
	p.id_producto,
    p.nombre,
    p.precio,
    p.activo
from
	productos as p
where
	p.activo = 1
    and
	p.id_categoria in (
		select
			p2.id_categoria
		from
			productos as p2
		where
			p2.activo = 1
		group by
			p2.id_categoria
		having
			count(p2.id_categoria) >= 2
    );
-- ==================================================

-- ==================================================
-- EJERCICIO 2
select
	c.id_cliente,
    c.nombre,
    c.ciudad,
    (
		select
			count(*)
		from
			ventas as v
		where
			v.id_cliente = c.id_cliente
            and
            year(v.fecha) = 2026
	)as cantidad_ventas
from
	clientes as c
order by
	cantidad_ventas desc;
-- ==================================================

-- ==================================================
-- EJERCICIO 3
with unidad_vendida_cat as(
	select
		c.id_categoria,
        c.nombre,
        sum(dv.cantidad) as unidades_vendidas
	from
		categorias as c
	join
		productos as p
        on p.id_categoria = c.id_categoria
	join
		detalle_ventas as dv
		on dv.id_producto = p.id_producto
	group by
		c.id_categoria,
        c.nombre
)

select
	uvc.nombre,
    uvc.unidades_vendidas
from
	unidad_vendida_cat as uvc
where
	uvc.unidades_vendidas >= 5
order by
	uvc.unidades_vendidas desc;
-- ==================================================

-- ==================================================
-- EJERCICIO 4
with total_unidades as(
	select
		dv.id_venta,
        sum(dv.cantidad) as unidades_totales
	from
		detalle_ventas as dv
	group by
		dv.id_venta
),
ventas_cantidad_total as (
	select
		tu.id_venta,
        tu.unidades_totales
	from
		total_unidades as tu
	where
		tu.unidades_totales >= 3
)

select
	vct.id_venta,
    c.nombre,
    vct.unidades_totales
from
	ventas_cantidad_total as vct
join
	ventas as v
    on v.id_venta = vct.id_venta
join
	clientes as c
    on c.id_cliente = v.id_cliente
order by
	vct.unidades_totales desc;
-- ==================================================

-- ==================================================
-- EJERCICIO 5
create view v_personas_comerciales as
select
	c.nombre,
    c.ciudad,
    'CLIENTE' as origen
from
	clientes as c
    
union all

select
	v.nombre,
    s.ciudad,
    'VENDEDOR' as origen
from
	vendedores as v
join
	sucursales as s
	on v.id_sucursal = s.id_sucursal;
    
select
	 *
from
	v_personas_comerciales as vpc
where
	vpc.ciudad = 'Mar del Plata'
order by
	vpc.nombre;
-- ==================================================

-- ==================================================
-- EJERCICIO 6
create view v_productos_movimiento as
select
	p.id_producto,
    p.nombre as producto,
    c.nombre as categoria,
    coalesce(sum(dv.cantidad),0) as cantidad_vendida
from
	productos as p
join
	categorias as c
	on c.id_categoria = p.id_categoria
left join
	detalle_ventas as dv
    on dv.id_producto = p.id_producto
group by
	p.id_producto,
    p.nombre,
    c.nombre;
    
select
	*
from
	v_productos_movimiento as vpm
order by
	vpm.cantidad_vendida desc,
    vpm.producto;
-- ==================================================

-- ==================================================
-- EJERCICIO 7
with cantidad_registrada_max as (
	select
		p.id_producto,
        max(dv.cantidad) as mayor_cantidad
	from
		productos as p
	join
		detalle_ventas as dv
		on dv.id_producto = p.id_producto
	group by
		p.id_producto
)

select
	*
from
	cantidad_registrada_max as crm
where
	crm.mayor_cantidad = (
		select
			max(crm2.mayor_cantidad)
		from
			cantidad_registrada_max as crm2
    );
-- ==================================================

-- ==================================================
-- EJERCICIO 8
select
	t.categoria,
    t.productos_con_movimiento
from
	(
		select
			vpm.categoria,
            count(*) as productos_con_movimiento
		from
			v_productos_movimiento as vpm
		where
			vpm.cantidad_vendida > 0
		group by
			vpm.categoria
    )t
where
	t.productos_con_movimiento > 1;
-- ==================================================

-- ==================================================
-- EJERCICIO 9
with productos_ventas_registradas as (
	select
		vpm.producto,
        vpm.categoria,
		vpm.cantidad_vendida
	from
		v_productos_movimiento as vpm
	where
		vpm.cantidad_vendida > 0
)

select
	*
from
	productos_ventas_registradas as pvr
where
	pvr.cantidad_vendida > any (
		select
			pvr2.cantidad_vendida
		from
			productos_ventas_registradas as pvr2
    )
-- ==================================================