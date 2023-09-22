CREATE DATABASE sistemaventas;

USE sistemaventas;

CREATE TABLE Usuarios (
    usuario VARCHAR(20) PRIMARY KEY, 
	clave VARCHAR(MAX)
);

CREATE TABLE Clientes (
    dni VARCHAR(8) PRIMARY KEY,
    nombres VARCHAR(100),
    apellidos VARCHAR(100),
    telefono VARCHAR(13),
    estado_civil VARCHAR(20),
    direccion VARCHAR(200),
    fecha_nacimiento DATE,
    membresia VARCHAR(20)
);

CREATE TABLE Empresas (
    ruc VARCHAR(11) PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(200),
    telefono VARCHAR(13)
);

CREATE TABLE Proveedores (
	id INT PRIMARY KEY IDENTITY(1,1), 
    nombre VARCHAR(100), 
	telefono VARCHAR(13),
	descuento decimal(15,5)
);

CREATE TABLE Locales (
    id INT PRIMARY KEY IDENTITY(1,1),
    direccion VARCHAR(200),
    telefono VARCHAR(13),
    comentario VARCHAR(200)
);

CREATE TABLE Empleados (
    dni VARCHAR(8) PRIMARY KEY,
    nombres VARCHAR(100),
    apellidos VARCHAR(100),
    telefono VARCHAR(13),
    estado_civil VARCHAR(20),
    direccion VARCHAR(200),
    fecha_nacimiento DATE,
    cargo VARCHAR(100),
    salario DECIMAL(10, 2),
    local_id INT NULL,
    FOREIGN KEY (local_id) REFERENCES Locales(id)
);

CREATE TABLE Productos (
    id INT PRIMARY KEY IDENTITY(1,1), 
    nombre VARCHAR(100), 
    precio DECIMAL(10, 2),
    cantidad INT,
    proveedor_id INT,
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id)
);

CREATE TABLE ProductosLocal (
    local_id INT,
    producto_id INT,
    FOREIGN KEY (local_id) REFERENCES Locales(id),
    FOREIGN KEY (producto_id) REFERENCES Productos(id)
);

CREATE TABLE Boletas (
    id VARCHAR(36) PRIMARY KEY,
    local_id INT,
    empleado_dni VARCHAR(8),
    fecha DATE,
    comentario VARCHAR(255),
    subtotal DECIMAL(10, 2),
    descuento DECIMAL(15, 5),
    importe_final DECIMAL(10, 2),
    cliente_dni VARCHAR(8),
    FOREIGN KEY (local_id) REFERENCES Locales(id),
    FOREIGN KEY (empleado_dni) REFERENCES Empleados(dni),
    FOREIGN KEY (cliente_dni) REFERENCES Clientes(dni)
);

CREATE TABLE ProductosBoleta (
    boleta_id VARCHAR(36),
    producto_id INT,
    cantidad INT,
    FOREIGN KEY (boleta_id) REFERENCES Boletas(id),
    FOREIGN KEY (producto_id) REFERENCES Productos(id)
);

CREATE TABLE Facturas (
    id VARCHAR(36) PRIMARY KEY,
    local_id INT,
    empleado_dni VARCHAR(8),
    fecha DATE,
    comentario VARCHAR(255),
    subtotal DECIMAL(10, 2),
    impuestos DECIMAL(10, 2),
    descuento DECIMAL(15, 5),
    importe_final DECIMAL(10, 2),
    empresa_ruc VARCHAR(11),
    FOREIGN KEY (local_id) REFERENCES Locales(id),
    FOREIGN KEY (empleado_dni) REFERENCES Empleados(dni),
    FOREIGN KEY (empresa_ruc) REFERENCES Empresas(ruc)
);

CREATE TABLE ProductosFactura (
    factura_id VARCHAR(36),
    producto_id INT,
    cantidad INT,
    FOREIGN KEY (factura_id) REFERENCES Facturas(id),
    FOREIGN KEY (producto_id) REFERENCES Productos(id)
);

INSERT INTO Usuarios VALUES
    ('admin', '$2a$10$2ExoCDFheqvsDwyZS7Je7Ok21KErLIWIIEpCUqgVakJIykmVG8RsC'),
    ('user', '$2a$10$s8Ujct8YUUmnQnJDrGk...K5WDQRBjkKZUdROwTj7WG2bWRjEZ0ye');

INSERT INTO Clientes (dni, nombres, apellidos, telefono, estado_civil, direccion, fecha_nacimiento, membresia) VALUES
    ('28474369', 'Juan Carlos', 'Hernández Gómez', '+51 912345678', 'Soltero', 'Av. Javier Prado Este 123, Lima', '1990-01-01', 'Plata'),
    ('54321789', 'María Alejandra', 'López Ramírez', '+51 923456789', 'Casado', 'Calle Las Begonias 456, Lima', '1985-03-15', 'Oro'),
    ('67543219', 'Carlos Eduardo', 'García Fernández', '+51 934567890', 'Soltero', 'Av. Arequipa 789, Lima', '1992-07-20', 'Ninguno'),
    ('99887654', 'Laura Patricia', 'Martínez Sánchez', '+51 945678901', 'Soltero', 'Jirón de la Unión 101, Lima', '1988-11-05', 'Plata'),
    ('45213458', 'Pedro Antonio', 'Rodríguez Torres', '+51 956789012', 'Casado', 'Av. Salaverry 2222, Lima', '1995-02-10', 'Oro'),
    ('76543234', 'Ana María', 'Gómez Velasco', '+51 967890123', 'Soltero', 'Av. Larco 3333, Lima', '1987-06-25', 'Diamante'),
    ('98886546', 'Luis Alejandro', 'Hernández López', '+51 978901234', 'Casado', 'Calle Schell 444, Lima', '1993-09-12', 'Plata'),
    ('12034567', 'Martha Isabel', 'Torres Díaz', '+51 989012345', 'Casado', 'Av. Pardo 555, Lima', '1991-04-18', 'Oro'),
    ('43654321', 'Raúl Ernesto', 'Sánchez Guzmán', '+51 990123456', 'Soltero', 'Av. La Marina 666, Lima', '1989-08-30', 'Ninguno'),
    ('76321543', 'Sofía Gabriela', 'Ramírez Castro', '+51 991234567', 'Soltero', 'Av. Petit Thouars 777, Lima', '1994-12-08', 'Diamante');

