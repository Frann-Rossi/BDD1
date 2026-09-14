CREATE DATABASE IF NOT EXISTS  prueba_joins
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE prueba_joins;

CREATE TABLE categorias (
    id_categoria INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE proveedores (
    id_proveedor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_proveedor VARCHAR(80) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE productos (
    id_producto INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    id_categoria INT UNSIGNED NULL,
    id_proveedor INT UNSIGNED NULL,
    CONSTRAINT fk_productos_categoria
        FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    CONSTRAINT fk_productos_proveedor
        FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);

CREATE TABLE clientes (
    id_cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(80) NOT NULL,
    email VARCHAR(120) NOT NULL
);

INSERT INTO categorias (nombre_categoria) VALUES
('Alimento'),
('Tecnología'),
('Limpieza'),
('Accesorios');

INSERT INTO proveedores (nombre_proveedor, email) VALUES
('Tecno Sur', 'contacto@tecnosur.com'),
('Distribuidora Central', 'ventas@central.com'),
('Mercado Norte', 'pedidos@norte.com'),
('Proveedor sin productos', 'info@sinproductos.com');

INSERT INTO productos
(nombre, precio, activo, id_categoria, id_proveedor)
VALUES
('Laptop', 850000.00, TRUE, 2, 1),
('Yerba 1 kg', 6200.00, TRUE, 1, 3),
('Termómetro digital', 18500.00, TRUE, NULL, 2),
('Mouse inalámbrico', 24999.90, TRUE, 4, 1),
('Cable HDMI', 9500.00, TRUE, 4, NULL),
('Teclado mecánico', 79900.00, FALSE, 2, 1);

INSERT INTO clientes (nombre_cliente, email) VALUES
('Ana Gómez', 'ana@correo.com'),
('Bruno Díaz', 'bruno@correo.com'),
('Tecno Sur', 'contacto@tecnosur.com');