DROP DATABASE IF EXISTS tp_integrador_consultas;
CREATE DATABASE tp_integrador_consultas
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE tp_integrador_consultas;

CREATE TABLE sucursales (
    id_sucursal INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    ciudad VARCHAR(80) NOT NULL
);

CREATE TABLE vendedores (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_sucursal INT NOT NULL,
    fecha_ingreso DATE NOT NULL,
    FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal)
);

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(80) NOT NULL,
    tipo VARCHAR(20) NOT NULL
);

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    activo TINYINT(1) NOT NULL DEFAULT 1,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
);

CREATE TABLE detalle_ventas (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

INSERT INTO sucursales (nombre, ciudad) VALUES
('Centro', 'Mar del Plata'),
('Puerto', 'Mar del Plata'),
('Balcarce', 'Balcarce');

INSERT INTO vendedores (nombre, id_sucursal, fecha_ingreso) VALUES
('Lucia Ferrer', 1, '2021-03-15'),
('Martin Quiroga', 1, '2023-08-01'),
('Paula Ibarra', 2, '2020-11-10'),
('Diego Salas', 2, '2024-02-20'),
('Camila Torres', 3, '2022-06-05');

INSERT INTO clientes (nombre, ciudad, tipo) VALUES
('Alfa Servicios', 'Mar del Plata', 'EMPRESA'),
('Bruno Lopez', 'Mar del Plata', 'PARTICULAR'),
('Estudio Norte', 'Balcarce', 'EMPRESA'),
('Carolina Diaz', 'Miramar', 'PARTICULAR'),
('Delta Obras', 'Mar del Plata', 'EMPRESA'),
('Federico Luna', 'Necochea', 'PARTICULAR'),
('Gamma Tech', 'Balcarce', 'EMPRESA'),
('Helena Ruiz', 'Mar del Plata', 'PARTICULAR');

INSERT INTO categorias (nombre) VALUES
('Computacion'),
('Perifericos'),
('Oficina'),
('Redes'),
('Impresion');

INSERT INTO productos (nombre, id_categoria, precio, activo) VALUES
('Notebook Pro 14', 1, 1250000.00, 1),
('Mini PC', 1, 680000.00, 1),
('Mouse Inalambrico', 2, 32000.00, 1),
('Teclado Mecanico', 2, 95000.00, 1),
('Monitor 27', 2, 310000.00, 1),
('Silla Ergonomica', 3, 285000.00, 1),
('Escritorio Compacto', 3, 210000.00, 1),
('Router AX', 4, 145000.00, 1),
('Switch 8 Puertos', 4, 98000.00, 1),
('Impresora Laser', 5, 390000.00, 1),
('Scanner A4', 5, 260000.00, 0),
('Webcam HD', 2, 76000.00, 1);

INSERT INTO ventas (fecha, id_cliente, id_vendedor) VALUES
('2026-03-04', 1, 1),
('2026-03-07', 2, 2),
('2026-03-18', 3, 5),
('2026-04-02', 1, 1),
('2026-04-10', 4, 3),
('2026-04-21', 5, 4),
('2026-05-03', 6, 3),
('2026-05-14', 7, 5),
('2026-05-28', 2, 2),
('2026-06-06', 5, 1),
('2026-06-19', 8, 4),
('2026-07-01', 3, 5),
('2026-07-12', 1, 2),
('2026-08-08', 7, 5),
('2026-08-23', 4, 3),
('2026-09-05', 5, 1),
('2026-09-18', 2, 4),
('2026-10-02', 1, 1);

INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 1, 1250000.00),
(1, 3, 3, 32000.00),
(2, 4, 1, 95000.00),
(2, 12, 1, 76000.00),
(3, 8, 2, 145000.00),
(3, 9, 2, 98000.00),
(4, 5, 2, 310000.00),
(5, 6, 1, 285000.00),
(5, 7, 1, 210000.00),
(6, 10, 1, 390000.00),
(6, 3, 4, 32000.00),
(7, 12, 2, 76000.00),
(8, 2, 1, 680000.00),
(8, 8, 1, 145000.00),
(9, 3, 2, 32000.00),
(9, 4, 1, 95000.00),
(10, 1, 1, 1190000.00),
(10, 9, 3, 95000.00),
(11, 5, 1, 305000.00),
(12, 10, 2, 385000.00),
(13, 6, 2, 280000.00),
(13, 3, 2, 30000.00),
(14, 2, 2, 670000.00),
(15, 7, 1, 205000.00),
(15, 12, 2, 74000.00),
(16, 8, 3, 140000.00),
(16, 9, 2, 94000.00),
(17, 4, 2, 92000.00),
(17, 12, 1, 75000.00),
(18, 1, 1, 1210000.00),
(18, 5, 1, 300000.00);