INSERT INTO Empresas (ruc, nombre, direccion, telefono) VALUES
    ('20123456789', 'Comercial Los Pioneros', 'Av. Los Jazmines 123, Lima', '+51 987612345'),
    ('20234567890', 'Tienda Moda Urbana', 'Calle Las Rosas 456, Lima', '+51 912378901'),
    ('20345678901', 'Distribuidora El Encanto', 'Av. Los Girasoles 789, Lima', '+51 923456127'),
    ('20456789012', 'Taller Mecánico La Rueda Feliz', 'Av. Los Laureles 222, Lima', '+51 934578901'),
    ('20567890123', 'Tienda de Decoración Bella Vista', 'Calle Los Cedros 333, Lima', '+51 945678234'),
    ('20678901234', 'Panadería La Delicia Andina', 'Av. Los Alamos 444, Lima', '+51 956721345'),
    ('20789012345', 'Librería El Sabio Escribano', 'Av. Los Cipreses 555, Lima', '+51 967890234'),
    ('20890123456', 'Ferretería El Martillo', 'Av. Los Robles 666, Lima', '+51 978903456'),
    ('20901234567', 'Papelería La Tinta Creativa', 'Av. Los Abetos 777, Lima', '+51 989012345'),
    ('21012345678', 'Tienda de Electrodomésticos La Casa del Hogar', 'Av. Los Pinos 888, Lima', '+51 990123789');

INSERT INTO Proveedores (nombre, telefono, descuento) VALUES
    ('Index', '+51 987654321', 0.02500),
    ('Jack & Jones', '+51 912345678', 0.04000),
    ('Adidas', '+51 923456789', 0.03250),
    ('H&M', '+51 934567890', 0.01500),
    ('Bronco', '+51 945678901', 0.03750),
    ('Pionier', '+51 956789012', 0.02000),
    ('Woallance', '+51 967890123', 0.01750),
    ('Gotcha', '+51 978901234', 0.02250),
    ('Quiksilver', '+51 989012345', 0.04500),
    ('Boston', '+51 934579485', 0.01250);

INSERT INTO Locales (direccion, telefono, comentario) VALUES
    ('Av. Javier Prado Este 123, San Isidro', '+51 912345678', 'Este local ofrece una amplia variedad de productos y cuenta con estacionamiento gratuito.'),
    ('Calle Las Begonias 456, Miraflores', '+51 923456789', 'Ubicado en una zona turística, este local ofrece productos exclusivos y atención personalizada.'),
    ('Av. Arequipa 789, Lince', '+51 934567890', 'Visítanos para encontrar productos de alta calidad a precios competitivos.'),
    ('Jirón de la Unión 101, Cercado de Lima', '+51 945678901', 'El local emblemático en el centro histórico de Lima con una amplia gama de productos.'),
    ('Av. Salaverry 2222, Jesús María', '+51 956789012', 'Este local cuenta con un ambiente acogedor y ofrece promociones especiales para nuestros clientes.'),
    ('Av. Larco 3333, Miraflores', '+51 967890123', 'Visítanos para descubrir las últimas tendencias en moda y accesorios.'),
    ('Calle Schell 444, Miraflores', '+51 978901234', 'Local de referencia para encontrar productos únicos y exclusivos de diversas marcas reconocidas.'),
    ('Av. Pardo 555, Miraflores', '+51 989012345', 'Un lugar perfecto para disfrutar de un ambiente moderno y encontrar productos de alta calidad.'),
    ('Av. La Marina 666, Pueblo Libre', '+51 990123456', 'Este local ofrece una amplia selección de productos y cuenta con un equipo de atención amigable.'),
    ('Av. Petit Thouars 777, Lince', '+51 991234567', 'Visítanos y descubre nuestras ofertas especiales en una ubicación conveniente y de fácil acceso.');

