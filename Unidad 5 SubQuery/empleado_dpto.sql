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
