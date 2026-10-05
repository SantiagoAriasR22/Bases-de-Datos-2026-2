use taller_;

create table PROVEEDOR
(CODIGO_PROV INTEGER primary key,
NOMBRE_PROV VARCHAR(20) not null,
DIRECCION VARCHAR(20) not null,
TELEFONO VARCHAR(20) not null,
CIUDAD VARCHAR(20) not null);

create table COMPRA
(NO_COMPRA INTEGER primary key,
CODIGO_PROV INTEGER not null,
FECHA_COMPRA DATE not null,
FECHA_ENTREGA DATE not null,
constraint FK_COMPRA_PROVEEDOR foreign key (CODIGO_PROV) references PROVEEDOR
(CODIGO_PROV));

create table REPUESTOS
(CODIGO_REP INTEGER PRIMARY KEY,
NOMBRE_REP VARCHAR(20) not null,
PRESENTACION VARCHAR(20) CHECK (PRESENTACION IN ('CAJA', 'UNIDAD', 'METRO', 'KILO', 'BOLSA')),
VALOR_VENTA DECIMAL(12,2) not null);

create table DETALLE_COMPRA
(NO_COMPRA INTEGER not null,
CODIGO_REP INTEGER not null,
CANTIDAD INTEGER not null,
VALOR_COMPRA DECIMAL(12,2) not null,
constraint PK_REPUESTOS_COMPRA primary key (NO_COMPRA, CODIGO_REP),
constraint FK_COMPRA foreign key (NO_COMPRA) references COMPRA (NO_COMPRA),
constraint FK_REPUESTO foreign key (CODIGO_REP) references REPUESTOS (CODIGO_REP));

-- Insertar los registros en la tabla 
INSERT INTO PROVEEDOR (CODIGO_PROV, NOMBRE_PROV, DIRECCION, TELEFONO, CIUDAD)
VALUES (1, 'BOSCH', 'DIAG 25 #53A-30', '123456', 'BOGOTA'),
		(2, 'SACHS', 'TRANS 40 #30-10', '6543321', 'BARRANQUILLA'),
		(3, 'COCHS', 'CLL 4#10-20', '6475892', 'CARTAGENA');

INSERT INTO COMPRA (NO_COMPRA, CODIGO_PROV, FECHA_COMPRA, FECHA_ENTREGA)
VALUES (10, 1, '2018-03-02', '2018-04-02'),
		(20, 2, '2018-05-07', '2018-07-08'),
		(30, 3, '2018-08-01', '2018-09-01');
        
INSERT INTO REPUESTOS (CODIGO_REP, NOMBRE_REP, PRESENTACION, VALOR_VENTA)
VALUES (2345, 'AMORTIGUADORES', 'UNIDAD', 50000),
		(2447, 'DISCOS DE FRENO', 'CAJA', 100000),
        (1234, 'LLANTA', 'UNIDAD', 250000);
        
INSERT INTO DETALLE_COMPRA (NO_COMPRA, CODIGO_REP, CANTIDAD, VALOR_COMPRA)
VALUES (10, 2345, 30, 5000);

-- Insertar los otros 5 registros adicionales