INSERT INTO Empleados (dni, nombres, apellidos, telefono, estado_civil, direccion, fecha_nacimiento, cargo, salario, local_id) VALUES
    ('01244567', 'Juan Pedro', 'Gómez Rodríguez', '+51 912345678', 'Soltero', 'Av. Javier Prado Este 123, San Isidro, Lima', '1990-05-15', 'Vendedor', 4000.00, 1),
    ('23456689', 'María Alejandra', 'López Torres', '+51 923456789', 'Casado', 'Calle Las Begonias 456, Miraflores, Lima', '1985-08-20', 'Asesor de Ventas', 4500.00, 2),
    ('45678111', 'Carlos Alberto', 'Pérez García', '+51 934567890', 'Soltero', 'Av. Arequipa 789, Lince, Lima', '1992-11-10', 'Encargado de Tienda', 5000.00, 3),
    ('77390123', 'Laura Carolina', 'Torres Vargas', '+51 945678901', 'Casado', 'Jirón de la Unión 101, Cercado de Lima, Lima', '1988-06-25', 'Supervisor de Ventas', 5500.00, 6),
    ('79012645', 'Pedro Antonio', 'Chávez Ramírez', '+51 956789012', 'Soltero', 'Av. Salaverry 2222, Jesús María, Lima', '1993-09-05', 'Vendedor', 4000.00, 8),
    ('01234567', 'Alejandra Patricia', 'García Rojas', '+51 967890123', 'Viudo', 'Av. Larco 3333, Miraflores, Lima', '1980-03-12', 'Encargado de Almacén', 4800.00, 4),
    ('23456789', 'Luis Enrique', 'Ramírez Sánchez', '+51 978901234', 'Casado', 'Calle Schell 444, Miraflores, Lima', '1987-07-18', 'Vendedor', 4000.00, NULL),
    ('45678901', 'Ana María', 'Sánchez Gutiérrez', '+51 989012345', 'Soltero', 'Av. Pardo 555, Miraflores, Lima', '1990-02-28', 'Asesor de Ventas', 4500.00, 5),
    ('67890123', 'Mario Antonio', 'Gutiérrez Rojas', '+51 990123456', 'Casado', 'Av. La Marina 666, Pueblo Libre, Lima', '1984-12-08', 'Vendedor', 4000.00, 7),
    ('89012345', 'Elena Gabriela', 'Rojas López', '+51 991234567', 'Soltero', 'Av. Petit Thouars 777, Lince, Lima', '1991-07-07', 'Asesor de Ventas', 4500.00, 2),
    ('10987654', 'Luis Alejandro', 'Vargas González', '+51 912345678', 'Soltero', 'Av. Javier Prado Este 123, San Isidro, Lima', '1987-09-18', 'Vendedor', 4000.00, 6),
    ('21876543', 'María Fernanda', 'Flores Silva', '+51 923456789', 'Casado', 'Calle Las Begonias 456, Miraflores, Lima', '1991-04-03', 'Asesor de Ventas', 4500.00, NULL),
    ('32765432', 'Pedro Alejandro', 'Herrera Vargas', '+51 934567890', 'Soltero', 'Av. Arequipa 789, Lince, Lima', '1989-12-15', 'Encargado de Tienda', 5000.00, 6),
    ('43654321', 'Laura Carolina', 'Rodríguez Pérez', '+51 945678901', 'Casado', 'Jirón de la Unión 101, Cercado de Lima, Lima', '1983-03-28', 'Supervisor de Ventas', 5500.00, 7),
    ('54543210', 'Carlos Eduardo', 'Soto Herrera', '+51 956789012', 'Soltero', 'Av. Salaverry 2222, Jesús María, Lima', '1995-08-11', 'Vendedor', 4000.00, 8),
    ('65432109', 'Ana Gabriela', 'Rojas Gutiérrez', '+51 967890123', 'Viudo', 'Av. Larco 3333, Miraflores, Lima', '1982-05-09', 'Encargado de Almacén', 4800.00, NULL),
    ('76321098', 'Luis Enrique', 'García Sánchez', '+51 978901234', 'Casado', 'Calle Schell 444, Miraflores, Lima', '1986-11-22', 'Vendedor', 4000.00, 9),
    ('87210987', 'María Teresa', 'López Gutiérrez', '+51 989012345', 'Soltero', 'Av. Pardo 555, Miraflores, Lima', '1989-06-14', 'Asesor de Ventas', 4500.00, 1),
    ('98109876', 'Pedro José', 'Hernández Rojas', '+51 990123456', 'Casado', 'Av. La Marina 666, Pueblo Libre, Lima', '1981-02-17', 'Vendedor', 4000.00, 10),
    ('09098765', 'Elena Gabriela', 'Rojas López', '+51 991234567', 'Soltero', 'Av. Petit Thouars 777, Lince, Lima', '1988-09-05', 'Asesor de Ventas', 4500.00, NULL),
    ('45278963', 'María José', 'Torres López', '+51 992345678', 'Soltero', 'Av. Los Álamos 100, Surco, Lima', '1992-07-15', 'Vendedor', 4000.00, 6),
    ('19872365', 'Carlos Andrés', 'Guzmán Sánchez', '+51 993456789', 'Casado', 'Calle Los Rosales 200, Miraflores, Lima', '1984-09-27', 'Supervisor de Ventas', 5500.00, 1),
    ('57931624', 'Ana Isabel', 'Cabrera Torres', '+51 994567890', 'Soltero', 'Av. Primavera 300, San Borja, Lima', '1990-03-12', 'Vendedor', 4000.00, 7),
    ('73189245', 'Luis Antonio', 'Ríos Gutiérrez', '+51 995678901', 'Casado', 'Jirón Huallaga 400, Cercado de Lima, Lima', '1987-12-05', 'Asesor de Ventas', 4500.00, NULL),
    ('62389417', 'María Fernanda', 'Vargas Pérez', '+51 996789012', 'Soltero', 'Av. El Sol 500, Miraflores, Lima', '1993-05-19', 'Vendedor', 4000.00, 3),
    ('37981264', 'Carlos Eduardo', 'Flores Sánchez', '+51 997890123', 'Casado', 'Calle San Martín 600, Jesús María, Lima', '1985-11-11', 'Encargado de Tienda', 5000.00, 8),
    ('27469518', 'Laura Gabriela', 'Herrera Torres', '+51 998901234', 'Soltero', 'Av. El Bosque 700, San Isidro, Lima', '1981-04-27', 'Vendedor', 4000.00, 9),
    ('15692348', 'Pedro Alejandro', 'Gutiérrez Sánchez', '+51 999012345', 'Casado', 'Calle Los Robles 800, Miraflores, Lima', '1992-10-03', 'Asesor de Ventas', 4500.00, 4),
    ('84537912', 'María Carolina', 'López Pérez', '+51 990123456', 'Soltero', 'Av. Las Flores 900, San Borja, Lima', '1986-02-15', 'Vendedor', 4000.00, 5),
    ('21759638', 'Carlos Enrique', 'Rojas Gutiérrez', '+51 991234567', 'Casado', 'Calle Los Alamos 1000, San Isidro, Lima', '1990-07-23', 'Encargado de Almacén', 4800.00, 10),
    ('16523879', 'María Gabriela', 'García Gutiérrez', '+51 993456789', 'Soltero', 'Av. Los Pinos 1100, Surco, Lima', '1984-09-18', 'Vendedor', 4000.00, 6),
    ('72891635', 'Carlos Andrés', 'Rojas Sánchez', '+51 994567890', 'Casado', 'Calle Los Jazmines 1200, Miraflores, Lima', '1993-03-21', 'Supervisor de Ventas', 5500.00, NULL),
    ('59471326', 'María Fernanda', 'Gutiérrez López', '+51 995678901', 'Soltero', 'Av. El Bosque 1300, San Isidro, Lima', '1987-08-10', 'Vendedor', 4000.00, NULL),
    ('38265914', 'Luis Alejandro', 'López Sánchez', '+51 996789012', 'Casado', 'Calle Los Olivos 1400, Miraflores, Lima', '1993-01-05', 'Asesor de Ventas', 4500.00, 2),
    ('52891437', 'María Isabel', 'Rojas Gutiérrez', '+51 997890123', 'Soltero', 'Av. Los Pinos 1500, Lince, Lima', '1985-06-22', 'Vendedor', 4000.00, 3),
    ('14892537', 'Carlos Andrés', 'García López', '+51 998901234', 'Casado', 'Calle Los Alamos 1600, Miraflores, Lima', '1992-05-12', 'Asesor de Ventas', 4500.00, 8),
    ('27691548', 'María Carolina', 'Rojas Sánchez', '+51 999012345', 'Soltero', 'Av. Las Flores 1700, Surco, Lima', '1986-10-07', 'Vendedor', 4000.00, 9),
    ('67438921', 'Luis Antonio', 'Gutiérrez López', '+51 990123456', 'Casado', 'Calle Los Robles 1800, Miraflores, Lima', '1990-02-24', 'Encargado de Tienda', 5000.00, 4),
    ('59371428', 'María Gabriela', 'López Gutiérrez', '+51 991234567', 'Soltero', 'Av. El Sol 1900, San Isidro, Lima', '1984-07-19', 'Vendedor', 4000.00, 5),
    ('37148925', 'Carlos Andrés', 'García López', '+51 992345678', 'Casado', 'Calle Los Pinos 2000, Miraflores, Lima', '1992-07-02', 'Asesor de Ventas', 4500.00, NULL),
    ('40987654', 'Luis Eduardo', 'Castillo González', '+51 993456789', 'Casado', 'Calle Los Pinos 2100, Miraflores, Lima', '1987-12-01', 'Vendedor', 4000.00, 6),
    ('56783219', 'María Fernanda', 'Ríos Gutiérrez', '+51 994567890', 'Soltero', 'Av. Los Jazmines 2200, San Isidro, Lima', '1993-05-15', 'Supervisor de Ventas', 5500.00, 1),
    ('24519876', 'Carlos Andrés', 'Castillo López', '+51 995678901', 'Casado', 'Calle Los Olivos 2300, Miraflores, Lima', '1985-11-08', 'Vendedor', 4000.00, 7),
    ('65432718', 'María Gabriela', 'Rojas Gutiérrez', '+51 996789012', 'Soltero', 'Av. El Bosque 2400, Surco, Lima', '1993-01-03', 'Asesor de Ventas', 4500.00, 2),
    ('31298765', 'Luis Antonio', 'García López', '+51 997890123', 'Casado', 'Calle Los Pinos 2500, Miraflores, Lima', '1987-08-05', 'Vendedor', 4000.00, 3),
    ('45673129', 'María Carolina', 'Castillo Sánchez', '+51 998901234', 'Soltero', 'Av. Las Flores 2600, San Isidro, Lima', '1981-04-20', 'Encargado de Tienda', 5000.00, NULL),
    ('67543291', 'Carlos Andrés', 'Ríos López', '+51 999012345', 'Casado', 'Calle Los Olivos 2700, Surco, Lima', '1992-10-15', 'Vendedor', 4000.00, NULL),
    ('21349876', 'María Gabriela', 'Castillo Gutiérrez', '+51 990123456', 'Soltero', 'Av. El Sol 2800, Miraflores, Lima', '1986-02-10', 'Vendedor', 4000.00, 5),
    ('54132987', 'Luis Alejandro', 'Rojas Gutiérrez', '+51 991234567', 'Casado', 'Calle Los Pinos 2900, San Isidro, Lima', '1990-07-18', 'Encargado de Almacén', 4800.00, 10),
    ('37981654', 'María Gabriela', 'García López', '+51 992345678', 'Soltero', 'Av. Las Flores 3000, Surco, Lima', '1984-09-22', 'Vendedor', 4000.00, 6);

