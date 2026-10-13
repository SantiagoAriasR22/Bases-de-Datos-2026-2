use practica;

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
  (40, 2, '2023-01-15', '2023-02-10'),
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
  
  SELECT * FROM compra;
  
  -- 1. Muestre las distintas ciudades que aparecen en la tabla Proveedores
  SELECT DISTINCT CIUDAD FROM PROVEEDOR;
  
  -- 2
  select lower(NOMBRE_PROV), lower(CIUDAD) from PROVEEDOR where NOMBRE_PROV like '%CHS' and CIUDAD IN ('BARRANQUILLA', 'CARTAGENA');
  
  -- 3
  select left(upper(NOMBRE_PROV), 1) as "INICIAL", DIRECCION from PROVEEDOR where DIRECCION LIKE '%TRANS%' or DIRECCION LIKE '%DIAG%';
  
  -- 4
  select NOMBRE_REP AS "Nombre repuesto", VALOR_VENTA as "Valor venta", PRESENTACION FROM REPUESTOS where PRESENTACION = 'CAJA' and VALOR_VENTA BETWEEN 100000 and 250000 ORDER BY VALOR_VENTA DESC;
  
  -- 5
  select CODIGO_REP, lower(NOMBRE_REP), left(nombre_rep, 3), VALOR_VENTA, VALOR_VENTA*1.10 FROM REPUESTOS;
  
  -- 6
  select distinct presentacion from repuestos;
  
  -- 7
  select c.no_compra as "Codigo de la compra", p.NOMBRE_PROV as "Nombre proveedor", TIMESTAMPDIFF(MONTH, FECHA_COMPRA, FECHA_ENTREGA) as "Numero de meses" from compra c inner join proveedor p on c.codigo_prov=p.codigo_prov;  
  
  -- 8
  select codigo_rep, left(nombre_rep, 5), lower(presentacion), valor_venta, valor_venta*0.8 as "Descuento" from repuestos where presentacion NOT IN ('CAJA', 'UNIDAD');
  
  -- 9
  select d.no_compra, r.nombre_rep, d.valor_compra, d.cantidad, (d.valor_compra*d.cantidad) as VALOR_PARCIAL, (d.valor_compra*d.cantidad)*0.7 from detalle_compra d inner join repuestos r on d.codigo_rep=r.codigo_rep order by valor_parcial desc;
  
  -- 10
  select d.codigo_rep, concat('$', d.valor_compra), date_format(c.fecha_entrega, '%e %a %b %Y') from detalle_compra d inner join compra c on d.no_compra=c.no_compra inner join proveedor p on p.codigo_prov=c.codigo_prov where p.nombre_prov in ('BOSCH', 'COCHS');
  
  -- 11
  select c.no_compra, p.nombre_prov, c.fecha_compra, c.fecha_entrega, timestampdiff(DAY, c.fecha_compra, c.fecha_entrega) as "DIAS TRANSCURRIDOS", timestampdiff(MONTH, c.fecha_compra, c.fecha_entrega) as "MESES TRANSCURRIDOS" from compra c join proveedor p on p.codigo_prov=c.codigo_prov;
  
  -- 12
  select c.no_compra, p.nombre_prov, c.fecha_compra, date_add(c.fecha_compra, interval 30 day) as "Posible fecha entrega" from compra c join proveedor p on p.codigo_prov=c.codigo_prov;
  
  -- 13
  select c.no_compra, p.nombre_prov, date_format(c.fecha_compra, '%a %b %e %Y'), date_format(c.fecha_entrega, '%a %b %e %Y'), timestampdiff(DAY, c.fecha_compra, c.fecha_entrega), timestampdiff(WEEK, c.fecha_compra, c.fecha_entrega) from compra c join proveedor p on p.codigo_prov=c.codigo_prov;
  
  -- 14
  select no_compra, extract(YEAR FROM fecha_compra) as Anio, extract(month from fecha_compra) from compra where year(fecha_compra) >= year(curdate()) - 5;
  
  -- 15
  select concat(nombre_rep, ' ', presentacion) from repuestos;
  
  -- 16
  select LEFT(nombre_rep, 5), left(presentacion, 3), valor_venta from repuestos;
  
  -- 17
  select * from proveedor limit 3;
  
  -- 18
  select c.no_compra, year(c.fecha_compra), month(c.fecha_compra), p.nombre_prov from compra c right join proveedor p on c.codigo_prov=p.codigo_prov;
  
  -- 19
  select ciudad, count(codigo_prov) as NUMERO_EMPLEADOS from proveedor group by ciudad;
  
  -- 20
  select presentacion, count(codigo_rep) as numero_repuestos from repuestos group by presentacion;
  
  -- 21
  select min(fecha_compra), max(fecha_compra) from compra;
  
  -- 22
  select max(valor_venta), min(valor_venta) from repuestos;
  
  -- 23
  select codigo_prov, count(codigo_prov) from compra group by codigo_prov;
  
  -- 24
  select no_compra, sum(valor_compra*cantidad) from detalle_compra group by no_compra;
  
  -- 25
  select presentacion, sum(valor_venta) from repuestos group by presentacion;
  
  -- 26
  select count(codigo_prov) from proveedor;
  
  -- 27
  select count(codigo_rep) from repuestos;
  
  -- 28
  select min(valor_venta), max(valor_venta) from repuestos;
  
  -- 29
  select avg(valor_venta) from repuestos;
  
  -- 30
  select ciudad, count(codigo_prov) as city from proveedor group by ciudad order by city ASC;
  
  -- 31
  select codigo_prov, count(no_compra) from compra WHERE fecha_compra >= CURDATE() - INTERVAL 6 MONTH group by codigo_prov;
  
  -- 32
  select codigo_prov, count(no_compra) as numero from compra group by codigo_prov having count(no_compra) not between 3 and 5;
  
  -- 33
  select no_compra, sum(valor_compra*cantidad) as valor from detalle_compra group by no_compra having valor not between 150000 and 200000;
  
  -- 34
  select codigo_rep, avg(valor_compra) as promedio from detalle_compra group by codigo_rep having promedio between 500000 and 800000;
  