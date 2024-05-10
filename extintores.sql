CREATE TABLE ubicaciones (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) UNIQUE
);

CREATE TABLE proveedores (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) UNIQUE,
    telefono VARCHAR(15) NULL,
    correo VARCHAR(100) NULL
);

CREATE TABLE tipos (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) UNIQUE
);
CREATE TABLE extintores (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    capacidad INT UNSIGNED,
    fechafabricacion DATE,
    estado VARCHAR(50),
    idtipo INT UNSIGNED,
    idubicacion INT UNSIGNED,
    idproveedor INT UNSIGNED,
    FOREIGN KEY (idtipo) REFERENCES tipos(id),
    FOREIGN KEY (idubicacion) REFERENCES ubicaciones(id),
    FOREIGN KEY (idproveedor) REFERENCES proveedores(id)
);

CREATE TABLE inspecciones (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    idextintor INT UNSIGNED,
    fecha DATE,
    proximainspeccion DATE,
    FOREIGN KEY (idextintor) REFERENCES extintores(id)
);

CREATE TABLE recargas (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    idextintor INT UNSIGNED,
    fecha DATE,
    proximarecarga DATE,
    FOREIGN KEY (idextintor) REFERENCES extintores(id)
);
------------------------------------------------------------------------
SELECT ubicacion, COUNT(*) AS cantidad_extintores
FROM tabla_extintores
GROUP BY ubicacion;

SELECT tipo_extintor, SUM(capacidad) AS suma_capacidades
FROM tabla_extintores
GROUP BY tipo_extintor;

SELECT id_extintor, COUNT(*) AS numero_inspecciones
FROM tabla_inspecciones
GROUP BY id_extintor;

SELECT proveedor, SUM(e.capacidad) AS suma_capacidades
FROM tabla_extintores AS e
INNER JOIN tabla_proveedores AS p ON e.id_proveedor = p.id_proveedor
WHERE e.fecha_suministro BETWEEN '2024-01-01' AND '2024-05-01'
GROUP BY proveedor;

SELECT COUNT(*) AS numero_recargas
FROM tabla_recargas AS r
INNER JOIN (
    SELECT id_extintor, MAX(fecha_inspeccion) AS ultima_inspeccion
    FROM tabla_inspecciones
    GROUP BY id_extintor
) AS ultimas_inspecciones ON r.id_extintor = ultimas_inspecciones.id_extintor
WHERE ultimas_inspecciones.ultima_inspeccion < DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH);

SELECT COUNT(DISTINCT i.extintor_id) AS cantidad_inspecciones
FROM inspecciones i
JOIN recargas r ON i.extintor_id = r.extintor_id
WHERE r.fecha_recarga >= DATEADD(year, -1, GETDATE())
GROUP BY i.extintor_id
HAVING COUNT(DISTINCT r.id_recarga) >= 2;

SELECT AVG(capacidad) AS promedio_capacidades
FROM (
    SELECT e.capacidad
    FROM tabla_extintores AS e
    INNER JOIN (
        SELECT id_extintor, COUNT(*) AS numero_recargas
        FROM tabla_recargas
        GROUP BY id_extintor
        HAVING numero_recargas > 3
    ) AS recargas_extintores ON e.id_extintor = recargas_extintores.id_extintor
) AS extintores_con_recargas;

SELECT AVG(capacidad) AS promedio_capacidades
FROM (
    SELECT e.capacidad
    FROM tabla_extintores AS e
    INNER JOIN (
        SELECT id_extintor, COUNT(*) AS numero_recargas
        FROM tabla_recargas
        GROUP BY id_extintor
        HAVING numero_recargas > 3
    ) AS recargas_extintores ON e.id_extintor = recargas_extintores.id_extintor
) AS extintores_con_recargas;