INSERT INTO Productos (nombre, precio, cantidad, proveedor_id) VALUES
    ('Camisa', 19.99, 100, 4),
    ('Casaca', 49.99, 50, 1),
    ('Chaleco', 29.99, 75, 1),
    ('Chompa', 39.99, 60, 2),
    ('Jeans', 59.99, 80, 5),
    ('Joggers', 34.99, 70, 3),
    ('Pantalones', 44.99, 90, 6),
    ('Polera', 14.99, 120, 7),
    ('Polerón', 54.99, 45, 8),
    ('Polo', 24.99, 110, 8),
    ('Ropa de baño', 29.99, 65, 9),
    ('Shorts', 19.99, 85, 9),
    ('Bóxers', 9.99, 150, 10),
    ('Calzoncillos', 7.99, 180, 10),
    ('Medias', 4.99, 200, 3),
    ('Pantuflas', 12.99, 40, 10),
    ('Pijama', 39.99, 55, 2);

INSERT INTO ProductosLocal (local_id, producto_id) VALUES
    (2, 8),
    (7, 6),
    (9, 9),
    (3, 10),
    (5, 3),
    (1, 5),
    (8, 16),
    (10, 12),
    (4, 7),
    (2, 4),
    (6, 17),
    (3, 14),
    (9, 11),
    (10, 13),
    (1, 2),
    (7, 15),
    (5, 1),
    (4, 6),
    (8, 3),
    (6, 9),
    (1, 7),
    (4, 15),
    (3, 2),
    (5, 9),
    (10, 4),
    (6, 11),
    (2, 10),
    (8, 13),
    (9, 5),
    (7, 6),
    (1, 16),
    (3, 12),
    (5, 1),
    (4, 17),
    (6, 14),
    (9, 3),
    (10, 8),
    (2, 6),
    (8, 9),
    (7, 13),
    (1, 4),
    (3, 10),
    (5, 2),
    (4, 15),
    (6, 11),
    (9, 7),
    (10, 16),
    (2, 12),
    (8, 5),
    (7, 3),
    (1, 8),
    (4, 6),
    (3, 14),
    (5, 12),
    (10, 7),
    (6, 3),
    (2, 17),
    (8, 10),
    (9, 2),
    (7, 15),
    (1, 5),
    (3, 9),
    (5, 16),
    (4, 1),
    (6, 13),
    (9, 11),
    (10, 4),
    (2, 14),
    (8, 2),
    (7, 17),
    (1, 10),
    (3, 8),
    (5, 6),
    (4, 3),
    (6, 15),
    (9, 12),
    (10, 9),
    (2, 7),
    (8, 16),
    (7, 4),
    (1, 2),
    (2, 3),
    (3, 4),
    (4, 5),
    (5, 6),
    (6, 7),
    (7, 8),
    (8, 9),
    (9, 10),
    (10, 11),
    (1, 12),
    (2, 13),
    (3, 14),
    (4, 15),
    (5, 16),
    (6, 17),
    (7, 1),
    (8, 2),
    (9, 3),
    (10, 4);

WITH CTE AS (
    SELECT local_id, producto_id,
            ROW_NUMBER() OVER (PARTITION BY local_id, producto_id ORDER BY (SELECT 0)) AS RowNum
    FROM ProductosLocal
)
DELETE FROM CTE WHERE RowNum > 1;

