create table carrera(
	id_carrera int auto_increment primary key,
    nombre varchar(30) not null,
    duracion_anios date not null check(duracion_anios between 1 and 8),
    estado enum ('Activa' , 'Inactiva') not null default 'Activa'
);

alter table carrera modify column duracion_anios tinyint UNSIGNED not null check(duracion_anios between 1 and 8);

create table materia(
	id_materia int auto_increment primary key,
    codigo tinyint unsigned not null,
    nombre varchar(50) not null,
    carga_horaria tinyint unsigned not null
);

alter table materia modify column codigo tinyint unsigned unique not null;

create table docente(
	id_docente int auto_increment primary key,
    legajo tinyint unsigned unique not null,
    apellido varchar(50) not null,
    nombre varchar(50) not null,
    email varchar(50) unique not null
);

drop table carrera,materia,docente;

show tables;
describe carrera;
