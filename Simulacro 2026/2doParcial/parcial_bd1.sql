-- BASE DE DATOS DE PRACTICA - PARCIAL BASE DE DATOS I
-- Motor: MySQL 8.0+ / MariaDB 10.2+
-- ATENCION: recrea la base parcial_bd1 y elimina sus datos anteriores.
DROP DATABASE IF EXISTS parcial_bd1;
CREATE DATABASE parcial_bd1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE parcial_bd1;

CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL
);

CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    activo TINYINT(1) NOT NULL DEFAULT 1,
    id_categoria INT NOT NULL,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(80) NOT NULL
);

CREATE TABLE sucursales (
    id_sucursal INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(80) NOT NULL
);

CREATE TABLE vendedores (
    id_vendedor INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_sucursal INT NOT NULL,
    CONSTRAINT fk_vendedor_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal)
);

CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    fecha DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    CONSTRAINT fk_venta_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_venta_vendedor FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
);

CREATE TABLE detalle_ventas (
    id_detalle INT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_detalle_venta FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

INSERT INTO categorias (id_categoria, nombre) VALUES
(1,'Tecnologia'),(2,'Hogar'),(3,'Libreria'),(4,'Deportes'),(5,'Jardineria'),(6,'Mascotas');

INSERT INTO productos (id_producto,nombre,precio,activo,id_categoria) VALUES
(1,'Mouse inalambrico',12000,1,1),
(2,'Teclado mecanico',45000,1,1),
(3,'Monitor 24 pulgadas',180000,1,1),
(4,'Webcam HD',35000,0,1),
(5,'Lampara de mesa',22000,1,2),
(6,'Pava electrica',65000,1,2),
(7,'Tostadora',48000,0,2),
(8,'Cuaderno A4',4500,1,3),
(9,'Lapicera azul',1200,1,3),
(10,'Carpeta oficio',3900,1,3),
(11,'Pelota de futbol',28000,1,4),
(12,'Mancuerna 5 kg',32000,1,4),
(13,'Raqueta de tenis',98000,0,4),
(14,'Regadera',15000,1,5),
(15,'Pala de jardin',24000,0,5),
(16,'Alimento para perro',38000,1,6),
(17,'Correa para perro',11000,1,6),
(18,'Cama para gato',41000,1,6),
(19,'Auriculares bluetooth',57000,1,1),
(20,'Agenda 2026',8500,0,3);

INSERT INTO clientes (id_cliente,nombre,ciudad) VALUES
(1,'Ana Lopez','Mar del Plata'),
(2,'Bruno Garcia','Buenos Aires'),
(3,'Carla Perez','Mar del Plata'),
(4,'Diego Fernandez','Balcarce'),
(5,'Elena Ruiz','Miramar'),
(6,'Facundo Torres','Mar del Plata'),
(7,'Gabriela Soto','Necochea'),
(8,'Hernan Diaz','Buenos Aires'),
(9,'Ines Molina','Mar del Plata'),
(10,'Jorge Castro','Tandil');

INSERT INTO sucursales (id_sucursal,nombre,ciudad) VALUES
(1,'Sucursal Centro','Mar del Plata'),
(2,'Sucursal Puerto','Mar del Plata'),
(3,'Sucursal Capital','Buenos Aires'),
(4,'Sucursal Tandil','Tandil');

INSERT INTO vendedores (id_vendedor,nombre,id_sucursal) VALUES
(1,'Laura Martinez',1),
(2,'Martin Romero',1),
(3,'Natalia Vega',2),
(4,'Oscar Benitez',3),
(5,'Paula Silva',4),
(6,'Ricardo Gomez',3);

INSERT INTO ventas (id_venta,fecha,id_cliente,id_vendedor) VALUES
(1,'2026-01-10',1,1),
(2,'2026-01-15',2,4),
(3,'2026-02-03',3,2),
(4,'2026-02-21',1,3),
(5,'2026-03-11',4,5),
(6,'2026-03-22',5,1),
(7,'2026-04-07',2,4),
(8,'2026-05-13',6,2),
(9,'2026-06-08',3,3),
(10,'2026-07-19',7,5),
(11,'2026-08-24',1,1),
(12,'2026-09-05',8,6),
(13,'2025-11-20',9,1),
(14,'2025-12-12',4,5),
(15,'2026-10-10',6,3),
(16,'2026-10-25',5,2);

INSERT INTO detalle_ventas (id_detalle,id_venta,id_producto,cantidad,precio_unitario) VALUES
(1,1,1,3,12000),(2,1,8,2,4500),
(3,2,2,2,45000),(4,2,9,4,1200),
(5,3,3,1,180000),(6,3,5,2,22000),
(7,4,1,5,12000),(8,4,10,1,3900),
(9,5,6,2,65000),(10,5,11,1,28000),
(11,6,8,4,4500),(12,6,9,6,1200),
(13,7,2,3,45000),(14,7,12,2,32000),
(15,8,16,3,38000),(16,8,17,1,11000),
(17,9,3,2,180000),(18,9,19,4,57000),
(19,10,11,3,28000),(20,10,12,1,32000),
(21,11,1,7,12000),(22,11,9,2,1200),
(23,12,5,1,22000),(24,12,18,2,41000),
(25,13,14,2,15000),(26,13,16,1,38000),
(27,14,10,3,3900),(28,14,8,1,4500),
(29,15,19,2,57000),(30,15,6,1,65000),
(31,16,17,2,11000),(32,16,18,1,41000);

-- COMPROBACIONES RAPIDAS (ejecutar por separado si queres)
-- SELECT * FROM categorias;
-- SELECT * FROM productos;
-- SELECT * FROM clientes;
-- SELECT * FROM sucursales;
-- SELECT * FROM vendedores;
-- SELECT * FROM ventas;
-- SELECT * FROM detalle_ventas;
-- SELECT COUNT(*) AS cantidad_productos FROM productos;
-- SELECT COUNT(*) AS cantidad_ventas_2026 FROM ventas WHERE fecha >= '2026-01-01' AND fecha < '2027-01-01';

-- NOTAS:
-- No se crean las vistas de los ejercicios 5 y 6: son parte de la practica.
-- Los productos 7, 13, 15 y 20 estan inactivos y no tienen ventas.
-- El producto 14 tiene ventas solo en 2025; algunos clientes no tienen ventas en 2026.
-- No todos los productos tienen movimiento, y existen cantidades de venta distintas.
