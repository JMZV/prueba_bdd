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

/* insertar los siguientes registros:
    5 clientes
    8 productos
    3 categorias
    
*/


INSERT INTO cliente (nombre, rut, direccion) 
VALUES ('jose','111111111','san jose 111'),
('joaquin','222222222','san joaquin 222'),
('diego','333333333','san diego 333'),
('ruben','444444444','san ruben 444'),
('sebastian','555555555','san sebastian 555');

INSERT INTO categoria (nombre, descripcion)
VALUES ('categoria1','primera categoria de productos disponible'),
('categoria2','segunda categoria de productos disponible'),
('categoria3','tercera categoria de productos disponible');

INSERT INTO producto (nombre, descripcion, valor_unitario)
VALUES ('producto1','primer producto del listado','1000'),
('producto2','segundo producto del listado','2000'),
('producto3','tercer producto del listado','3000'),
('producto4','cuarto producto del listado','4000'),
('producto5','quinto producto del listado','5000'),
('producto6','sexto producto del listado','6000'),
('producto7','septimo producto del listado','7000'),
('producto8','octavo producto del listadi','8000');


INSERT INTO productocategoria (producto_id,categoria_id)
VALUES (1,1),(2,1),(3,1),(4,2),(5,2),(6,2),(7,3),(8,3);


/*
10 facturas

    2 para el cliente 1, con 2 y 3 productos
    3 para el cliente 2, con 3, 2 y 3 productos
    1 para el cliente 3, con 1 producto
    4 para el cliente 4, con 2, 3, 4 y 1 producto */


INSERT INTO factura (fecha) VALUES (CURRENT_TIMESTAMP);
INSERT INTO facturacliente (num_factura, cliente_id) VALUES (1,1);
INSERT INTO listadofactura (num_factura, producto_id, cantidad) VALUES (1,1,1),(1,2,1);
INSERT INTO factura (fecha) VALUES (CURRENT_TIMESTAMP);
INSERT INTO facturacliente (num_factura, cliente_id) VALUES (2,1);
INSERT INTO listadofactura (num_factura, producto_id,cantidad) VALUES (2,1,1),(2,2,1),(2,3,1);

INSERT INTO factura (fecha) VALUES (CURRENT_TIMESTAMP);
INSERT INTO facturacliente (num_factura, cliente_id) VALUES (3, 2);
INSERT INTO listadofactura (num_factura, producto_id, cantidad) VALUES (3,1,1),(3,2,1),(3,3,1);
INSERT INTO factura (fecha) VALUES (CURRENT_TIMESTAMP);
INSERT INTO facturacliente (num_factura, cliente_id) VALUES (4, 2);
INSERT INTO listadofactura (num_factura, producto_id, cantidad) VALUES (4,1,1),(4,2,1);
INSERT INTO factura (fecha) VALUES (CURRENT_TIMESTAMP);
INSERT INTO facturacliente (num_factura, cliente_id) VALUES (5, 2);
INSERT INTO listadofactura (num_factura, producto_id, cantidad) VALUES (5,1,1),(5,2,1),(5,3,1);

INSERT INTO factura (fecha) VALUES (CURRENT_TIMESTAMP);
INSERT INTO facturacliente (num_factura, cliente_id) VALUES (6, 3);
INSERT INTO listadofactura (num_factura, producto_id, cantidad) VALUES (6,1,1);

INSERT INTO factura (fecha) VALUES (CURRENT_TIMESTAMP);
INSERT INTO facturacliente (num_factura, cliente_id) VALUES (7, 4);
INSERT INTO listadofactura (num_factura, producto_id, cantidad) VALUES (7,1,1),(7,2,1);
INSERT INTO factura (fecha) VALUES (CURRENT_TIMESTAMP);
INSERT INTO facturacliente (num_factura, cliente_id) VALUES (8, 4);
INSERT INTO listadofactura (num_factura, producto_id, cantidad) VALUES (8,1,1),(8,2,1),(8,3,1);
INSERT INTO factura (fecha) VALUES (CURRENT_TIMESTAMP);
INSERT INTO facturacliente (num_factura, cliente_id) VALUES (9, 4);
INSERT INTO listadofactura (num_factura, producto_id, cantidad) VALUES (9,1,1),(9,2,1),(9,3,1),(9,4,1);
INSERT INTO factura (fecha) VALUES (CURRENT_TIMESTAMP);
INSERT INTO facturacliente (num_factura, cliente_id) VALUES (10, 4);
INSERT INTO listadofactura (num_factura, producto_id, cantidad) VALUES (10,1,1);

