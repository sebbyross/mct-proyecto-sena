
-- Estructura de tabla para la tabla bodega
--

CREATE TABLE bodega (
  id_bodega int(11) NOT NULL,
  ubicacion varchar(100) NOT NULL,
  capacidad_max varchar(100) NOT NULL,
  dimensiones varchar(50) NOT NULL
);

--
-- Volcado de datos para la tabla bodega
--

INSERT INTO bodega(id_bodega, ubicacion, capacidad_max, dimensiones) VALUES
(1, 'Bodega Central - Ciudad 1', '5000 unidades', '10x10x5 m'),
(2, 'Bodega Norte - Ciudad 1', '3000 unidades', '8x8x4 m'),
(3, 'Bodega Sur - Ciudad 2', '2000 unidades', '6x6x4 m'),
(4, 'Bodega Este - Ciudad 3', '10000 unidades', '12x12x6 m');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla categoria
--

CREATE TABLE categoria (
  id_categ int(11) NOT NULL,
  nombre varchar(30) NOT NULL,
  descripcion varchar(300) NOT NULL
);

--
-- Volcado de datos para la tabla categoria
--

INSERT INTO categoria (id_categ, nombre, descripcion) VALUES
(1, 'Electrónica', 'Productos electrónicos como computadoras, teléfonos móviles, cámaras y accesorios relacionados.'),
(2, 'Hogar', 'Artículos para el hogar, incluyendo muebles, electrodomésticos, utensilios y decoración.'),
(3, 'Alimentos y Bebidas', 'Productos alimenticios, bebidas, y artículos de consumo diario.'),
(4, 'Libros y Música', 'Libros, música, discos y otros productos relacionados con el entretenimiento cultural.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla empleado
--

CREATE TABLE empleado (
  codigo_empleado int(11) NOT NULL,
  nombre varchar(30) NOT NULL,
  apellido varchar(40) NOT NULL
);

--
-- Volcado de datos para la tabla empleado
--

INSERT INTO empleado (codigo_empleado, nombre, apellido) VALUES
(1, 'Juan', 'Pérez'),
(2, 'Ana', 'González'),
(3, 'Carlos', 'López'),
(4, 'María', 'Martínez'),
(5, 'Luis', 'Hernández'),
(6, 'Elena', 'Ramírez'),
(7, 'David', 'Sánchez'),
(8, 'Laura', 'Torres'),
(9, 'Jorge', 'Vázquez'),
(10, 'Marta', 'Gutiérrez');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla movimiento
--

CREATE TABLE movimiento (
  id_mov int(11) NOT NULL,
  tipo_mov varchar(20) NOT NULL,
  fecha_mov date NOT NULL,
  codigo_empleado int(11) NOT NULL
);

--
-- Volcado de datos para la tabla movimiento
--

INSERT INTO movimiento (id_mov, tipo_mov, fecha_mov, codigo_empleado) VALUES
(1, 'salida', '2024-10-03', 7),
(2, 'entrada', '2024-10-01', 5),
(3, 'salida', '2024-10-08', 2),
(4, 'entrada', '2024-10-10', 9),
(5, 'salida', '2024-10-06', 4),
(6, 'entrada', '2024-10-02', 6),
(7, 'salida', '2024-10-04', 10),
(8, 'entrada', '2024-10-05', 3),
(9, 'salida', '2024-10-09', 1),
(10, 'entrada', '2024-10-07', 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla producto
--

CREATE TABLE producto (
  id_prod int(11) NOT NULL,
  nombre varchar(40) NOT NULL,
  imagen varchar(100) NOT NULL,
  marca varchar(30) NOT NULL,
  descripcion varchar(300) NOT NULL,
  stock_min int(11) NOT NULL,
  stock_max int(11) NOT NULL,
  stock_current int(11) NOT NULL,
  precio int(11) NOT NULL,
  id_categ int(11) NOT NULL,
  id_prov int(11) NOT NULL,
  id_bodega int(11) NOT NULL
);

--
-- Volcado de datos para la tabla producto
--

INSERT INTO producto (id_prod, nombre, imagen, marca, descripcion, stock_min, stock_max, stock_current, precio, unidad_medida, id_categ, id_prov, id_bodega) VALUES
(1, 'Ayn Odin 2 Pro.', 'placeholder_image_0', 'Ayn', 'android handheld gaming console, 16gb ram,256rom snapdragon8gen2.', 10, 100, 80, 369, 'unidad', 1, 1, 1),
(2, 'Teclado mecánico', 'placeholder_imagen_1', 'Logitech', 'Teclado mecánico con retroiluminación RGB', 10, 100, 55, 120, 'unidad', 1, 1, 2),
(3, 'Smartphone Samsung Galaxy', 'placeholder_imagen_2', 'Samsung', 'Smartphone Samsung Galaxy con cámara de 48MP', 20, 200, 130, 300, 'unidad', 1, 1, 2),
(4, 'Auriculares Sony', 'placeholder_imagen_3', 'Sony', 'Auriculares inalámbricos con cancelación de ruido', 15, 80, 40, 150, 'unidad', 1, 1, 1),
(5, 'Monitor 27 pulgadas', 'placeholder_imagen_4', 'Dell', 'Monitor 27\" 4K, ideal para gaming', 8, 40, 25, 400, 'unidad', 1, 1, 2),
(6, 'Cámara de seguridad', 'placeholder_imagen_5', 'Xiaomi', 'Cámara de seguridad con visión nocturna', 5, 30, 15, 75, 'unidad', 1, 2, 2),
(7, 'Disco duro externo', 'placeholder_imagen_6', 'Seagate', 'Disco duro externo de 2TB', 12, 60, 30, 100, 'unidad', 1, 1, 4),
(8, 'Proyector LED', 'placeholder_imagen_7', 'Epson', 'Proyector LED Full HD para cine en casa', 6, 25, 18, 500, 'unidad', 1, 2, 3),
(9, 'Mouse inalámbrico', 'placeholder_imagen_8', 'Logitech', 'Mouse inalámbrico ergonómico', 50, 200, 120, 30, 'unidad', 1, 1, 2),
(10, 'Laptop HP', 'placeholder_imagen_9', 'HP', 'Laptop con procesador Intel i5, 8GB de RAM', 5, 50, 20, 600, 'unidad', 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla productomov
--

CREATE TABLE productomov (
  id_mov int(11) NOT NULL,
  id_prod int(11) NOT NULL,
  cantidad int(11) NOT NULL
);

--
-- Volcado de datos para la tabla productomov
--

INSERT INTO productomov (id_mov, id_prod, cantidad) VALUES
(1, 3, 15),
(2, 7, 25),
(3, 2, 10),
(4, 5, 8),
(5, 1, 20),
(6, 6, 30),
(7, 10, 5),
(8, 4, 12),
(9, 8, 18),
(10, 9, 22);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla proveedor
--

CREATE TABLE proveedor (
  id_prov int(11) NOT NULL,
  nombre varchar(30) NOT NULL,
  descripcion varchar(300) NOT NULL,
  NIT varchar(30) NOT NULL
); 

--
-- Volcado de datos para la tabla proveedor
--

INSERT INTO proveedor (id_prov, nombre, descripcion, NIT) VALUES
(1, 'Proveedora Global S.A.', 'Proveedor de equipos electrónicos, dispositivos móviles y accesorios informáticos.', '1234567890123'),
(2, 'Distribuciones Hogar', 'Proveedor de artículos para el hogar, muebles, electrodomésticos y utensilios.', '2345678901234'),
(3, 'Alimentos Frescos', 'Proveedor de alimentos frescos, productos enlatados, bebidas y artículos de consumo diario.', '8901234567890'),
(4, 'Libros & Cultura', 'Distribuidor de libros, discos, y productos culturales para entretenimiento y aprendizaje.', '9012345678901');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla bodega
--
ALTER TABLE bodega
  ADD PRIMARY KEY (id_bodega);

--
-- Indices de la tabla categoria
--
ALTER TABLE categoria
  ADD PRIMARY KEY (id_categ);

--
-- Indices de la tabla empleado
--
ALTER TABLE empleado
  ADD PRIMARY KEY (codigo_empleado);

--
-- Indices de la tabla movimiento
--
ALTER TABLE movimiento
  ADD PRIMARY KEY (id_mov),
  ADD KEY codigo_empleado (codigo_empleado);

--
-- Indices de la tabla producto
--
ALTER TABLE producto
  ADD PRIMARY KEY (id_prod),
  ADD KEY id_categ_2 (id_categ,id_prov,id_bodega),
  ADD KEY fk_2 (id_prov),
  ADD KEY fk_3 (id_bodega);

--
-- Indices de la tabla productomov
--
ALTER TABLE productomov
  ADD KEY id_mov (id_mov),
  ADD KEY id_prod (id_prod);

--
-- Indices de la tabla proveedor
--
ALTER TABLE proveedor
  ADD PRIMARY KEY (id_prov);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla movimiento
--
ALTER TABLE movimiento
  ADD CONSTRAINT movimiento_ibfk_1 FOREIGN KEY (codigo_empleado) REFERENCES empleado (codigo_empleado);

--
-- Filtros para la tabla producto
--
ALTER TABLE producto
  ADD CONSTRAINT fk_1 FOREIGN KEY (id_categ) REFERENCES categoria (id_categ),
  ADD CONSTRAINT fk_2 FOREIGN KEY (id_prov) REFERENCES proveedor (id_prov),
  ADD CONSTRAINT fk_3 FOREIGN KEY (id_bodega) REFERENCES bodega (id_bodega);

--
-- Filtros para la tabla productomov
--
ALTER TABLE productomov
  ADD CONSTRAINT productomov_ibfk_1 FOREIGN KEY (id_mov) REFERENCES movimiento (id_mov),
  ADD CONSTRAINT productomov_ibfk_2 FOREIGN KEY (id_prod) REFERENCES producto (id_prod);