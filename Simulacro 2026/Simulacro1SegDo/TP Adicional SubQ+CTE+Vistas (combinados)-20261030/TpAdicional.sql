-- ==================================================
-- EJERCIO 1
with cantidad_vendedores as(
	select
		v.id_cliente,
		count(distinct v.id_vendedor) as cantidad
	from
		ventas as v
	where
		year(v.fecha) = 2026
	group by
		v.id_cliente
)

select
	c.id_cliente,
    c.nombre,
    cv.cantidad
from
	clientes as c
join
	cantidad_vendedores as cv
    on c.id_cliente = cv.id_cliente
where
	cv.cantidad > 1;
-- ==================================================

-- ==================================================
-- EJERCIO 2
with importe_total as (
	select
		ven.id_sucursal,
		sum(dv.cantidad * dv.precio_unitario) as importe_total
	from
		detalle_ventas as dv
	join
		ventas as v
        on dv.id_venta = v.id_venta
	join
		vendedores as ven
		on ven.id_vendedor = v.id_vendedor
	group by
		ven.id_sucursal
)

select
	s.nombre,
    s.ciudad,
    it.importe_total
from
	sucursales as s
join
	importe_total as it
    on it.id_sucursal = s.id_sucursal
order by
	it.importe_total desc;
-- ==================================================

-- ==================================================
-- EJERCIO 3
with meses_por_producto as(
	select
		count(distinct month(v.fecha)) as meses_distintos,
        dv.id_producto
	from
		ventas as v
	join
		detalle_ventas as dv
		on dv.id_venta = v.id_venta
	where
		year(v.fecha) = 2026
	group by
		dv.id_producto
)

select
	p.id_producto,
    p.nombre,
    mpp.meses_distintos
from
	productos as p
join
	meses_por_producto as mpp
    on mpp.id_producto = p.id_producto
where
	mpp.meses_distintos >= 2;
-- ==================================================

-- ==================================================
-- EJERCIO 4
with importe_total_venta as(
	select
		dv.id_venta,
		sum(dv.cantidad * dv.precio_unitario) as importe_total
	from
		detalle_ventas as dv
	group by
		dv.id_venta
),
importe_por_vendedores as (
	select
		v.nombre,
        v.id_sucursal,
        sum(itv.importe_total) as total_vendido
	from
		vendedores as v
	join
		ventas as ven
        on ven.id_vendedor = v.id_vendedor
	join
		importe_total_venta as itv
		on itv.id_venta = ven.id_venta
	group by
		v.id_vendedor,
		v.nombre,
        v.id_sucursal
)

select
	ipv.nombre as vendedor,
    s.nombre as sucursal,
    ipv.total_vendido
from
	importe_por_vendedores as ipv
join
	sucursales as s
    on s.id_sucursal = ipv.id_sucursal 
order by
	ipv.total_vendido desc;
-- =================================================

-- =================================================
-- EJERCIO 5
create view v_catalogo_activo as
select
	p.id_producto,
    p.nombre as producto,
    c.nombre as categoria,
    p.precio,
    p.activo
from
	productos as p
join 
	categorias as c
    on c.id_categoria = p.id_categoria
where
	p.activo = 1;
    
select
	vca.producto,
    vca.categoria,
    vca.precio
from
	v_catalogo_activo as vca
order by
	vca.categoria,
    vca.producto;
	
-- =================================================


-- =================================================
-- EJERCIO 6
create view v_detalle_comercial as
select
	v.id_venta,
    v.fecha,
    c.nombre as cliente,
    ven.nombre as vendedor,
    s.nombre as sucursal,
    p.nombre as producto,
    cat.nombre as categoria,
    dv.cantidad,
    dv.precio_unitario,
    (dv.cantidad * dv.precio_unitario) as importe_total
from
	ventas as v
join
	clientes as c
    on v.id_cliente = c.id_cliente
join
	vendedores as ven
    on ven.id_vendedor = v.id_vendedor
join
	sucursales as s
    on s.id_sucursal = ven.id_sucursal
