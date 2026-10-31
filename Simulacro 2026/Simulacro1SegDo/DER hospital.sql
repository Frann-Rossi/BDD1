CREATE DATABASE IF NOT EXISTS practica_der_medico
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE practica_der_medico;
SET NAMES utf8mb4;


CREATE TABLE doctores (
    id_doctor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    especialidad VARCHAR(50) NOT NULL,
    ciudad VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    ciudad VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE tratamientos (
    id_tratamiento INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    costo DECIMAL(10,2) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE hospitales (
    id_hospital INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    ciudad VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE doctores_hospitales (
    id_doctor INT NOT NULL,
    id_hospital INT NOT NULL,
    PRIMARY KEY (id_doctor, id_hospital),
    CONSTRAINT fk_dh_doctor
        FOREIGN KEY (id_doctor) REFERENCES doctores(id_doctor),
    CONSTRAINT fk_dh_hospital
        FOREIGN KEY (id_hospital) REFERENCES hospitales(id_hospital)
) ENGINE = InnoDB;

CREATE TABLE consultas (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    id_doctor INT NOT NULL,
    id_paciente INT NOT NULL,
    id_tratamiento INT NOT NULL,
    fecha_consulta DATE NOT NULL,
    costo_consulta DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_consulta_doctor
        FOREIGN KEY (id_doctor) REFERENCES doctores(id_doctor),
    CONSTRAINT fk_consulta_paciente
        FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    CONSTRAINT fk_consulta_tratamiento
        FOREIGN KEY (id_tratamiento) REFERENCES tratamientos(id_tratamiento)
) ENGINE = InnoDB;


-- Las fechas se calculan en relacion con el dia de carga.
SET @fecha_base = CURDATE();
SET @inicio_ultimo_anio = DATE_SUB(@fecha_base, INTERVAL 1 YEAR);

INSERT INTO doctores (id_doctor, nombre, especialidad, ciudad) VALUES
(1, 'Ana García', 'Cardiología', 'Madrid'),
(2, 'Carlos López', 'Traumatología', 'Madrid'),
(3, 'Marta Ruiz', 'Cardiología', 'Valencia'),
(4, 'Diego Pérez', 'Pediatría', 'Barcelona'),
(5, 'Elena Torres', 'Dermatología', 'Sevilla'),
(6, 'Pablo Martín', 'Neurología', 'Madrid');

INSERT INTO pacientes (id_paciente, nombre, edad, ciudad) VALUES
(1, 'Lucía Pérez', 34, 'Madrid'),
(2, 'Juan Martínez', 55, 'Madrid'),
(3, 'Sofía Gómez', 28, 'Barcelona'),
(4, 'Martín Díaz', 61, 'Valencia'),
(5, 'Carla Fernández', 42, 'Madrid'),
(6, 'Pedro Sánchez', 12, 'Barcelona'),
(7, 'Valentina Torres', 26, 'Madrid'),
(8, 'Tomás Romero', 49, 'Valencia');

INSERT INTO tratamientos (id_tratamiento, descripcion, costo) VALUES
(1, 'Consulta general', 50.00),
(2, 'Electrocardiograma', 80.00),
(3, 'Rehabilitación', 60.00),
(4, 'Control pediátrico', 40.00),
(5, 'Resonancia magnética', 200.00);

INSERT INTO hospitales (id_hospital, nombre, ciudad) VALUES
(1, 'Hospital Central', 'Madrid'),
(2, 'Hospital Norte', 'Madrid'),
(3, 'Hospital Sur', 'Madrid'),
(4, 'Hospital Mediterráneo', 'Barcelona'),
(5, 'Hospital Levante', 'Valencia');

INSERT INTO doctores_hospitales (id_doctor, id_hospital) VALUES
(1, 1), (1, 2),
(2, 1), (2, 4),
(3, 1), (3, 3), (3, 5),
(4, 4), (4, 5),
(5, 2),
(6, 1);


INSERT INTO consultas
(id_consulta, id_doctor, id_paciente, id_tratamiento, fecha_consulta, costo_consulta)
VALUES
(1, 1, 1, 2, DATE_SUB(@fecha_base, INTERVAL 5 DAY), 80.00),
(2, 1, 2, 2, DATE_SUB(@fecha_base, INTERVAL 30 DAY), 85.00),
(3, 1, 3, 1, DATE_SUB(@fecha_base, INTERVAL 60 DAY), 50.00),
(4, 1, 1, 1, DATE_SUB(@fecha_base, INTERVAL 120 DAY), 55.00),
(5, 1, 4, 2, @inicio_ultimo_anio, 90.00);

INSERT INTO consultas
(id_consulta, id_doctor, id_paciente, id_tratamiento, fecha_consulta, costo_consulta)
VALUES
(6, 3, 2, 2, DATE_SUB(@fecha_base, INTERVAL 10 DAY), 80.00),
(7, 3, 4, 1, DATE_SUB(@fecha_base, INTERVAL 45 DAY), 50.00),
(8, 3, 5, 2, DATE_SUB(@fecha_base, INTERVAL 90 DAY), 85.00),
(9, 3, 1, 1, DATE_SUB(@fecha_base, INTERVAL 180 DAY), 50.00),
(10, 3, 5, 2, DATE_SUB(@fecha_base, INTERVAL 300 DAY), 80.00);

INSERT INTO consultas
(id_consulta, id_doctor, id_paciente, id_tratamiento, fecha_consulta, costo_consulta)
VALUES
(11, 2, 2, 3, DATE_SUB(@fecha_base, INTERVAL 15 DAY), 60.00),
(12, 2, 3, 3, DATE_SUB(@fecha_base, INTERVAL 75 DAY), 65.00),
(13, 2, 5, 1, DATE_SUB(@fecha_base, INTERVAL 200 DAY), 50.00);

INSERT INTO consultas
(id_consulta, id_doctor, id_paciente, id_tratamiento, fecha_consulta, costo_consulta)
VALUES
(14, 4, 6, 4, DATE_SUB(@fecha_base, INTERVAL 20 DAY), 40.00),
(15, 4, 6, 4, DATE_SUB(@fecha_base, INTERVAL 100 DAY), 45.00);

INSERT INTO consultas
(id_consulta, id_doctor, id_paciente, id_tratamiento, fecha_consulta, costo_consulta)
VALUES
(16, 5, 3, 1, DATE_SUB(@fecha_base, INTERVAL 40 DAY), 50.00),
(17, 5, 8, 1, DATE_SUB(@inicio_ultimo_anio, INTERVAL 1 DAY), 50.00),
(18, 5, 2, 1, DATE_SUB(@inicio_ultimo_anio, INTERVAL 1 MONTH), 45.00),
(19, 5, 3, 1, DATE_SUB(@inicio_ultimo_anio, INTERVAL 2 MONTH), 45.00),
(20, 5, 4, 1, DATE_SUB(@inicio_ultimo_anio, INTERVAL 3 MONTH), 50.00),
(21, 5, 5, 1, DATE_SUB(@inicio_ultimo_anio, INTERVAL 4 MONTH), 50.00),
(22, 5, 8, 1, DATE_SUB(@inicio_ultimo_anio, INTERVAL 5 MONTH), 55.00);