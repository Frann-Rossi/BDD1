-- ==================================================
-- EJERCICIO 1
-- Devuelve un listado con todos los empleados que pertenecen al departamento de Sistemas. 
-- Resolver sin utilizar INNER JOIN.
select
	e.codigo,
    e.nombre,
    (
		select 
			d.nombre
		from
			departamento as d
		where
			d.codigo = e.codigo_departamento
    ) as departamento
from
	empleado as e
where
	e.codigo_departamento = (
		select
			d.codigo
		from
			departamento as d
		where
			d.codigo = e.codigo_departamento
            and
            d.nombre = 'Sistemas'
    );
-- ==================================================

-- ==================================================
-- EJERCICIO 2
-- Devuelve el nombre del departamento con 
-- mayor presupuesto y la cantidad asignada.

select
	d.nombre,
    d.presupuesto
from
	departamento as d
where
	d.presupuesto =  (
		select
			max(d2.presupuesto)
		from
			departamento as d2
    );
    
-- ==================================================

-- ==================================================
-- EJERCICIO 3
-- Devuelve el nombre y presupuesto de los departamentos cuyo 
-- presupuesto sea superior al promedio de todos los departamentos.

select
	d.nombre,
    d.presupuesto
from
	departamento as d
where
	d.presupuesto > (
		select
			avg(d2.presupuesto)
		from
			departamento as d2
    );
    
-- ==================================================

-- ==================================================
-- EJERCICIO 4
-- Tomando como referencia los departamentos cuyo presupuesto sea menor a 100000: 
-- a) mostrar los departamentos cuyo presupuesto sea mayor que ANY de esos presupuestos; 
-- b) mostrar los departamentos cuyo presupuesto sea mayor que ALL de esos presupuestos. 
-- Observar y explicar brevemente la diferencia entre ambos resultados.

select
	d.nombre,
    d.presupuesto
from
	departamento as d
where
	d.presupuesto > any (
		select
			d2.presupuesto
		from
			departamento as d2
		where
			d2.presupuesto < 100000
    );
    
select
	d.nombre,
    d.presupuesto
from
	departamento as d
where
	d.presupuesto > all (
		select
			d2.presupuesto
		from
			departamento as d2
		where
			d2.presupuesto < 100000
    );
-- ==================================================

-- ==================================================
-- EJERCICIO 5
-- Devuelve código, nombre y apellido de los empleados que pertenecen a departamentos cuyo 
-- presupuesto sea superior al promedio general. Utilizar IN con subconsulta.

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
			d.presupuesto > (
				select
					avg(d2.presupuesto)
				from
					departamento as d2
            )
    );

-- ==================================================

-- ==================================================
-- EJERCICIO 6
-- Crear una subconsulta en FROM que obtenga codigo_departamento 
-- y cantidad de empleados por departamento. Desde la consulta externa 
-- mostrar solamente los resultados cuya cantidad de empleados sea mayor que 1.
-- No es necesario mostrar el nombre del departamento.

select
	t.codigo_departamento,
    t.cantidad
from
	(
		select
			e.codigo_departamento,
            count(e.codigo) as cantidad
		from
			empleado as e
		group by
			e.codigo_departamento
    ) as t
where
	t.cantidad > 1;
-- ==================================================

-- ==================================================
-- EJERCICIO 7
-- Crear una subconsulta en FROM que seleccione los departamentos cuyo 
-- presupuesto sea igual o superior a 50000. 
-- Desde la consulta externa mostrar solamente los que además tengan un presupuesto menor o igual a 150000.

select
	t.nombre,
	t.presupuesto
from
	(
		select
			d.nombre,
			d.presupuesto
		from
			departamento as d
		where
			d.presupuesto >= 50000
    ) as t
where
	t.presupuesto <= 150000
-- ==================================================

-- ==================================================
-- EJERCICIO 8
-- ==================================================