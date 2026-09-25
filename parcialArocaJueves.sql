/*
Ejercicio 1  
Mostrar todos los datos de 3 juegos activos cuyo precio se encuentre entre 20 y 60 inclusive. 
Ordenar los resultados del precio más alto al más bajo y omitir 
los dos primeros registros del resultado ordenado.  
*/
select
	*
from 
	juegos as j
where
	j.precio between 20 and 60
    and	j.activo = true
order by
	j.precio desc 
limit 3
offset 2;

/*
Ejercicio 2  
Mostrar el nombre del usuario y el nombre del juego correspondientes a 
valoraciones realizadas durante 2026 cuya puntuación sea de 8 o más. 
No mostrar combinaciones repetidas de usuario y juego.  
*/
select distinct
	u.nombre_usuario,
    j.nombre_juego
from
	usuarios as u
join
	valoraciones as v
    on u.usuario_id = v.usuario_id
join
	juegos as j
    on j.juego_id = v.juego_id
where
	year(v.fecha_valoracion) = 2026
    and v.puntuacion >= 8;
	
/*
Ejercicio 3  
Mostrar usuario_id, nombre_usuario y fecha_registro de los usuarios que 
no hayan realizado ninguna valoración durante 2026 
y cuya antigüedad de registro sea superior a 100 días respecto de la fecha actual.   
*/ 

select
	u.usuario_id,
    u.nombre_usuario,
    u.fecha_registro
from
	usuarios as u
left join
	valoraciones as v
    on u.usuario_id = v.usuario_id
    and year(v.fecha_valoracion) = 2026
where
    v.valoracion_id is null
    and datediff(curdate(), u.fecha_registro) > 100;
    
/*
Ejercicio 4
Mostrar todos los juegos junto con la cantidad de valoraciones recibidas, la puntuación mínima y la puntuación máxima. 
Los juegos que todavía no poseen valoraciones también deben aparecer; en esos casos, 
los resultados numéricos solicitados deberán mostrarse como 0.     
*/ 
select
	j.nombre_juego,
    count(v.valoracion_id) as cantidad_valoraciones,
    coalesce(min(v.puntuacion),0) as puntuacion_min,
    coalesce(max(v.puntuacion),0) as puntuacion_max
from
	juegos as j
left join
	valoraciones as v
    on j.juego_id = v.juego_id
group by
	j.juego_id,
	j.nombre_juego;
    
/*
Ejercicio 5
La foto permite leer que pide: Mostrar el nombre del desarrollador, su país y el nombre de la plataforma, 
junto con la cantidad total de valoraciones recibidas y la puntuación recibida por sus juegos. 
Considerar únicamente juegos activos correspondientes a la plataforma 'PC'. 
Mostrar solo las combinaciones que acumulen más de 10 valoraciones, ordenar de mayor a menor por la cantidad de valoraciones y, 
en caso de empate, por nombre del desarrollador en orden ascendente. Limitar la salida a los 3 primeros resultados.  
*/ 
select
	d.nombre_desarrollador,
    d.pais,
    p.nombre_plataforma,
    count(v.valoracion_id) as total_valoraciones,
    sum(v.puntuacion) as puntuacion_total
from
	desarrolladores as d
join
	juegos as j
    on d.desarrollador_id = j.desarrollador_id
join
	plataformas as p
    on j.plataforma_id = p.plataforma_id
join
	valoraciones as v
    on j.juego_id = v.juego_id
where
	j.activo = true
    and p.nombre_plataforma = 'PC'
group by
	d.desarrollador_id,
	d.nombre_desarrollador,
    d.pais,
    p.nombre_plataforma
having
	count(v.valoracion_id) > 10
order by
	 total_valoraciones desc, d.nombre_desarrollador asc
limit 3;

/*
Ejercicio 6
Aplicar un descuento del 15 % sobre el precio de los juegos que cumplan al menos una de estas condiciones: 
haber sido lanzados durante 2026 o que su nombre comience con la letra 'R'. 
Actualizar únicamente los registros que satisfagan alguna de esas condiciones.  
*/ 

update juegos set precio = precio * 0.85
where 
	year(fecha_lanzamiento) = 2026
    or nombre_juego like 'R%';

SELECT
    juego_id,
    nombre_juego,
    precio,
    fecha_lanzamiento
FROM juegos
WHERE
    YEAR(fecha_lanzamiento) = 2026
    OR nombre_juego LIKE 'R%';

/*
Ejercicio 7
Mostrar un reporte general de los juegos activos que muestre en una única fila: cantidad total de juegos activos, 
precio mínimo, precio máximo, precio promedio y costo total de adquirir una copia de cada juego activo.
*/ 
select
	count(*) as cantidad_juegos,
    min(precio) as precio_min,
    max(precio) as precio_max,
    avg(precio) as promedio_precio,
    sum(precio) as costo_total
from
	juegos
where
	activo = true;
    
/*
Ejercicio 8 
La parte izquierda está cortada, pero se alcanza a leer:
listado con los nombres y países registrados tanto en usuarios como en desarrolladores. 
El resultado deberá mostrar nombres y país, no deberá repetir filas idénticas y deberá quedar ordenado alfabéticamente por nombre.
*/ 

SELECT DISTINCT
    u.nombre_usuario,
    u.pais AS pais_usuario,
    d.nombre_desarrollador,
    d.pais AS pais_desarrollador
FROM usuarios AS u
JOIN valoraciones AS v
    ON u.usuario_id = v.usuario_id
JOIN juegos AS j
    ON v.juego_id = j.juego_id
JOIN desarrolladores AS d
    ON j.desarrollador_id = d.desarrollador_id
ORDER BY
    u.nombre_usuario ASC,
    d.nombre_desarrollador ASC;
    

SELECT
    nombre_usuario AS nombre,
    pais
FROM usuarios
UNION
SELECT
    nombre_desarrollador AS nombre,
    pais
FROM desarrolladores
ORDER BY
    nombre ASC;

