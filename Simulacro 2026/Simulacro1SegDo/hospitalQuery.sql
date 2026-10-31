-- =======================================================
-- EJERCICIO 1
select
	t.id_tratamiento,
    t.descripcion,
    (
		select
			count(*)
		from
			consultas as c
		where
			c.id_tratamiento = t.id_tratamiento
    ) as total_consultas,
    (
		select
			coalesce(sum(costo_consulta),0)
		from
			consultas as c
		where
			c.id_tratamiento = t.id_tratamiento
    ) as costo_total
from 
	tratamientos as t;
-- =======================================================

-- =======================================================
-- EJERCICIO 2
select
	p.id_paciente,
	p.nombre,
    (
		select
			max(c.fecha_consulta)
		from
			consultas as c
		where
			c.id_paciente = p.id_paciente
    ) as fecha_consultas_resiente
from
	pacientes as p;
-- =======================================================

-- =======================================================
-- EJERCICIO 3
select
	d.id_doctor,
    d.nombre,
    (
		select
			count(*)
		from
			consultas as c
		where
			c.id_doctor = d.id_doctor
            and c.fecha_consulta >= date_sub(curdate(),interval 1 year)
    ) as consultas_realizadas
from
	doctores as d
order by consultas_realizadas desc
limit 1;
-- =======================================================

-- =======================================================
-- EJERCICIO 4
select
	d.nombre
from
	doctores as d
where
	d.ciudad = 'Madrid'
    and
	(
		select
			count(distinct dh.id_hospital)
		from
			doctores_hospitales as dh
		where
			dh.id_doctor= d.id_doctor
    ) > 1;
-- =======================================================

-- =======================================================
-- EJERCICIO 5
select
	p.nombre
from
	pacientes as p
where
	p.id_paciente in(
		select
			c.id_paciente
		from
			consultas as c
		where
			c.id_doctor in (
				select
					d.id_doctor
				from
					doctores as d
				where
					d.especialidad = 'Cardiología'
	)
);

SELECT 
    p.nombre
FROM 
    pacientes AS p
WHERE EXISTS (
    SELECT 1
    FROM consultas AS c
    WHERE c.id_paciente = p.id_paciente
      AND c.id_doctor IN (
          SELECT d.id_doctor
          FROM doctores AS d
          WHERE d.especialidad = 'Cardiología'
      )
);
-- =======================================================

-- =======================================================
-- EJERCICIO 6
create view vista_resumen_productos as
select
	p.producto_id,
    p.nombre_producto,
    p.categoria,
    sum(dp.cantidad) as unidades_vendidas,
    sum(dp.cantidad * p.precio) as importe_total
from
	productos as p
join
	detalle_pedido as dp
    on  p.producto_id = dp.producto_id
group by
	p.producto_id,
    p.nombre_producto,
    p.categoria;
    
select
	*
from
	vista_resumen_productos as vrp
order by
	vrp.importe_total desc	
-- =======================================================

-- =======================================================
-- EJERCICIO 7
-- =======================================================