INSERT INTO Boletas (id, local_id, empleado_dni, fecha, comentario, subtotal, descuento, importe_final, cliente_dni) VALUES
    ('11f528e6-bf25-4eae-8d46-bf7989f36959', 1, '01234567', '2023-07-01', '', 319.92, 10.38, 309.54, '28474369'),
    ('7d1efbc6-3d6b-4323-a0f7-9fdebc498e8d', 2, '01244567', '2023-07-02', '', 263.94, 11.00, 252.94, '54321789'),
    ('da622e2a-d2f1-4e4f-9a1a-1c54a781da8f', 3, '09098765', '2023-07-03', '', 320.93, 8.86, 312.07, '67543219'),
    ('f8d5a151-0272-4f62-8642-5de1c2f2609a', 4, '10987654', '2023-07-04', '', 153.96, 4.46, 149.50, '99887654'),
    ('30151a2c-dfe0-4dc7-9e6b-48c6d0a5c251', 5, '14892537', '2023-07-05', '', 237.90, 9.43, 228.47, '45213458'),
    ('99820fbf-d7d9-4077-8b84-64c8404b4415', 6, '15692348', '2023-07-06', '', 119.96, 5.20, 114.76, '76543234'),
    ('e65ef6cd-10c2-47b4-a9e0-3ac0f73a12fd', 7, '16523879', '2023-07-07', '', 165.93, 6.47, 159.46, '98886546'),
    ('54d4bea6-5c62-481b-99df-0c4f525d67fd', 8, '19872365', '2023-07-08', '', 207.90, 9.23, 198.67, '12034567'),
    ('f8a98d8b-01a5-47fd-97d4-599db8681f02', 9, '21349876', '2023-07-09', '', 166.93, 4.63, 162.30, '43654321'),
    ('9c94c7f3-120a-4e1b-9d6a-ba7331c85064', 10, '43654321', '2023-07-10', '', 147.92, 6.12, 141.80, '67543219'),
    ('23fe6d49-1f11-4019-9689-83c4b925301b', 1, '21759638', '2023-07-11', '', 255.88, 10.33, 245.55, '45213458'),
    ('c974d8da-370b-461e-b9ee-54500b6d5a5f', 2, '45678111', '2023-07-12', '', 247.92, 6.61, 241.31, '76543234'),
    ('b2af2a57-2a62-4b43-9ef9-7b7e6eac21d9', 3, '45678901', '2023-07-13', '', 191.94, 9.19, 182.75, '28474369'),
    ('14fd972c-c055-4ad0-9ed1-5e9fbb2f7b4c', 4, '52891437', '2023-07-14', '', 275.94, 12.37, 263.57, '98886546'),
    ('f567609c-9d19-4b97-ae78-2b5c93224a2a', 5, '54543210', '2023-07-15', '', 159.96, 6.38, 153.58, '67543219'),
    ('c7e9ee51-1cfd-4db1-b982-80e38f82e070', 6, '56783219', '2023-07-16', '', 203.93, 9.20, 194.73, '28474369'),
    ('0a9e81f6-51e7-485a-ae4a-19520b03de01', 7, '57931624', '2023-07-17', '', 255.94, 11.41, 244.53, '99887654'),
    ('f174b1e2-7c78-47a9-a812-9a5b1100977d', 8, '59371428', '2023-07-18', '', 207.92, 8.14, 199.78, '54321789'),
    ('8365ddbe-aa10-4eae-a6a2-02e1f9f5b9a7', 9, '62389417', '2023-07-19', '', 191.96, 8.38, 183.58, '12034567'),
    ('7f180dda-81d5-4bfb-bd7e-4019ee430ec3', 10, '65432718', '2023-07-20', '', 227.95, 10.20, 217.75, '54321789');

INSERT INTO ProductosBoleta (boleta_id, producto_id, cantidad) VALUES
    ('11f528e6-bf25-4eae-8d46-bf7989f36959', 1, 5),
    ('11f528e6-bf25-4eae-8d46-bf7989f36959', 2, 2),
    ('11f528e6-bf25-4eae-8d46-bf7989f36959', 3, 3),
    ('7d1efbc6-3d6b-4323-a0f7-9fdebc498e8d', 4, 1),
    ('7d1efbc6-3d6b-4323-a0f7-9fdebc498e8d', 5, 4),
    ('7d1efbc6-3d6b-4323-a0f7-9fdebc498e8d', 6, 2),
    ('7d1efbc6-3d6b-4323-a0f7-9fdebc498e8d', 7, 3),
    ('da622e2a-d2f1-4e4f-9a1a-1c54a781da8f', 8, 5),
    ('da622e2a-d2f1-4e4f-9a1a-1c54a781da8f', 9, 2),
    ('da622e2a-d2f1-4e4f-9a1a-1c54a781da8f', 10, 1),
    ('f8d5a151-0272-4f62-8642-5de1c2f2609a', 11, 3),
    ('f8d5a151-0272-4f62-8642-5de1c2f2609a', 12, 2),
    ('30151a2c-dfe0-4dc7-9e6b-48c6d0a5c251', 13, 4),
    ('30151a2c-dfe0-4dc7-9e6b-48c6d0a5c251', 14, 3),
    ('30151a2c-dfe0-4dc7-9e6b-48c6d0a5c251', 15, 2),
    ('99820fbf-d7d9-4077-8b84-64c8404b4415', 16, 1),
    ('e65ef6cd-10c2-47b4-a9e0-3ac0f73a12fd', 17, 2),
    ('f8a98d8b-01a5-47fd-97d4-599db8681f02', 1, 3),
    ('f8a98d8b-01a5-47fd-97d4-599db8681f02', 2, 1),
    ('9c94c7f3-120a-4e1b-9d6a-ba7331c85064', 3, 2),
    ('9c94c7f3-120a-4e1b-9d6a-ba7331c85064', 4, 3),
    ('9c94c7f3-120a-4e1b-9d6a-ba7331c85064', 5, 4),
    ('23fe6d49-1f11-4019-9689-83c4b925301b', 6, 1),
    ('23fe6d49-1f11-4019-9689-83c4b925301b', 7, 2),
    ('23fe6d49-1f11-4019-9689-83c4b925301b', 8, 3),
    ('c974d8da-370b-461e-b9ee-54500b6d5a5f', 9, 4),
    ('c974d8da-370b-461e-b9ee-54500b6d5a5f', 10, 1),
    ('b2af2a57-2a62-4b43-9ef9-7b7e6eac21d9', 11, 2),
    ('b2af2a57-2a62-4b43-9ef9-7b7e6eac21d9', 12, 3),
    ('b2af2a57-2a62-4b43-9ef9-7b7e6eac21d9', 13, 4),
    ('14fd972c-c055-4ad0-9ed1-5e9fbb2f7b4c', 14, 2),
    ('14fd972c-c055-4ad0-9ed1-5e9fbb2f7b4c', 15, 1),
    ('f567609c-9d19-4b97-ae78-2b5c93224a2a', 16, 3),
    ('f567609c-9d19-4b97-ae78-2b5c93224a2a', 17, 2),
    ('f174b1e2-7c78-47a9-a812-9a5b1100977d', 1, 4),
    ('f174b1e2-7c78-47a9-a812-9a5b1100977d', 2, 2),
    ('8365ddbe-aa10-4eae-a6a2-02e1f9f5b9a7', 3, 1),
    ('8365ddbe-aa10-4eae-a6a2-02e1f9f5b9a7', 4, 3),
    ('8365ddbe-aa10-4eae-a6a2-02e1f9f5b9a7', 5, 4),
    ('7f180dda-81d5-4bfb-bd7e-4019ee430ec3', 6, 2),
    ('7f180dda-81d5-4bfb-bd7e-4019ee430ec3', 7, 1);

INSERT INTO Facturas (id, local_id, empleado_dni, fecha, comentario, subtotal, impuestos, descuento, importe_final, empresa_ruc) VALUES 
    ('7a99c239-94e2-4a77-bfa4-1de2a5a0b8e9', 1, '01234567', '2022-06-12', '', 254.91, 45.88, 4.50, 295.29, '20123456789'),
    ('6c62ee23-10a7-4c49-944d-9a3d92f249ae', 2, '01244567', '2022-09-28', '', 359.92, 64.79, 2.50, 421.21, '20234567890'),
    ('02e1e4a6-6d6e-4eb4-a717-95f91e5eab48', 3, '09098765', '2022-07-03', '', 299.89, 53.98, 6.50, 346.37, '20345678901'),
    ('9a438271-5720-49c2-bcd6-024f0d396a68', 4, '10987654', '2022-11-15', '', 298.84, 53.79, 4.00, 347.63, '20456789012'),
    ('36e7fcdf-6de7-41a6-9b46-71298431a40c', 5, '14892537', '2022-08-20', '', 299.80, 53.96, 2.00, 347.76, '20567890123');