/* se insertan totales en tabla listadofactura, ya que no se poner valores derivados

update listadofactura set total=1000 where id=1;
update listadofactura set total=2000 where id=2;
update listadofactura set total=1000 where id=3;
update listadofactura set total=2000 where id=4;
update listadofactura set total=3000 where id=5;
update listadofactura set total=1000 where id=6;
update listadofactura set total=2000 where id=7;
update listadofactura set total=3000 where id=8;
update listadofactura set total=1000 where id=9;
update listadofactura set total=2000 where id=10;
update listadofactura set total=1000 where id=11;
update listadofactura set total=2000 where id=12;
update listadofactura set total=3000 where id=13;
update listadofactura set total=1000 where id=14;
update listadofactura set total=1000 where id=15;
update listadofactura set total=2000 where id=16;
update listadofactura set total=1000 where id=17;
update listadofactura set total=2000 where id=18;
update listadofactura set total=3000 where id=19;
update listadofactura set total=1000 where id=20;
update listadofactura set total=2000 where id=21;
update listadofactura set total=3000 where id=22;
update listadofactura set total=4000 where id=23;
update listadofactura set total=1000 where id=24;


luego

select num_factura, sum(total) from listadofactura group by num_factura;

 num_factura |  sum  
-------------+-------
           9 | 10000
           3 |  6000
           5 |  6000
           4 |  3000
          10 |  1000
           6 |  1000
           2 |  6000
           7 |  3000
           1 |  3000
           8 |  6000

luego con datos anteriores se actualiza tabla factura

 numero |   fecha    | subtotal | iva | total 
--------+------------+----------+-----+-------
     10 | 2020-09-27 |     1000 |     |      
      9 | 2020-09-27 |    10000 |     |      
      8 | 2020-09-27 |     6000 |     |      
      7 | 2020-09-27 |     3000 |     |      
      6 | 2020-09-27 |     1000 |     |      
      5 | 2020-09-27 |     6000 |     |      
      4 | 2020-09-27 |     3000 |     |      
      3 | 2020-09-27 |     6000 |     |      
      2 | 2020-09-27 |     6000 |     |      
      1 | 2020-09-27 |     3000 |     |      

y tambien sus valores derivados

 numero |   fecha    | subtotal | iva  | total 
--------+------------+----------+------+-------
     10 | 2020-09-27 |     1000 |  180 |  1180
      9 | 2020-09-27 |    10000 | 1800 | 11800
      8 | 2020-09-27 |     6000 | 1080 |  7080
      7 | 2020-09-27 |     3000 |  540 |  3540
      6 | 2020-09-27 |     1000 |  180 |  1180
      5 | 2020-09-27 |     6000 | 1080 |  7080
      4 | 2020-09-27 |     3000 |  540 |  3540
      3 | 2020-09-27 |     6000 | 1080 |  7080
      2 | 2020-09-27 |     6000 | 1080 |  7080
      1 | 2020-09-27 |     3000 |  540 |  3540

consulta mayor monto de facturas de un cliente:

SELECT cliente.nombre, SUM(total) FROM factura
INNER JOIN facturacliente ON factura.numero=facturacliente.num_factura 
INNER JOIN cliente ON cliente.id=facturacliente.cliente_id GROUP BY cliente.nombre ORDER BY sum DESC LIMIT 1;


*/

--Consultas: ¿Que cliente realizó la compra más cara?   Consulta devuelve nombre de cliente con la factura de mayor valor

SELECT cliente.nombre FROM factura
INNER JOIN facturacliente ON factura.numero=facturacliente.num_factura 
INNER JOIN cliente ON cliente.id=facturacliente.cliente_id ORDER BY total DESC LIMIT 1;

--¿Que cliente pagó sobre 100 de monto? Consulta devuelve los clientes con facturas de malor mayor a 100

SELECT DISTINCT cliente.nombre FROM factura
INNER JOIN facturacliente ON factura.numero=facturacliente.num_factura 
INNER JOIN cliente ON cliente.id=facturacliente.cliente_id WHERE total>100;

--¿Cuantos clientes han comprado el producto 6?     Consulta devuelve la cantidad de clientes que en su factura tienen el producto  

SELECT COUNT(*) FROM (SELECT DISTINCT (con.nombre) FROM (SELECT nombre, numero, facturacliente.cliente_id FROM listadofactura 
INNER JOIN factura ON factura.numero=listadofactura.num_factura 
INNER JOIN facturacliente ON facturacliente.num_factura=factura.numero 
INNER JOIN cliente ON facturacliente.cliente_id=cliente.id WHERE producto_id=6) AS con) AS cons;