INSERT INTO PROVEEDOR (CODIGO_PROV, NOMBRE_PROV, DIRECCION, TELEFONO, CIUDAD) VALUES
  (4, 'VALEO', 'CLL 50 #12-40', '3112233', 'MEDELLIN'),
  (5, 'MONROE', 'CRA 15 #80-22', '3158899', 'CALI'),
  (6, 'BREMBO', 'DIAG 10 #45-12', '3204455', 'BOGOTA'),
  (7, 'LUK', 'TRANS 12 #67-89', '3007788', 'BARRANQUILLA'),
  (8, 'MAHLE', 'CRA 70 #33-15', '3189900', 'CARTAGENA');
  
  INSERT INTO REPUESTOS (CODIGO_REP, NOMBRE_REP, PRESENTACION, VALOR_VENTA) VALUES
  (3101, 'FILTRO ACEITE', 'UNIDAD', 35000.00),
  (3102, 'PASTILLAS FRENO', 'CAJA', 180000.00),
  (3103, 'MANGUERA FRENO', 'METRO', 45000.00),
  (3104, 'GRASA CHASIS', 'KILO', 60000.00),
  (3105, 'ARANDELAS', 'BOLSA', 25000.00);
  
  INSERT INTO COMPRA (NO_COMPRA, CODIGO_PROV, FECHA_COMPRA, FECHA_ENTREGA) VALUES
  (40, 4, '2023-01-15', '2023-02-10'),
  (50, 5, '2023-03-20', '2023-04-18'),
  (60, 6, '2023-06-05', '2023-06-25'),
  (70, 7, '2023-09-12', '2023-10-02'),
  (80, 8, '2023-11-01', '2023-12-05');
  
  INSERT INTO DETALLE_COMPRA (NO_COMPRA, CODIGO_REP, CANTIDAD, VALOR_COMPRA) VALUES
  (40, 3101, 50, 2800.00),
  (50, 3102, 20, 14000.00),
  (60, 3103, 100, 3200.00),
  (70, 3104, 15, 4500.00),
  (80, 3105, 40, 1800.00);
  
  SELECT * FROM REPUESTOS;
  
  -- 1. Muestre las distintas ciudades que aparecen en la tabla Proveedores
  SELECT DISTINCT CIUDAD FROM PROVEEDOR;
  
  -- 2. Muestre información en minúscula de los proveedores de nombre terminado por la cadena ‘CHS’ y que se encuentran en la ciudad de BARRANQUILLA o CARTAGENA
  SELECT LOWER(NOMBRE_PROV), LOWER(CIUDAD) FROM PROVEEDOR WHERE NOMBRE_PROV LIKE '%CHS' AND CIUDAD IN ('BARRANQUILLA', 'CARTAGENA');
  
  -- 3. Muestre la primera letra del nombre del proveedor en mayúscula de los proveedores cuya dirección se encuentre en una DIAGONAL o TRANSVERSAL.
  SELECT CONCAT(UPPER(LEFT(NOMBRE_PROV, 1)), LOWER(SUBSTRING(NOMBRE_PROV, 2))) AS NOMBRE_PROV FROM PROVEEDOR WHERE DIRECCION LIKE 'DIAG%' OR DIRECCION LIKE 'TRANS%';
  
  -- 4. Muestre el nombre del producto o repuesto y el precio que tienen una presentación de CAJA y cuyo valor esta entre 150.000 y 250.000 ordenado ascendentemente
  SELECT NOMBRE_REP, VALOR_VENTA FROM REPUESTOS WHERE PRESENTACION='CAJA' AND VALOR_VENTA BETWEEN 150000 AND 250000 ORDER BY VALOR_VENTA ASC;
  
  -- 5. Muestre el código del producto, el nombre en minúscula, las primeras tres letras de la unidad, el valor, y el incremento del valor en un 10%
  SELECT CODIGO_REP, lower(NOMBRE_REP), LEFT(NOMBRE_REP, 3) AS LETRAS_PRESENTACION, VALOR_VENTA, VALOR_VENTA*1.10 AS VALOR_CON_INCREMENTO FROM REPUESTOS;
  
  -- 6. Muestre las distintas presentaciones de los productos.
  SELECT distinct PRESENTACION FROM REPUESTOS;
  
  -- 7. Muestre el código de la compra, código del proveedor y el número de meses de la compra, coloca los nombres de etiquetas para cada columna.
  SELECT NO_COMPRA AS "CODIGO COMPRA", CODIGO_PROV AS "CODIGO PROVEEDOR", timestampdiff(MONTH, FECHA_COMPRA, CURDATE()) AS "MESES TRANSCURRIDOS" FROM COMPRA; 
  
  -- 8. Muestre el código de repuesto, los primeros 5 caracteres del nombre del repuesto, la presentación en minúscula, valor de la venta, valor de venta con un descuento del 20% etiquete la columna como DESCUENTO, para aquellos repuestos que no tienen una presentación de CAJA o UNIDAD.
  SELECT CODIGO_REP, LEFT(NOMBRE_REP, 5), LOWER(PRESENTACION), VALOR_VENTA, VALOR_VENTA*0.80 AS DESCUENTO FROM REPUESTOS WHERE PRESENTACION NOT IN ('CAJA', 'UNIDAD');
  
  -- 9. Muestre el código de la compra, código del producto, el valor de compra, la cantidad, el valor parcial (Valor de Compra * Cantidad), el valor parcial aplicando un descuento del 30%, ordene la consulta por valor parcial descendentemente. 
  SELECT NO_COMPRA, CODIGO_REP, VALOR_COMPRA, CANTIDAD, VALOR_COMPRA*CANTIDAD AS VALOR_PARCIAL, (VALOR_COMPRA*CANTIDAD)*0.70 AS "Valor parcial con descuento 30%" FROM DETALLE_COMPRA ORDER BY VALOR_PARCIAL DESC;
  
  -- 10. Muestre el código del repuesto, el valor de compra en formato $999,999 y la fecha en formato día del mes, día de la semana, nombre del mes y el año, de los repuestos que han sido suministradas por el proveedor de nombre 'BOSCH' o el proveedor ‘COCHS’
  SELECT dc.CODIGO_REP, CONCAT('$', FORMAT(dc.VALOR_COMPRA, 0)) AS VALOR_FORMATO, DATE_FORMAT(c.FECHA_COMPRA, '%d %W %M %Y') AS FECHA_FORMATO FROM DETALLE_COMPRA dc JOIN COMPRA c ON dc.NO_COMPRA = c.NO_COMPRA JOIN PROVEEDOR p ON c.CODIGO_PROV = p.CODIGO_PROV WHERE p.NOMBRE_PROV IN ('BOSCH', 'COCHS');
  
 -- 11.Muestre el número de la compra, código del proveedor, fecha de compra, fecha de entrega, los números de días entre la fecha de compra y fecha de entrega etiquete la columna como DIAS TRANSCURRIDOS, los meses entre la fecha de compra y la fecha de entrega etiquete la columna como meses transcurridos
 SELECT NO_COMPRA, CODIGO_PROV, FECHA_COMPRA, FECHA_ENTREGA, DATEDIFF(FECHA_ENTREGA, FECHA_COMPRA) AS "DIAS TRANSCURRIDOS", timestampdiff(MONTH, FECHA_COMPRA, FECHA_ENTREGA) AS "MESES TRANSCURRIDOS" FROM COMPRA;
 
 -- 12. Muestre el no. de la compra, el código del proveedor, fecha de compra, y la fecha de compra + 30 días, etiquete la columna cómo “Posible fecha de entrega”. 
 SELECT NO_COMPRA, CODIGO_PROV, FECHA_COMPRA, DATE_ADD(FECHA_COMPRA, INTERVAL 30 DAY) AS "Posible fecha de entrega" FROM COMPRA;
 
 -- 13.Muestre el no. de la compra, el código del proveedor, fecha de compra en formato ‘Fri Feb 2 1981’, fecha de entrega en formato ‘Fri Feb 2 1981’, el número de días trascurridos entre la fecha de compra y la fecha de entrega, y el no. de semanas transcurridos entre las 2 fechas. Coloque etiquetas a los nombres de las columnas consultadas
 SELECT NO_COMPRA AS "NUMERO COMPRA", CODIGO_PROV AS "CODIGO PROVEEDOR", date_format(FECHA_COMPRA, '%a %b %e %Y') AS "FECHA COMPRA FORMATEADA", date_format(FECHA_ENTREGA, '%a %b %e %Y') AS "FECHA ENTREGA FORMATEADA", datediff(FECHA_ENTREGA, FECHA_COMPRA) AS "DIAS TRANSCURRIDOS", TIMESTAMPDIFF(WEEK, FECHA_COMPRA, FECHA_ENTREGA) AS "SEMANAS TRANSCURRIDAS" FROM COMPRA;  
 
 -- 14. Mostrar el numero de la compra, extraiga el año de la fecha de la compra, el mes de la fecha de la compra para aquellas compras que se han realizado en los últimos 5 años.
 SELECT NO_COMPRA, YEAR(FECHA_COMPRA) AS ANIO_COMPRA, MONTH(FECHA_COMPRA) AS MES_COMPRA FROM COMPRA WHERE FECHA_COMPRA >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);
 
 -- 15.Concatene el nombre del producto más la unidad media separada por un espacio.
 SELECT CONCAT(NOMBRE_REP, ' ', PRESENTACION) AS "PRODUCTO Y UNIDAD" FROM REPUESTOS;
 
 -- 16.Obtenga los primeros 5 caracteres del nombre del repuesto, de la unidad los primeros 3 caracteres y el valor del producto.
 SELECT left(NOMBRE_REP, 5), left(PRESENTACION, 3), VALOR_VENTA FROM REPUESTOS;
 
 -- 17.Consultar solo los 3 primeros registros de la tabla proveedores
 SELECT * FROM PROVEEDOR LIMIT 3;
 