INSERT INTO ProductosFactura (factura_id, producto_id, cantidad) VALUES
    ('7a99c239-94e2-4a77-bfa4-1de2a5a0b8e9', 1, 3),
    ('7a99c239-94e2-4a77-bfa4-1de2a5a0b8e9', 2, 2),
    ('7a99c239-94e2-4a77-bfa4-1de2a5a0b8e9', 3, 1),
    ('7a99c239-94e2-4a77-bfa4-1de2a5a0b8e9', 4, 4),
    ('7a99c239-94e2-4a77-bfa4-1de2a5a0b8e9', 5, 2),
    ('7a99c239-94e2-4a77-bfa4-1de2a5a0b8e9', 6, 3),
    ('7a99c239-94e2-4a77-bfa4-1de2a5a0b8e9', 7, 1),
    ('7a99c239-94e2-4a77-bfa4-1de2a5a0b8e9', 8, 4),
    ('7a99c239-94e2-4a77-bfa4-1de2a5a0b8e9', 9, 2),
    ('6c62ee23-10a7-4c49-944d-9a3d92f249ae', 10, 3),
    ('6c62ee23-10a7-4c49-944d-9a3d92f249ae', 11, 1),
    ('6c62ee23-10a7-4c49-944d-9a3d92f249ae', 12, 2),
    ('6c62ee23-10a7-4c49-944d-9a3d92f249ae', 13, 3),
    ('02e1e4a6-6d6e-4eb4-a717-95f91e5eab48', 14, 4),
    ('02e1e4a6-6d6e-4eb4-a717-95f91e5eab48', 15, 2),
    ('02e1e4a6-6d6e-4eb4-a717-95f91e5eab48', 16, 3),
    ('02e1e4a6-6d6e-4eb4-a717-95f91e5eab48', 17, 1),
    ('02e1e4a6-6d6e-4eb4-a717-95f91e5eab48', 1, 4),
    ('02e1e4a6-6d6e-4eb4-a717-95f91e5eab48', 2, 2),
    ('02e1e4a6-6d6e-4eb4-a717-95f91e5eab48', 3, 1),
    ('02e1e4a6-6d6e-4eb4-a717-95f91e5eab48', 4, 4),
    ('02e1e4a6-6d6e-4eb4-a717-95f91e5eab48', 5, 2),
    ('9a438271-5720-49c2-bcd6-024f0d396a68', 6, 3),
    ('9a438271-5720-49c2-bcd6-024f0d396a68', 7, 1),
    ('9a438271-5720-49c2-bcd6-024f0d396a68', 8, 4),
    ('9a438271-5720-49c2-bcd6-024f0d396a68', 9, 2),
    ('9a438271-5720-49c2-bcd6-024f0d396a68', 10, 3),
    ('9a438271-5720-49c2-bcd6-024f0d396a68', 11, 1),
    ('36e7fcdf-6de7-41a6-9b46-71298431a40c', 12, 2),
    ('36e7fcdf-6de7-41a6-9b46-71298431a40c', 13, 3),
    ('36e7fcdf-6de7-41a6-9b46-71298431a40c', 14, 4);

GO
CREATE PROCEDURE getUsuario
    @usuario VARCHAR(20)
AS
BEGIN
    SELECT usuario FROM Usuarios
    WHERE usuario = @usuario;
END;

GO
CREATE PROCEDURE setPassword
    @usuario VARCHAR(20),
    @newPassword VARCHAR(MAX)
AS
BEGIN
    UPDATE Usuarios
    SET clave = @newPassword
    WHERE usuario = @usuario;
END;

GO
CREATE PROCEDURE getPassword
    @usuario VARCHAR(20),
    @clave VARCHAR(MAX) OUTPUT
AS
BEGIN
    SELECT @clave = clave
    FROM Usuarios
    WHERE usuario = @usuario;
END;

GO
CREATE PROCEDURE getClientes
AS
BEGIN
    SELECT * FROM Clientes;
END;

GO
CREATE PROCEDURE addCliente
    @dni VARCHAR(8),
    @nombres VARCHAR(100),
    @apellidos VARCHAR(100),
    @telefono VARCHAR(13),
    @estado_civil VARCHAR(20),
    @direccion VARCHAR(200),
    @fecha_nacimiento DATE,
    @membresia VARCHAR(20)
AS
BEGIN
    INSERT INTO Clientes (dni, nombres, apellidos, telefono, estado_civil, direccion, fecha_nacimiento, membresia)
    VALUES (@dni, @nombres, @apellidos, @telefono, @estado_civil, @direccion, @fecha_nacimiento, @membresia);
END;

GO
CREATE PROCEDURE updateCliente (
    @p_dni VARCHAR(8),
    @p_nombres VARCHAR(100),
    @p_apellidos VARCHAR(100),
    @p_telefono VARCHAR(13),
    @p_estado_civil VARCHAR(20),
    @p_direccion VARCHAR(200),
    @p_fecha_nacimiento DATE,
    @p_membresia VARCHAR(20)
)
AS
BEGIN
    UPDATE Clientes
    SET nombres = @p_nombres,
        apellidos = @p_apellidos,
        telefono = @p_telefono,
        estado_civil = @p_estado_civil,
        direccion = @p_direccion,
        fecha_nacimiento = @p_fecha_nacimiento,
        membresia = @p_membresia
    WHERE dni = @p_dni;
END;

GO
CREATE PROCEDURE deleteCliente
    @dni VARCHAR(8)
AS
BEGIN
    DELETE FROM Clientes
    WHERE dni = @dni;
END;

GO
CREATE PROCEDURE getEmpresas
AS
BEGIN
    SELECT * FROM Empresas;
END;

GO
CREATE PROCEDURE addEmpresa
    @ruc VARCHAR(11),
    @nombre VARCHAR(100),
    @direccion VARCHAR(200),
    @telefono VARCHAR(13)
AS
BEGIN
    INSERT INTO Empresas (ruc, nombre, direccion, telefono)
    VALUES (@ruc, @nombre, @direccion, @telefono);
END;

GO
CREATE PROCEDURE updateEmpresa
    @ruc VARCHAR(11),
    @nombre VARCHAR(100),
    @direccion VARCHAR(200),
    @telefono VARCHAR(13)
AS
BEGIN
    UPDATE Empresas
    SET nombre = @nombre, 
        direccion = @direccion, 
        telefono = @telefono
    WHERE ruc = @ruc;
