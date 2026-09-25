-- =========================================================
-- BASE DE DATOS PARA PRACTICAR SQL: JUEGOS Y VALORACIONES
-- Compatible con MySQL 8+
-- =========================================================

DROP DATABASE IF EXISTS bdd_juegos;
CREATE DATABASE bdd_juegos
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE bdd_juegos;

-- =========================================================
-- TABLA: usuarios
-- =========================================================

CREATE TABLE usuarios (
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL,
    pais VARCHAR(60) NOT NULL,
    fecha_registro DATE NOT NULL
);

-- =========================================================
-- TABLA: desarrolladores
-- =========================================================

CREATE TABLE desarrolladores (
    desarrollador_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_desarrollador VARCHAR(100) NOT NULL,
    pais VARCHAR(60) NOT NULL
);

-- =========================================================
-- TABLA: plataformas
-- =========================================================

CREATE TABLE plataformas (
    plataforma_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_plataforma VARCHAR(50) NOT NULL UNIQUE
);

-- =========================================================
-- TABLA: juegos
-- =========================================================

CREATE TABLE juegos (
    juego_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_juego VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    fecha_lanzamiento DATE NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    desarrollador_id INT NOT NULL,
    plataforma_id INT NOT NULL,
    CONSTRAINT fk_juegos_desarrolladores
        FOREIGN KEY (desarrollador_id)
        REFERENCES desarrolladores(desarrollador_id),
    CONSTRAINT fk_juegos_plataformas
        FOREIGN KEY (plataforma_id)
        REFERENCES plataformas(plataforma_id)
);

-- =========================================================
-- TABLA: valoraciones
-- =========================================================

CREATE TABLE valoraciones (
    valoracion_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    juego_id INT NOT NULL,
    puntuacion DECIMAL(3,1) NOT NULL,
    fecha_valoracion DATE NOT NULL,
    CONSTRAINT chk_puntuacion
        CHECK (puntuacion BETWEEN 0 AND 10),
    CONSTRAINT fk_valoraciones_usuarios
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(usuario_id),
    CONSTRAINT fk_valoraciones_juegos
        FOREIGN KEY (juego_id)
        REFERENCES juegos(juego_id)
);

-- =========================================================
-- INSERTS: plataformas
-- =========================================================

INSERT INTO plataformas (nombre_plataforma) VALUES
('PC'),
('PlayStation 5'),
('Xbox Series'),
('Nintendo Switch');

-- =========================================================
-- INSERTS: desarrolladores
-- =========================================================

INSERT INTO desarrolladores (nombre_desarrollador, pais) VALUES
('Aurora Games', 'Argentina'),
('Red Pixel Studio', 'España'),
('North Star Interactive', 'Canadá'),
('Blue Ocean Labs', 'Japón'),
('Quantum Forge', 'Estados Unidos'),
('Green Leaf Games', 'Brasil'),
('Silver Moon Studio', 'Alemania'),
('Retro Byte', 'Argentina');

-- =========================================================
-- INSERTS: usuarios
-- Algunos usuarios tienen registros antiguos y otros recientes.
-- =========================================================

INSERT INTO usuarios
    (nombre_usuario, pais, fecha_registro)
VALUES
('Lucia', 'Argentina', '2025-01-10'),
('Mateo', 'España', '2025-03-15'),
('Sofia', 'Chile', '2025-06-20'),
('Nicolas', 'Argentina', '2025-09-01'),
('Valentina', 'Uruguay', '2026-01-05'),
('Tomas', 'México', '2026-02-18'),
('Camila', 'Colombia', '2026-04-12'),
('Bruno', 'Argentina', '2026-06-25'),
('Martina', 'Perú', '2026-07-10'),
('Agustin', 'España', '2024-08-20'),
('Paula', 'Argentina', '2024-11-11'),
('Federico', 'Italia', '2025-02-28'),
('Carolina', 'Brasil', '2025-05-19'),
('Joaquin', 'Chile', '2026-08-01'),
('Mia', 'Canadá', '2026-08-15');

-- =========================================================
-- INSERTS: juegos
-- Hay juegos activos e inactivos, precios variados,
-- lanzamientos en 2025 y 2026, y algunos sin valoraciones.
-- =========================================================

