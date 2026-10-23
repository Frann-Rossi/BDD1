-- =======================================================
-- EJERCIO 1
select
	e.*
from
	empleado as e
where
	e.codigo_departamento = (
		select
			d.codigo
		from
			departamento as d
		where
			d.nombre = 'Sistemas'
);

select
	e.*
from 
	empleado as e
join
	departamento as d
	on e.codigo_departamento = d.codigo
where
	d.nombre = 'Sistemas';
-- =======================================================

-- =======================================================
-- EJERCIO 2
select
	nombre,
    presupuesto
from
	departamento 
where d.codigo = (
	select
		max(presupuesto) as presupuesto_max
	from
		departamento
);
-- =======================================================

-- =======================================================
-- EJERCIO 3
select
	nombre,
    presupuesto
from
	departamento
where
	presupuesto > (
		select
			avg(presupuesto)
		from
			departamento
);
-- =======================================================
-- EJERCIO 4
select
	*
from
	departamento
where
	presupuesto > any (
		select
			presupuesto
		from
			departamento
		where
			presupuesto < 100000
    );
    
select
	*
from
	departamento
where
	presupuesto > all (
		select
			presupuesto
		from
			departamento
		where
			presupuesto < 100000
	);
-- =======================================================
-- EJERCIO 5
select
	e.codigo,
    e.nombre,
    e.apellido1
from
	empleado as e
where
	e.codigo_departamento in (
		select
			d.codigo
		from
			departamento as d
		where
			d.presupuesto >(
				select
					avg(presupuesto)
				from
					departamento
            )
    );
    
SELECT 
    e.codigo,
    e.nombre,
    e.apellido1
FROM 
    empleado AS e
JOIN 
    departamento AS d
    ON e.codigo_departamento = d.codigo
WHERE 
    d.presupuesto > (
        SELECT AVG(presupuesto)
        FROM departamento
    );
-- =======================================================

-- =======================================================
-- EJERCIO 6
select
	codigo_departamento,
    cantidad_empleados
from
	(
	select
		codigo_departamento,
		count(*) as cantidad_empleados
	from
		empleado
	where
		codigo_departamento is not null
	group by
		codigo_departamento
    ) as resumen
where
	cantidad_empleados > 1;
-- =======================================================

-- =======================================================
-- EJERCIO 7
select
	nombre,
	presupuesto
from
	(
	select
		nombre,
		presupuesto
	from
		departamento
	where
		presupuesto >= 50000
    ) as departamento_filtrado
where 
	presupuesto <= 150000;
-- =======================================================

-- =======================================================
-- EJERCIO 8
select
	d.nombre
from
	departamento as d
where exists (
	select
		1
	from
		empleado as e
	where 
		e.codigo_departamento = d.codigo
		and e.apellido2 is null
);
-- =======================================================

-- =======================================================
-- EJERCIO 9
select
	d.nombre
from
	departamento as d
where not exists (
	select
		1
	from
		empleado as e
	where
		e.codigo_departamento = d.codigo
);
-- =======================================================

-- =======================================================
-- EJERCIO 10
select
	e.codigo,
    e.nombre,
    e.apellido1,
    (
		select
			d.nombre
		from
			departamento as d
		where
			d.codigo = e.codigo_departamento
    ) as nombre_departamento
from
	empleado as e;
-- =======================================================

-- =======================================================
-- EJERCIO 11
select
	d.codigo,
    d.nombre,
    (
		select
			count(*)
		from
			empleado as e
        where
			e.codigo_departamento = d.codigo
    ) as cantidad_empleados
from
	departamento as d;
-- =======================================================

-- =======================================================
-- EJERCIO 12
select
	e.codigo,
    e.nombre,
    e.apellido1
from
	empleado as e
where
	e.codigo_departamento in (
		select
			d.presupuesto
		from
			departamento as d
		where
			d.presupuesto > 50000
    ) and 
    e.codigo_departamento in (
		select
			e.codigo_departamento
		from
			empleado as e
		where
			e.codigo_departamento is not null
		group by
			e.codigo_departamento
		having
			count(e.codigo_departamento) > 1
    );
   
select
	e.codigo,
    e.nombre,
    e.apellido1
from
	empleado as e
join
	(
		select
			codigo
		from
			departamento
		where
			presupuesto > 50000
    ) as d
where
    e.codigo_departamento in (
		select
			e.codigo_departamento
		from
			empleado as e
		where
			e.codigo_departamento is not null
		group by
			e.codigo_departamento
		having
			count(e.codigo_departamento) > 1
    );
-- =======================================================

-- =======================================================
-- EJERCIO 13
-- =======================================================
