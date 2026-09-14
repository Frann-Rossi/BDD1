
-- Ejercicio 1
select
	p.nombre as producto,
    p.precio,
    c.nombre_categoria as categoria
from
	productos as p
join
	categorias as c
	on p.id_categoria = c.id_categoria
order by p.nombre;

-- Ejercicio 2
select 
	p.nombre,
    p.precio,
    c.*
from 
	productos as p
left join 
	categorias as c
on p.id_categoria = c.id_categoria
order by p.nombre;

/*
select 
	p.nombre,
    p.precio,
    coalesce(c.id_categoria, "Sin nombre") as ID
from 
	productos as p
left join 
	categorias as c
on p.id_categoria = c.id_categoria
order by p.nombre;
*/

-- Ejercicio 3
select
	p.*,
    c.*
from productos as p
right join categorias as c
	on p.id_categoria = c.id_categoria;
    
select
	p.*,
    c.*
from productos as p
left join categorias as c
	on p.id_categoria = c.id_categoria;

-- Ejercicio 4
select
	p.*
from
	productos as p
left join
	categorias as c
    on p.id_categoria = c.id_categoria
where
	c.id_categoria is null;
    
select 
	c.*
from 
	categorias as c
left join
	productos as p
	on c.id_categoria = p.id_categoria
where 
	p.id_producto is null;
    
select
	p.*
from 
	productos as p
left join 
	proveedores as pro
	on p.id_proveedor = pro.id_proveedor
where 
	pro.id_proveedor is null;
    
 -- Ejercicio 5
select
	p.nombre,
    p.precio,
    c.nombre_categoria,
    pro.nombre_proveedor
from
	productos as p
left join 
	categorias as c
	on p.id_categoria = c.id_categoria
left join 
	proveedores as pro
    on p.id_proveedor = pro.id_proveedor
order by precio desc;

-- Ejercicio 6
select
	c.nombre_categoria
from 
	categorias as c




