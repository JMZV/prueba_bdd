--CREATE DATABASE prueba;
--\c prueba
CREATE TABLE factura (numero SERIAL,
fecha DATE, subtotal INT, iva INT, total INT,
PRIMARY KEY (numero));

CREATE TABLE producto(id SERIAL, 
nombre VARCHAR(30), 
descripcion VARCHAR(150),
valor_unitario INT, PRIMARY KEY (id) );

CREATE TABLE cliente (id SERIAL, 
nombre VARCHAR(30), 
rut VARCHAR(9),
direccion VARCHAR(50), PRIMARY KEY (id));

CREATE TABLE categoria (id SERIAL, nombre VARCHAR(40),
descripcion VARCHAR(100), PRIMARY KEY (id));

CREATE TABLE facturacliente (num_factura INT, cliente_id INT,
FOREIGN KEY (num_factura) REFERENCES factura(numero),
FOREIGN KEY (cliente_id) REFERENCES cliente(id));

CREATE TABLE listadofactura (id SERIAL,
num_factura INT, producto_id INT,
cantidad SMALLINT, total INT,
FOREIGN KEY (num_factura) REFERENCES factura(numero),
FOREIGN KEY (producto_id) REFERENCES producto(id));

CREATE TABLE productocategoria (producto_id INT, categoria_id INT,
FOREIGN KEY (producto_id) REFERENCES producto(id),
FOREIGN KEY (categoria_id) REFERENCES categoria(id));