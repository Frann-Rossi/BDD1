CREATE DATABASE IF NOT EXISTS practica_der_ventas
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE practica_der_ventas;
SET NAMES utf8mb4;


CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE productos (
    producto_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(50) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
) ENGINE = InnoDB;

CREATE TABLE pedidos (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    CONSTRAINT fk_pedidos_cliente
        FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
) ENGINE = InnoDB;

CREATE TABLE detalle_pedido (
    detalle_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT fk_detalle_pedido
        FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id),
    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
) ENGINE = InnoDB;

CREATE TABLE alertas_stock (
    alerta_id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    stock_actual INT NOT NULL,
    fecha_alerta DATETIME NOT NULL,
    CONSTRAINT fk_alertas_producto
        FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
) ENGINE = InnoDB;

CREATE TABLE auditoria_operaciones (
    auditoria_op_id INT AUTO_INCREMENT PRIMARY KEY,
    categoria VARCHAR(50) NOT NULL,
    fecha_operacion DATETIME NOT NULL,
    cantidad_productos_actualizados INT NOT NULL
) ENGINE = InnoDB;

CREATE TABLE auditoria_errores (
    auditoria_id INT AUTO_INCREMENT PRIMARY KEY,
    procedimiento VARCHAR(100) NOT NULL,
    operacion VARCHAR(100) NOT NULL,
    mensaje_error VARCHAR(255) NOT NULL,
    fecha_error DATETIME NOT NULL
) ENGINE = InnoDB;


SET @fecha_base = CURDATE();
SET @inicio_ultimo_anio = DATE_SUB(@fecha_base, INTERVAL 1 YEAR);

INSERT INTO clientes (cliente_id, nombre, apellido, ciudad, email) VALUES
(1, 'Lucía', 'Martínez', 'Madrid', 'lucia@example.com'),
(2, 'Mateo', 'López', 'Barcelona', 'mateo@example.com'),
(3, 'Sofía', 'Fernández', 'Valencia', 'sofia@example.com'),
(4, 'Diego', 'Pérez', 'Madrid', 'diego@example.com'),
(5, 'Valentina', 'Torres', 'Sevilla', 'valentina@example.com'),
(6, 'Tomás', 'Ruiz', 'Madrid', 'tomas@example.com'),
(7, 'Camila', 'Gómez', 'Barcelona', 'camila@example.com'),
(8, 'Nicolás', 'Díaz', 'Valencia', 'nicolas@example.com');

INSERT INTO productos
(producto_id, nombre_producto, categoria, precio, stock) VALUES
(1, 'Notebook', 'Electronicos', 1000.00, 8),
(2, 'Monitor', 'Electronicos', 200.00, 10),
(3, 'Teclado', 'Electronicos', 50.00, 30),
(4, 'Mouse', 'Electronicos', 20.00, 45),
(5, 'Auriculares', 'Electronicos', 100.00, 20),
(6, 'Webcam', 'Electronicos', 80.00, 12),
(7, 'Cuaderno', 'Papeleria', 10.00, 200),
(8, 'Silla', 'Muebles', 150.00, 10),
(9, 'Lápiz', 'Papeleria', 5.00, 150);


INSERT INTO pedidos (pedido_id, cliente_id, fecha_pedido) VALUES
(1, 1, DATE_SUB(@fecha_base, INTERVAL 30 DAY)),
(2, 1, @inicio_ultimo_anio),
(3, 1, DATE_SUB(@inicio_ultimo_anio, INTERVAL 1 DAY)),
(4, 2, DATE_SUB(@fecha_base, INTERVAL 20 DAY)),
(5, 2, DATE_SUB(@fecha_base, INTERVAL 5 DAY)),
(6, 3, DATE_SUB(@fecha_base, INTERVAL 15 DAY)),
(7, 3, DATE_SUB(@fecha_base, INTERVAL 3 DAY)),
(8, 4, DATE_SUB(@fecha_base, INTERVAL 12 DAY)),
(9, 4, DATE_SUB(@fecha_base, INTERVAL 4 DAY)),
(10, 7, DATE_SUB(@fecha_base, INTERVAL 18 DAY)),
(11, 7, DATE_SUB(@fecha_base, INTERVAL 8 DAY)),
(12, 7, DATE_SUB(@fecha_base, INTERVAL 1 DAY)),
(13, 8, DATE_SUB(@inicio_ultimo_anio, INTERVAL 2 MONTH)),
(14, 6, DATE_SUB(@fecha_base, INTERVAL 2 DAY));

INSERT INTO detalle_pedido
(detalle_id, pedido_id, producto_id, cantidad) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 3, 4),
(4, 2, 4, 5),
(5, 2, 5, 1),
(6, 3, 2, 1),
(7, 4, 2, 4),
(8, 4, 5, 2),
(9, 5, 3, 6),
(10, 5, 4, 10),
(11, 5, 8, 2),
(12, 6, 7, 80),
(13, 6, 2, 2),
(14, 7, 3, 2),
(15, 8, 7, 36),
(16, 9, 8, 1),
(17, 10, 5, 1),
(18, 11, 5, 1),
(19, 13, 1, 6);