join
	detalle_ventas as dv
    on dv.id_venta = v.id_venta
join
	productos as p
    on p.id_producto = dv.id_producto
join
	categorias as cat
	on cat.id_categoria = p.id_categoria;
    
select
	*
from
	v_detalle_comercial
where
	sucursal = 'Centro';
-- ==================================================

-- ==================================================
-- EJERCIO 7
create view v_clientes_empresa as
select
	c.id_cliente,
    c.nombre,
    c.ciudad
from
	clientes as c
where
	c.tipo = 'EMPRESA';
    
select
	count(*) as cantidad, 
    vce.ciudad
from
	v_clientes_empresa as vce
group by
	vce.ciudad;
-- ==================================================

-- ==================================================
-- EJERCIO 8
create view v_resumen_vendedores as
select
	v.nombre,
    count(distinct ven.id_venta) as cantidad,
    sum(dv.cantidad * dv.precio_unitario) as importe_total
from
	vendedores as v
join
	ventas as ven
	on ven.id_vendedor = v.id_vendedor
join
	detalle_ventas as dv
    on dv.id_venta = ven.id_venta
group by
	v.nombre;
    
select
    *
from
	v_resumen_vendedores as vrv
order by 
	vrv.importe_total desc
limit 3;
-- ==================================================

-- ==================================================
-- EJERCIO 9
with resumen_catalogo as (
	select
		vca.categoria,
        count(*) as cantidad,
        max(vca.precio) as precio_max
    from
		v_catalogo_activo as vca
	group by
		vca.categoria
)

select
	rc.categoria,
    rc.cantidad,
    rc.precio_max
from
	resumen_catalogo as rc
where
	rc.cantidad >= 2;
-- ==================================================

-- ==================================================
-- EJERCIO 10
with ventas_por_cliente as (
	select
		vdc.cliente,
        count(distinct vdc.id_venta) as cantidad_ventas,
        sum(vdc.importe_total) as total_comprado
	from
		v_detalle_comercial  as vdc
	group by
		vdc.cliente
)

select
	*
from
	ventas_por_cliente as vpc
order by
	vpc.total_comprado;
-- ==================================================

-- ==================================================
-- EJERCIO 11
with comparacion_sucursales as (
	select
		vdc.sucursal,
        sum(vdc.importe_total) as total_vendido
	from
		v_detalle_comercial as vdc
	group by
		vdc.sucursal
)

select
	*
from
	comparacion_sucursales as cs
order by
	cs.total_vendido desc;
-- ==================================================

-- ==================================================
-- EJERCIO 12
with productos_destacados_categoria as (
	select
		vdc.producto,
        vdc.categoria,
        sum(vdc.cantidad) as cantidad_total
	from
		v_detalle_comercial as vdc
	group by
		vdc.producto,
		vdc.categoria
)

select
	pdc.producto,
    pdc.categoria,
    pdc.cantidad_total
from
	productos_destacados_categoria as pdc
where
	pdc.cantidad_total >= 2;
-- ==================================================

-- ==================================================
-- EJERCIO 13
with vendedores_encima_del_promedio as (
select
	vrv.nombre,
    vrv.importe_total
from
	v_resumen_vendedores as vrv
)

select
	vep.nombre,
    vep.importe_total
from
	vendedores_encima_del_promedio as vep
where
	vep.importe_total >  (
		select
			avg(vrv.importe_total)
		from
			v_resumen_vendedores as vrv
    );
-- ==================================================

-- ==================================================
-- EJERCIO 14
with productos_activos_no_vendidos as (
	select
		vca.id_producto,
		vca.producto,
		vca.activo
	from
		v_catalogo_activo as vca
)

select
	panv.id_producto,
	panv.producto,
    panv.activo
from
	productos_activos_no_vendidos as panv
where 
	not exists (
		select
			1
		from
			detalle_ventas as dv
		where
			dv.id_producto = panv.id_producto
    );
    
UPDATE productos
SET activo = 0
WHERE id_producto = 11;
-- ==================================================

