//Camilo Andres Mañosca Burbano
Angie Michel Cardenas Belalcazar
Joisy Pamela Rodallega//

-- Tabla para los Extintores
CREATE TABLE extintor (
    id integer unsigned PRIMARY KEY AUTO_INCREMENT,
    numero_serie VARCHAR(50) unique,
    tipo VARCHAR(10),
    capacidad DECIMAL(2,1) unsigned,
    fecha_inspeccion DATE,
    idproveedor integer unsigned,
    idsalon integer unsigned,
    FOREIGN KEY (idproveedor) REFERENCES proveedor(id),
    FOREIGN KEY (idsalon) REFERENCES salon(id)
);

-- Tabla para los Salones
CREATE TABLE salon (
    id INT unsigned PRIMARY KEY AUTO_INCREMENT,
    numero_salon VARCHAR(20) unique,
    ubicacion VARCHAR(100),
    piso INT unsigned
);

-- Tabla para los Proveedores
CREATE TABLE proveedor (
    id INT unsigned PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) unique,
    direccion VARCHAR(100),
    telefono VARCHAR(20)
);

-- Datos para la tabla "Extintor"
INSERT INTO Extintor (id, numero_serie, tipo, capacidad, fecha_inspeccion, idproveedor, idsalon) VALUES
(NULL, 'EXT123456', 'CO2', 5, '2023-04-15', 1, 1),
(NULL, 'EXT789012', 'PQ', 10, '2023-03-20', 2, 2),
(NULL, 'EXT345678', 'ABC', 5, '2023-05-10', 1, 1),
(NULL, 'EXT901234', 'PQ', 10, '2023-04-30', 3, 3),
(NULL, 'EXT567890', 'ABC', 5, '2023-06-05', 2, 2);

-- Datos para la tabla "Salon"
INSERT INTO Salon (id, numero_salon, ubicacion, piso) VALUES
(NULL, 'A101', 'Edificio A, Primer Piso', 1),
(NULL, 'B202', 'Edificio B, Segundo Piso', 2),
(NULL, 'C303', 'Edificio C, Tercer Piso', 3),
(NULL, 'D404', 'Edificio D, Cuarto Piso', 4),
(NULL, 'E505', 'Edificio E, Quinto Piso', 5);

-- Datos para la tabla "Proveedor"
INSERT INTO Proveedor (id, nombre, direccion, telefono) VALUES
(NULL, 'Extintores ABC', 'Calle Principal #123', '555-1234'),
(NULL, 'Seguridad Incendios S.A.', 'Avenida Central #456', '555-5678'),
(NULL, 'Prevención de Riesgos Ltda.', 'Carrera Norte #789', '555-9012'),
(NULL, 'Extintores Seguros', 'Calle Sur #1011', '555-3456'),
(NULL, 'Protección Integral', 'Avenida Este #1213', '555-7890');


