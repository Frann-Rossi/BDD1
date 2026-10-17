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