-- ==================================================
-- EJERCIO 15
with cliente_compra_sup_promedio as(
	select
		v.id_cliente,
		sum(dv.cantidad) as total_comprado
	from
		ventas as v
	join
		detalle_ventas as dv
		on dv.id_venta = v.id_venta
	group by
		v.id_cliente
)

select
	c.id_cliente,
    c.nombre,
    ccsp.total_comprado
from
	clientes as c
join
	cliente_compra_sup_promedio as ccsp
where
	ccsp.total_comprado > (
		select
			avg(ccsp2.total_comprado)
		from
			cliente_compra_sup_promedio  as ccsp2
    );
-- ==================================================

-- ==================================================
-- EJERCIO 16
with total_vendido as (
	select
		vdc.categoria,
        sum(vdc.cantidad * vdc.precio_unitario) total_vendido
	from
		v_detalle_comercial  as vdc
	group by
		vdc.categoria
)

select
	tv.categoria,
    tv.total_vendido
from
	total_vendido as tv
where
	tv.total_vendido > (
		select
			avg(tv2.total_vendido)
		from
			total_vendido as tv2
    );
-- ==================================================

-- ==================================================
-- EJERCIO 17
select
	c.id_cliente,
    c.nombre
from
	clientes as c
where exists (
	select
		1
	from
		ventas as v
	join
		detalle_ventas as dv
		on dv.id_venta = v.id_venta
	join
		productos as p
		on p.id_producto = dv.id_producto
	join
		categorias as cat
		on cat.id_categoria = p.id_categoria
	where
		v.id_cliente = c.id_cliente
        and
		cat.nombre = 'Redes'
);
-- ==================================================

-- ==================================================
-- EJERCIO 18
select
	vdc.vendedor
from
	v_detalle_comercial as vdc
where exists (
	select
		1
	from
		v_detalle_comercial as vdc2
	where
		vdc2.vendedor = vdc.vendedor
		and
		vdc2.importe_total > 300000
);
-- ==================================================

-- ==================================================
-- EJERCIO 19
select
	p.nombre,
    p.precio
from
	productos as p
where
	p.activo = 1
    and
	p.precio > all (
		select
			p2.precio
		from
			productos as p2
		join
			categorias as c
			on c.id_categoria = p2.id_categoria
		where
            c.nombre = 'Oficina'
    );
-- ==================================================

-- ==================================================
-- EJERCIO 20
select
	p.nombre,
    p.precio
from
	productos as p
where
	p.activo = 1
    and
	p.precio < any (
		select
			p2.precio
		from
			productos as p2
		join
			categorias as c
			on c.id_categoria = p2.id_categoria
		where
            c.nombre = 'Computacion'
    );
-- ==================================================

-- ==================================================
-- EJERCIO 21
with total_vendido_vendedor as (
	select
		v.id_vendedor,
        v.nombre,
        v.id_sucursal,
        sum(dv.cantidad * dv.precio_unitario) as total_vendido
	from
		vendedores as v
	join
		ventas as ven
        on v.id_vendedor = ven.id_vendedor
	join
		detalle_ventas as dv
        on dv.id_venta = ven.id_venta
	group by
		v.id_vendedor,
        v.nombre,
        v.id_sucursal
)

select
	tvv.id_vendedor,
    tvv.nombre,
    tvv.total_vendido
from
	total_vendido_vendedor as tvv
where
	tvv.total_vendido > all (
		select
			tvv2.total_vendido
		from
			total_vendido_vendedor as tvv2
		join
			sucursales as s
            on tvv2.id_sucursal = s.id_sucursal
		where
			s.nombre = 'Puerto'
    );
-- ==================================================

-- ==================================================
-- EJERCIO 22
select
	vrv.nombre,
    vrv.cantidad,
	vrv.importe_total
from
	v_resumen_vendedores as vrv
where
	vrv.importe_total > any (
		select
			vrv2.importe_total
		from
			v_resumen_vendedores as vrv2
		where
			vrv2.cantidad >= 3
    )
-- ==================================================