INSERT INTO juegos
    (nombre_juego, precio, fecha_lanzamiento, activo, desarrollador_id, plataforma_id)
VALUES
('Racing Horizon', 45.00, '2026-01-20', TRUE, 1, 1),
('Realm of Shadows', 60.00, '2025-11-10', TRUE, 2, 1),
('Pixel Quest', 25.00, '2026-03-12', TRUE, 3, 1),
('World Builders', 80.00, '2025-08-22', TRUE, 4, 2),
('Red Kingdom', 55.00, '2026-05-05', TRUE, 5, 1),
('Mystic Valley', 35.00, '2025-04-18', TRUE, 6, 4),
('Cyber Strike', 95.00, '2026-02-28', TRUE, 7, 1),
('Rocket Arena', 20.00, '2025-12-01', TRUE, 8, 3),
('Silent Forest', 70.00, '2026-06-17', TRUE, 1, 1),
('Neon District', 110.00, '2025-09-30', TRUE, 2, 2),
('Rogue Planet', 50.00, '2026-07-21', TRUE, 3, 1),
('Golden Empire', 65.00, '2025-02-14', TRUE, 4, 3),
('Fallen Stars', 40.00, '2026-04-25', TRUE, 5, 4),
('Ancient Roads', 30.00, '2025-06-08', FALSE, 6, 1),
('Quantum Race', 125.00, '2026-08-10', TRUE, 7, 1),
('Blue Horizon', 75.00, '2025-10-19', TRUE, 8, 2),
('Retro World', 22.00, '2026-09-01', TRUE, 8, 1),
('Island Story', 15.00, '2025-01-30', TRUE, 4, 4),
('Dark Protocol', 90.00, '2026-03-30', FALSE, 5, 1),
('Forest Legends', 58.00, '2025-07-07', TRUE, 6, 3);

-- =========================================================
-- INSERTS: valoraciones
-- Se incluyen valoraciones en 2025 y 2026.
-- También hay juegos sin valoraciones.
-- =========================================================

INSERT INTO valoraciones
    (usuario_id, juego_id, puntuacion, fecha_valoracion)
VALUES
(1, 1, 9.0, '2026-01-25'),
(2, 1, 8.5, '2026-02-02'),
(3, 1, 7.0, '2025-12-20'),
(4, 1, 9.5, '2026-03-10'),
(5, 2, 8.0, '2026-01-18'),
(6, 2, 9.0, '2026-04-05'),
(7, 2, 7.5, '2025-12-15'),
(8, 3, 8.5, '2026-03-20'),
(9, 3, 9.0, '2026-04-10'),
(10, 3, 6.5, '2025-09-12'),
(11, 4, 9.0, '2026-02-15'),
(12, 4, 8.0, '2025-10-10'),
(13, 5, 8.5, '2026-05-20'),
(14, 5, 9.5, '2026-06-01'),
(15, 5, 7.0, '2025-12-01'),
(1, 6, 6.5, '2026-04-30'),
(2, 6, 7.5, '2025-05-20'),
(3, 7, 9.5, '2026-03-01'),
(4, 7, 8.5, '2026-03-15'),
(5, 7, 9.0, '2026-05-12'),
(6, 8, 7.0, '2026-01-10'),
(7, 8, 8.0, '2025-12-20'),
(8, 9, 9.0, '2026-06-20'),
(9, 9, 8.5, '2026-07-01'),
(10, 10, 9.5, '2025-10-05'),
(11, 10, 8.0, '2026-02-25'),
(12, 11, 8.5, '2026-07-25'),
(13, 11, 9.0, '2026-08-01'),
(14, 12, 7.5, '2025-03-01'),
(15, 12, 8.0, '2026-01-22'),
(1, 13, 8.5, '2026-05-01'),
(2, 13, 7.0, '2025-06-15'),
(3, 14, 6.0, '2025-08-01'),
(4, 15, 9.5, '2026-08-15'),
(5, 15, 9.0, '2026-08-20'),
(6, 16, 8.0, '2025-11-01'),
(7, 17, 8.5, '2026-09-05'),
(8, 18, 7.5, '2025-02-15'),
(9, 20, 8.0, '2026-07-15');