END;

GO
CREATE PROCEDURE deleteEmpresa
    @ruc VARCHAR(11)
AS
BEGIN
    DELETE FROM Empresas
    WHERE ruc = @ruc;
END;

GO
CREATE PROCEDURE getProveedores
AS
BEGIN
    SELECT * FROM Proveedores;
END;

GO
CREATE PROCEDURE getProductosProveedor
    @proveedor_id INT
AS
BEGIN
    SELECT id FROM Productos
    WHERE proveedor_id = @proveedor_id;
END;

GO
CREATE PROCEDURE addProveedor
    @nombre VARCHAR(100),
    @telefono VARCHAR(13),
    @descuento DECIMAL(15, 5),
    @id INT OUTPUT
AS
BEGIN
    INSERT INTO Proveedores (nombre, telefono, descuento)
    VALUES (@nombre, @telefono, @descuento);
    SET @id = SCOPE_IDENTITY();
END;

GO
CREATE PROCEDURE updateProveedor
    @id INT,
    @nombre VARCHAR(100),
    @telefono VARCHAR(13),
    @descuento DECIMAL(15,5)
AS
BEGIN
    UPDATE Proveedores
    SET nombre = @nombre,
        telefono = @telefono,
        descuento = @descuento
    WHERE id = @id;
END;

GO
CREATE PROCEDURE updateProveedorProducto
    @id INT,
    @proveedor_id INT
AS
BEGIN
    UPDATE Productos SET proveedor_id = @proveedor_id WHERE id = @id;
END;

GO
CREATE PROCEDURE deleteProveedor
    @id INT
AS
BEGIN
    BEGIN TRANSACTION;
    
    DELETE FROM Productos
    WHERE proveedor_id = @id;
    
    DELETE FROM Proveedores
    WHERE id = @id;
    
    COMMIT;
END;

GO
CREATE PROCEDURE getLocales
AS
BEGIN
    SELECT * FROM Locales;
END;

GO
CREATE PROCEDURE getProductosLocal
    @local_id INT
AS
BEGIN
    SELECT producto_id FROM ProductosLocal
    WHERE local_id = @local_id
END;

GO
CREATE PROCEDURE getEmpleadosLocal
    @local_id INT
AS
BEGIN
    SELECT dni FROM Empleados
    WHERE local_id = @local_id
END;

GO
CREATE PROCEDURE addLocal
    @direccion VARCHAR(200),
    @telefono VARCHAR(13),
    @comentario VARCHAR(200),
    @id INT OUTPUT
AS
BEGIN
    INSERT INTO Locales (direccion, telefono, comentario)
    VALUES (@direccion, @telefono, @comentario);
    SET @id = SCOPE_IDENTITY();
END;

GO
CREATE PROCEDURE updateLocal
    @id INT,
    @direccion VARCHAR(200),
    @telefono VARCHAR(13),
    @comentario VARCHAR(200)
AS
BEGIN
    UPDATE Locales
    SET direccion = @direccion,
        telefono = @telefono,
        comentario = @comentario
    WHERE id = @id;
END;

GO
CREATE PROCEDURE updateProductosLocal
    @local_id INT,
    @producto_ids VARCHAR(MAX)
AS
BEGIN
    DELETE FROM ProductosLocal
    WHERE local_id = @local_id
    AND producto_id NOT IN (
        SELECT value FROM STRING_SPLIT(@producto_ids, ',')
    );

    INSERT INTO ProductosLocal (local_id, producto_id)
    SELECT @local_id, value
    FROM STRING_SPLIT(@producto_ids, ',')
    WHERE value NOT IN (
        SELECT producto_id FROM ProductosLocal WHERE local_id = @local_id
    );
END;

GO
CREATE PROCEDURE updateLocalEmpleado
    @dni VARCHAR(8),
    @local_id INT
AS
BEGIN
    UPDATE Empleados SET local_id = @local_id WHERE dni = @dni;
END;

GO
CREATE PROCEDURE deleteLocal
    @local_id INT
AS
BEGIN
    BEGIN TRANSACTION;

    DELETE FROM ProductosLocal
    WHERE local_id = @local_id;

    UPDATE Empleados
    SET local_id = NULL
    WHERE local_id = @local_id;

    DELETE FROM Locales
    WHERE id = @local_id;
    
    COMMIT;
END;

GO
CREATE PROCEDURE getEmpleados
AS
BEGIN
    SELECT * FROM Empleados;
END;

GO
CREATE PROCEDURE addEmpleado
    @dni VARCHAR(8),
    @nombres VARCHAR(100),
    @apellidos VARCHAR(100),
    @telefono VARCHAR(13),
    @estado_civil VARCHAR(20),
    @direccion VARCHAR(200),
    @fecha_nacimiento DATE,
    @cargo VARCHAR(100),
    @salario DECIMAL(10, 2),
    @local_id INT
AS
BEGIN
    INSERT INTO Empleados (dni, nombres, apellidos, telefono, estado_civil, direccion, fecha_nacimiento, cargo, salario, local_id)
    VALUES (@dni, @nombres, @apellidos, @telefono, @estado_civil, @direccion, @fecha_nacimiento, @cargo, @salario, @local_id);
END;

GO
CREATE PROCEDURE updateEmpleado
    @dni VARCHAR(8),
    @nombres VARCHAR(100),
    @apellidos VARCHAR(100),
    @telefono VARCHAR(13),
    @estado_civil VARCHAR(20),
    @direccion VARCHAR(200),
    @fecha_nacimiento DATE,
    @cargo VARCHAR(100),
    @salario DECIMAL(10, 2),
    @local_id INT
AS
BEGIN
    UPDATE Empleados
    SET nombres = @nombres,
        apellidos = @apellidos,
        telefono = @telefono,
        estado_civil = @estado_civil,
        direccion = @direccion,
        fecha_nacimiento = @fecha_nacimiento,
        cargo = @cargo,
        salario = @salario,
        local_id = @local_id
    WHERE dni = @dni;
END;

GO
CREATE PROCEDURE deleteEmpleado
    @dni VARCHAR(8)
AS
BEGIN
    DELETE FROM Empleados
    WHERE dni = @dni;
END;

GO
CREATE PROCEDURE getProductos
AS
BEGIN
    SELECT * FROM Productos;
END;

GO
CREATE PROCEDURE addProducto
    @nombre VARCHAR(100),
    @precio DECIMAL(10, 2),
    @cantidad INT,
    @proveedor_id INT,
    @id INT OUTPUT
AS
BEGIN
    INSERT INTO Productos (nombre, precio, cantidad, proveedor_id)
    VALUES (@nombre, @precio, @cantidad, @proveedor_id);
    SET @id = SCOPE_IDENTITY();
END;

