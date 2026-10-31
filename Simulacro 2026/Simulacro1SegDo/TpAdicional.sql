create view v_detalle_comercial as
select
	v.id_venta,
    v.fecha,
    c.nombre as cliente,
    ven.nombre as vendedore,
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
	sucursales = 'Centro';