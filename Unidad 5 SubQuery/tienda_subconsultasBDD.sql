DROP DATABASE IF EXISTS tienda_subconsultas;
CREATE DATABASE tienda_subconsultas;
USE tienda_subconsultas;

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    ciudad VARCHAR(80) NOT NULL,
    edad INT NOT NULL
);

CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    categoria VARCHAR(80) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE detalle_ventas (
    id_detalle INT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

INSERT INTO clientes VALUES
(1, 'Ana', 'Mar del Plata', 25),
(2, 'Bruno', 'Balcarce', 31),
(3, 'Carla', 'Mar del Plata', 22),
(4, 'Diego', 'Tandil', 40),
(5, 'Elena', 'Balcarce', 29),
(6, 'Federico', 'Mar del Plata', 35);

INSERT INTO productos VALUES
(1, 'Teclado', 'Tecnologia', 18000),
(2, 'Mouse', 'Tecnologia', 9500),
(3, 'Monitor', 'Tecnologia', 120000),
(4, 'Silla', 'Muebles', 85000),
(5, 'Escritorio', 'Muebles', 160000),
(6, 'Cuaderno', 'Libreria', 3500),
(7, 'Lapicera', 'Libreria', 2200),
(8, 'Mochila', 'Libreria', 28000);

INSERT INTO ventas VALUES
(1, 1, '2026-05-01'),
(2, 2, '2026-05-03'),
(3, 1, '2026-05-07'),
(4, 4, '2026-05-10'),
(5, 6, '2026-05-12');

INSERT INTO detalle_ventas VALUES
(1, 1, 1, 1, 18000),
(2, 1, 2, 2, 9500),
(3, 2, 4, 1, 85000),
(4, 3, 3, 1, 120000),
(5, 4, 5, 1, 160000),
(6, 5, 2, 1, 9500),
(7, 5, 6, 4, 3500);