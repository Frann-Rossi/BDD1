create database prueba22;
use prueba22;

CREATE TABLE carreras (
    id_carrera INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    duracion_anios TINYINT UNSIGNED NOT NULL,
    estado ENUM('Activa', 'Inactiva') NOT NULL DEFAULT 'Activa',

    CONSTRAINT pk_carreras PRIMARY KEY (id_carrera),
    CONSTRAINT uq_carreras_nombre UNIQUE (nombre),
    CONSTRAINT chk_carreras_duracion
        CHECK (duracion_anios BETWEEN 1 AND 8)
) ENGINE = InnoDB;

CREATE TABLE alumnos (
    id_alumno BIGINT UNSIGNED AUTO_INCREMENT,
    legajo VARCHAR(20) NOT NULL,
    dni VARCHAR(15) NOT NULL,
    apellido VARCHAR(60) NOT NULL,
    nombre VARCHAR(60) NOT NULL,
    fecha_nacimiento DATE NULL,
    email VARCHAR(120) NULL,
    id_carrera INT UNSIGNED NOT NULL,

    CONSTRAINT pk_alumnos PRIMARY KEY (id_alumno),
    CONSTRAINT uq_alumnos_legajo UNIQUE (legajo),
    CONSTRAINT uq_alumnos_dni UNIQUE (dni),
    CONSTRAINT uq_alumnos_email UNIQUE (email),
    CONSTRAINT fk_alumnos_carreras
        FOREIGN KEY (id_carrera)
        REFERENCES carreras (id_carrera)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE = InnoDB;

insert into carreras (nombre, duracion_anios, estado) value
('Ingeniería en Sistemas', 5, 'Activa'),
('Licenciatura en Administración', 4, 'Activa'),
('Contador Público', 4, 'Activa'),
('Ingeniería Industrial', 5, 'Activa'),
('Licenciatura en Marketing', 4, 'Inactiva');

insert into alumnos (
    legajo,
    dni,
    apellido,
    nombre,
    fecha_nacimiento,
    email,
    id_carrera
) values
('LEG-0001', '40123456', 'Gómez', 'Juan', '2002-05-14', 'juan.gomez@email.com', 1),
('LEG-0002', '41234567', 'Fernández', 'María', '2001-08-22', 'maria.fernandez@email.com', 2),
('LEG-0003', '42345678', 'Rodríguez', 'Lucas', '2003-01-10', 'lucas.rodriguez@email.com', 3),
('LEG-0004', '43456789', 'Martínez', 'Sofía', '2002-11-30', 'sofia.martinez@email.com', 4),
('LEG-0005', '44567890', 'Pérez', 'Nicolás', '2000-07-18', 'nicolas.perez@email.com', 5);



