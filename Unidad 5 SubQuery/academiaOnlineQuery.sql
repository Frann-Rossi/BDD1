-- ==================================================
-- EJERCIO 1
select
	c.id_curso,
    c.titulo,
    c.precio,
    c.horas
from
	cursos as c
where
	precio > (
		select
			avg(precio)
		from
			cursos
    );
-- ==================================================

-- ==================================================
-- EJERCIO 2
select
	i.id_instructor,
    i.nombre,
    i.apellido,
    i.sueldo_base
from
	instructores as i
where i.sueldo_base = (
	select
		max(sueldo_base)
	from
		instructores
);
-- ==================================================

-- ==================================================
-- EJERCIO 3
select
	c.id_curso,
    c.titulo,
    c.precio
from 
	cursos as c
where
	c.id_categoria in (
		select
			cat.id_categoria
		from
			categorias as cat
		where
			cat.nombre in ('Programacion', 'Ciberseguridad')
    );
    
select
	c.id_curso,
    c.titulo,
    c.precio
from 
	cursos as c
join
	categorias as cat
	on c.id_categoria = cat.id_categoria
where
	cat.nombre in ('Programacion', 'Ciberseguridad');
-- ==================================================

-- ==================================================
-- EJERCIO 4
select
	c.id_curso,
    c.titulo
from
	cursos as c
where not exists (
	select
		1
	from
		inscripciones as i
	where
		i.id_curso = c.id_curso
);

SELECT
    c.id_curso,
    c.titulo
FROM
    cursos AS c
WHERE c.id_curso NOT IN (
    SELECT DISTINCT i.id_curso
    FROM inscripciones AS i
);
-- ==================================================

-- ==================================================
-- EJERCIO 5
select
	c.id_curso,
    c.titulo,
    c.precio
from
	cursos as c
where c.precio > any (
	select
		cat.nombre
	from
		categorias as cat
	where
		cat.nombre = 'Negocios'
);

select * from cursos; 

SELECT 
    c.id_curso,
    c.titulo,
    c.precio
FROM 
    cursos AS c
WHERE c.precio > ANY (
    SELECT c2.precio
    FROM cursos AS c2
    JOIN categorias AS cat ON c2.id_categoria = cat.id_categoria
    WHERE cat.nombre = 'Negocios'
);
-- ==================================================