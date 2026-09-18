CREATE DATABASE IF NOT EXISTS tp7_agregacion
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE tp7_agregacion;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    ciudad VARCHAR(60) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha DATE NOT NULL,
    estado ENUM('Pendiente', 'Pagado', 'Cancelado') NOT NULL,
    canal ENUM('Web', 'Local', 'Telefonico') NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    observaciones VARCHAR(200) NULL,
    CONSTRAINT fk_pedidos_clientes
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
) ENGINE = InnoDB;

INSERT INTO clientes (nombre, ciudad) VALUES
('Ana Torres', 'Mar del Plata'),
('Bruno Díaz', 'Mar del Plata'),
('Carla Ruiz', 'Balcarce'),
('Diego Suárez', 'Mar del Plata'),
('Elena Gómez', 'Miramar'),
('Facundo López', 'Balcarce'),
('Gabriela Pérez', 'Mar del Plata'),
('Hugo Martínez', 'Miramar');

INSERT INTO pedidos (id_cliente, fecha, estado, canal, total, observaciones) VALUES
(1, '2026-08-01', 'Pagado',    'Web',        50000,  NULL),
(1, '2026-08-05', 'Pagado',    'Local',      30000,  ''),
(1, '2026-08-12', 'Cancelado', 'Web',        20000,  NULL),
(2, '2026-08-02', 'Pagado',    'Web',        80000,  'Entrega tarde'),
(2, '2026-08-09', 'Pendiente', 'Telefonico', 45000,  NULL),
(2, '2026-08-16', 'Pagado',    'Web',        60000,  NULL),
(3, '2026-08-03', 'Pagado',    'Local',     120000,  'Cliente VIP'),
(3, '2026-08-10', 'Pagado',    'Local',      90000,  NULL),
(3, '2026-08-18', 'Pagado',    'Web',        30000,  ''),
(4, '2026-08-04', 'Pendiente', 'Web',        70000,  NULL),
(4, '2026-08-11', 'Pagado',    'Local',     110000,  NULL),
(4, '2026-08-20', 'Pagado',    'Telefonico', 40000,  'Retira en local'),
(5, '2026-08-06', 'Cancelado', 'Web',        25000,  NULL),
(5, '2026-08-13', 'Pagado',    'Web',       150000,  NULL),
(5, '2026-08-22', 'Pagado',    'Local',      50000,  ''),
(6, '2026-08-07', 'Pagado',    'Web',        65000,  NULL),
(6, '2026-08-14', 'Pagado',    'Web',        65000,  NULL),
(6, '2026-08-23', 'Pendiente', 'Local',      35000,  NULL),
(7, '2026-08-08', 'Pagado',    'Local',     200000,  NULL),
(7, '2026-08-15', 'Pagado',    'Web',       100000,  NULL),
(7, '2026-08-24', 'Pagado',    'Web',       100000,  NULL);