GO
CREATE PROCEDURE updateProducto
    @id INT,
    @nombre VARCHAR(100),
    @precio DECIMAL(10, 2),
    @cantidad INT,
    @proveedor_id INT
AS
BEGIN
    UPDATE Productos
    SET nombre = @nombre,
        precio = @precio,
        cantidad = @cantidad,
        proveedor_id = @proveedor_id
    WHERE id = @id;
END;

GO
CREATE PROCEDURE deleteProducto
    @id INT
AS
BEGIN
    BEGIN TRANSACTION;
    
    DELETE FROM ProductosLocal
    WHERE producto_id = @id;
    
    DELETE FROM Productos
    WHERE id = @id;

    COMMIT;
END;

GO
CREATE PROCEDURE getBoletas
AS
BEGIN
    SELECT * FROM Boletas;
END;

GO
CREATE PROCEDURE getProductosBoleta
    @boleta_id VARCHAR(36)
AS
BEGIN
    SELECT producto_id, cantidad FROM ProductosBoleta
    WHERE boleta_id = @boleta_id;
END;

GO
CREATE PROCEDURE addBoleta
    @boleta_id VARCHAR(36),
    @local_id INT,
    @empleadoDni VARCHAR(8),
    @fecha DATE,
    @comentario VARCHAR(255),
    @subtotal DECIMAL(10, 2),
    @descuento DECIMAL(15, 5),
    @importeFinal DECIMAL(10, 2),
    @clienteDni VARCHAR(8)
AS
BEGIN
    INSERT INTO Boletas (id, local_id, empleado_dni, fecha, comentario, subtotal, descuento, importe_final, cliente_dni)
    VALUES (@boleta_id, @local_id, @empleadoDni, @fecha, @comentario, @subtotal, @descuento, @importeFinal, @clienteDni);
END;

GO
CREATE PROCEDURE addProductosBoleta
    @boleta_id VARCHAR(36),
    @producto_id INT,
    @cantidad INT
AS
BEGIN
    UPDATE Productos
    SET cantidad = cantidad - @cantidad
    WHERE id = @producto_id;
    
    INSERT INTO ProductosBoleta (boleta_id, producto_id, cantidad)
    VALUES (@boleta_id, @producto_id, @cantidad);
END;

GO
CREATE PROCEDURE updateBoleta
    @boleta_id VARCHAR(36),
    @comentario VARCHAR(255)
AS
BEGIN
    UPDATE Boletas
    SET comentario = @comentario
    WHERE id = @boleta_id;
END;

GO
CREATE PROCEDURE deleteBoleta
    @boleta_id VARCHAR(36)
AS
BEGIN
    BEGIN TRANSACTION;

    DELETE FROM ProductosBoleta 
    WHERE boleta_id = @boleta_id;

    DELETE FROM Boletas 
    WHERE id = @boleta_id;

    COMMIT;
END;

GO
CREATE PROCEDURE getFacturas
AS
BEGIN
    SELECT * FROM Facturas;
END;

GO
CREATE PROCEDURE getProductosFactura
    @factura_id VARCHAR(36)
AS
BEGIN
    SELECT producto_id, cantidad FROM ProductosFactura
    WHERE factura_id = @factura_id;
END;

GO
CREATE PROCEDURE addFactura
    @factura_id VARCHAR(36),
    @local_id INT,
    @empleado_dni VARCHAR(8),
    @fecha DATE,
    @comentario VARCHAR(255),
    @subtotal DECIMAL(10, 2),
    @impuestos DECIMAL(10, 2),
    @descuento DECIMAL(15, 5),
    @importe_final DECIMAL(10, 2),
    @empresa_ruc VARCHAR(11)
AS
BEGIN
    INSERT INTO Facturas (id, local_id, empleado_dni, fecha, comentario, subtotal, impuestos, descuento, importe_final, empresa_ruc)
    VALUES (@factura_id, @local_id, @empleado_dni, @fecha, @comentario, @subtotal, @impuestos, @descuento, @importe_final, @empresa_ruc);
END;

GO
CREATE PROCEDURE addProductosFactura
    @factura_id VARCHAR(36),
    @producto_id INT,
    @cantidad INT
AS
BEGIN
    UPDATE Productos
    SET cantidad = cantidad - @cantidad
    WHERE id = @producto_id;
    
    INSERT INTO ProductosFactura (factura_id, producto_id, cantidad)
    VALUES (@factura_id, @producto_id, @cantidad);
END;

GO
CREATE PROCEDURE updateFactura
    @factura_id VARCHAR(36),
    @comentario VARCHAR(255)
AS
BEGIN
    UPDATE Facturas
    SET comentario = @comentario
    WHERE id = @factura_id;
END;

GO
CREATE PROCEDURE deleteFactura
    @factura_id VARCHAR(36)
AS
BEGIN
    BEGIN TRANSACTION;

    DELETE FROM ProductosFactura
    WHERE factura_id = @factura_id;

    DELETE FROM Facturas
    WHERE id = @factura_id;

    COMMIT;
END;

GO
CREATE PROCEDURE getTotalGanancias
AS
BEGIN
    DECLARE @boletas_count INT;
    DECLARE @facturas_count INT;
    DECLARE @boletas_importe DECIMAL(10, 2);
    DECLARE @facturas_importe DECIMAL(10, 2);

    SELECT @boletas_count = COUNT(*) FROM Boletas;
    SELECT @facturas_count = COUNT(*) FROM Facturas;
    SELECT @boletas_importe = SUM(importe_final) FROM Boletas;
    SELECT @facturas_importe = SUM(importe_final) FROM Facturas;

    SELECT @boletas_count + @facturas_count AS total_count,
           @boletas_importe + @facturas_importe AS total_importe;
END;

GO
CREATE PROCEDURE getProductoMasVendido
AS
BEGIN
    SELECT TOP 1 producto_id AS producto_popular, SUM(vendidos) AS total_vendidos
    FROM (
        SELECT producto_id, SUM(cantidad) AS vendidos
        FROM (
            SELECT producto_id, cantidad FROM ProductosFactura
            UNION ALL
            SELECT producto_id, cantidad FROM ProductosBoleta
        ) AS combinedProducts
        GROUP BY producto_id
    ) AS groupedProducts
    GROUP BY producto_id
    ORDER BY SUM(vendidos) DESC;
END;

/*SELECT * FROM Usuarios;

EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';
EXEC sp_MSforeachtable 'DELETE FROM ?';
EXEC sp_MSforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL';

SELECT 'DROP PROCEDURE ' + OBJECT_SCHEMA_NAME(object_id) + '.' + name + ';'
FROM sys.procedures;

SELECT 'DROP TABLE ' + OBJECT_SCHEMA_NAME(object_id) + '.' + name + ';'
FROM sys.tables;*/