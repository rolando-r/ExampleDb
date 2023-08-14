CREATE DATABASE tienda;

USE tienda;

CREATE TABLE genero(
    id_genero INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(35)
);

CREATE TABLE tipo_persona(
    id_tipo_persona INT,
    descripcion VARCHAR(30)
);

CREATE TABLE persona(
    id_persona VARCHAR(20),
    nombre VARCHAR(15),
    edad INT,
    id_genero INT,
    id_tipo_persona INT
);

ALTER TABLE tipo_persona
ADD CONSTRAINT pk_id_tipo_persona PRIMARY KEY (id_tipo_persona);

ALTER TABLE persona
ADD CONSTRAINT pk_id_persona PRIMARY KEY (id_persona);

DESCRIBE persona;

ALTER TABLE persona
ADD CONSTRAINT fk_genero_persona FOREIGN KEY (id_genero) REFERENCES genero(id_genero);

ALTER TABLE persona
ADD CONSTRAINT fk_tipo_per_persona FOREIGN KEY (id_tipo_persona) REFERENCES tipo_persona(id_tipo_persona);

CREATE TABLE producto(
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    stock INT,
    stock_min INT,
    stock_max INT,
    estado BOOL,
    precio_venta DOUBLE,
    valor_compra DOUBLE
);

CREATE TABLE factura(
    nro_factura VARCHAR(20) PRIMARY KEY,
    fecha_factura DATETIME,
    id_cliente VARCHAR(20),
    id_empleado VARCHAR(20),
    CONSTRAINT fk_factura_cliente FOREIGN KEY (id_cliente) REFERENCES persona(id_persona),
    CONSTRAINT fk_factura_empleado FOREIGN KEY (id_empleado) REFERENCES persona(id_persona)
);

CREATE TABLE persona_producto(
    id_producto INT,
    id_persona VARCHAR(20),
    CONSTRAINT fk_producto_persona FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT fk_persona_producto FOREIGN KEY (id_persona) REFERENCES persona(id_persona)
);

ALTER TABLE persona_producto
ADD PRIMARY KEY (id_producto, id_persona);

CREATE TABLE detalle_factura(
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    nro_factura VARCHAR(20),
    id_producto INT,
    cantidad INT,
    valor_unitario DOUBLE,
    CONSTRAINT fk_detalle_factura FOREIGN KEY (nro_factura) REFERENCES factura(nro_factura)
);

INSERT INTO genero(descripcion)
VALUES ("MASCULINO"),("FEMENINO"), ("OTROS");

INSERT INTO tipo_persona(descripcion)
VALUES ("EMPLEADO"),("CLIENTE"),("PROVEEDOR"); 

ALTER TABLE tipo_persona CHANGE id_tipo_persona id_tipo_persona INT AUTO_INCREMENT;

ALTER TABLE persona DROP FOREIGN KEY fk_tipo_per_persona;

+-----------------+-------------+------+-----+---------+-------+
| Field           | Type        | Null | Key | Default | Extra |
+-----------------+-------------+------+-----+---------+-------+
| id_persona      | varchar(20) | NO   | PRI | NULL    |       |
| nombre          | varchar(50) | YES  |     | NULL    |       |
| edad            | int         | YES  |     | NULL    |       |
| id_genero       | int         | YES  | MUL | NULL    |       |
| id_tipo_persona | int         | YES  | MUL | NULL    |       |
+-----------------+-------------+------+-----+---------+-------+
;
INSERT INTO persona(id_persona, nombre, edad, id_genero, id_tipo_persona)
VALUES ('10050', 'LUIS CARLOS', 22, 1, 2),
('1095', 'ANGEL GABRIEL', 18, 1, 1),
('1098', 'CAMILO HERNANDEZ', 25, 1, 2),
('1419', 'SICER BRITO', 19, 1, 1),
('1009', 'KAREN SOFIA', 17, 2, 3),
('1027', 'KEVIN ARCE', 19, 1, 2),
('1314', 'JULIAN SANABRIA', 19, 1, 2),
('1066', 'ROLANDO RODRIGUEZ', 17, 1, 3),
('1089', 'MARIA ANGELICA', 25, 2, 1),
('1005', 'TATIANA', 21, 2, 3),
('1193', 'JUAN', 22, 1, 3),
('1096', 'ERICK', 29, 1, 2),
('1102', 'FABIAN', 18, 1, 1),
('9129', 'JOHLVER PARDO', 42, 1, 3);

CREATE TABLE categoria(
    id_categoria INT NOT NULL AUTO_INCREMENT,
    Descripcion VARCHAR(30) NOT NULL,
    CONSTRAINT pk_categoria PRIMARY KEY (id_categoria)
);

ALTER TABLE producto
ADD id_categoria INT;

ALTER TABLE producto
ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria);

INSERT INTO categoria (Descripcion) VALUES ("ABARROTES");

INSERT INTO categoria (Descripcion) VALUES ("TECNOLOGIA"), ("LACTEOS"), ("CARNICOS"), ("SALSA"), ("ASEO PERSONAL"), ("HOGAR");

INSERT INTO producto (nombre, stock, stock_min, stock_max, estado, precio_venta, valor_compra, id_categoria)
VALUES ('YOX', 155, 100, 555, 1, 5000.0, 4000.0, 2),
('POLVO HORNEAR', 100, 100, 200, 1, 6000.0, 3000.0, 7),
('AURICULARES', 200, 300, 600, 1, 12000.0, 10000.0, 1),
('HUEVOS KIDS', 30, 20, 40, 1, 18000.0, 16000.0, 3),
('SOFLAN 1000ml', 300, 150, 400, 1, 20000.0, 17000.0, 6),
('MEMORIA RAM DDR5', 20, 5, 30, 1, 800000.0, 700000.0, 1),
('ASPIRAMAX 5000', 15, 30, 55, 1, 300000.0, 250000.0, 6);

+-------------+---------------+
| IdCategoria | Descripcion   |
+-------------+---------------+
|           1 | TECNOLOGIA    |
|           2 | LACTEOS       |
|           3 | CARNICOS      |
|           4 | SALSA         |
|           5 | ASEO PERSONAL |
|           6 | HOGAR         |
|           7 | ABARROTES     |
+-------------+---------------+
+--------------+-------------+------+-----+---------+----------------+
| Field        | Type        | Null | Key | Default | Extra          |
+--------------+-------------+------+-----+---------+----------------+
| id_producto  | int         | NO   | PRI | NULL    | auto_increment |
| nombre       | varchar(50) | YES  |     | NULL    |                |
| stock        | int         | YES  |     | NULL    |                |
| stock_min    | int         | YES  |     | NULL    |                |
| stock_max    | int         | YES  |     | NULL    |                |
| estado       | tinyint(1)  | YES  |     | NULL    |                |
| precio_venta | double      | YES  |     | NULL    |                |
| valor_compra | double      | YES  |     | NULL    |                |
| IdCategoria  | int         | YES  | MUL | NULL    |                |
+--------------+-------------+------+-----+---------+----------------+
;