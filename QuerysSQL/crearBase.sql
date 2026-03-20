CREATE DATABASE ZervePos
ON PRIMARY
(
    NAME = ZervePos_Data,
    FILENAME = 'C:\ZervePOS\ZervePOS.mdf'
)
LOG ON
(
    NAME = ZervePos_Log,
    FILENAME = 'C:\ZervePOS\ZervePOS.ldf'
);

USE ZervePos;
    
-------------------------------------------------
-- TABLA CLIENTES
-------------------------------------------------

CREATE TABLE Clientes(

ClienteId NCHAR(5) NOT NULL,
Negocio NVARCHAR(40) NOT NULL,
NombreCliente NVARCHAR(30),
TituloContacto NVARCHAR(30),
Direccion NVARCHAR(60),
Ciudad NVARCHAR(15),
Colonia NVARCHAR(15),
CodigoPostal NVARCHAR(10),
Telefono NVARCHAR(24),
Correo NVARCHAR(40),

CONSTRAINT PK_Clientes
PRIMARY KEY (ClienteId)

);

-------------------------------------------------
-- TABLA PRODUCTOS
-------------------------------------------------

CREATE TABLE Productos(

ProductoId INT IDENTITY(1,1) NOT NULL,
NombreProducto NVARCHAR(40) NOT NULL,
PrecioUnitario MONEY NOT NULL,
UnidadesEnStock SMALLINT NOT NULL,

CONSTRAINT PK_Productos
PRIMARY KEY (ProductoId),

CONSTRAINT CHK_Productos_Precio
CHECK (PrecioUnitario > 0),

CONSTRAINT CHK_Productos_Stock
CHECK (UnidadesEnStock >= 0)

);

ALTER TABLE Productos
ADD CONSTRAINT DF_UNIDADES
DEFAULT 0 FOR UnidadesEnStock;

INSERT INTO Productos (NombreProducto, PrecioUnitario, UnidadesEnStock)
VALUES
('Coca Cola 600ml', 18.50, 120),
('Sabritas Flamin Hot 45g', 16.00, 80),
('Tortillas de maíz 1kg', 22.00, 50),
('Pan Bimbo blanco grande', 43.00, 35),
('Huevos blancos docena', 42.00, 60),
('Leche Lala entera 1L', 28.00, 45),
('Azúcar estándar 1kg', 28.50, 70),
('Arroz Morelos 1kg', 32.00, 65),
('Frijol pinto 1kg', 36.00, 55),
('Aceite Nutrioli 1L', 48.00, 40),
('Atún Dolores en agua 140g', 22.00, 75),
('Galletas Marías Gamesa 170g', 18.00, 90),
('Refresco Pepsi 2L', 30.00, 60),
('Mayonesa McCormick 390g', 45.00, 30),
('Suavitel Fresca Primavera 850ml', 35.00, 25);

-------------------------------------------------
-- TABLA EMPLEADOS
-------------------------------------------------

CREATE TABLE Empleados(

EmpleadoId INT IDENTITY(1,1) NOT NULL,
Apellidos NVARCHAR(20) NOT NULL,
Nombre NVARCHAR(10) NOT NULL,
FechaNacimiento DATETIME,
Direccion NVARCHAR(60),
Ciudad NVARCHAR(15),
CodigoPostal NVARCHAR(10),
Telefono NVARCHAR(24),

Rol NVARCHAR(20)
CONSTRAINT CHK_Rol
CHECK (Rol IN ('Administrador','Cajero','Dueño')),

CONSTRAINT PK_Empleados
PRIMARY KEY (EmpleadoId)

);

INSERT INTO Empleados
(Apellidos, Nombre, FechaNacimiento, Direccion, Ciudad, CodigoPostal, Telefono, Rol)
VALUES
('Administrador','Sistema','2026-01-01','Oficina Central','Tepic','63000','3110000000','Administrador');

-------------------------------------------------
-- TABLA USUARIOS
-------------------------------------------------

CREATE TABLE Usuarios(

UsuariosId INT IDENTITY(1,1) NOT NULL,

EmpleadoId INT NOT NULL,

NombreUsuario VARCHAR(30) NOT NULL,
Contrasena VARCHAR(20) NOT NULL,

CONSTRAINT PK_Usuarios
PRIMARY KEY (UsuariosId),

CONSTRAINT FK_Usuarios_Empleado
FOREIGN KEY (EmpleadoId)
REFERENCES Empleados(EmpleadoId)

);

ALTER TABLE Usuarios ADD CONSTRAINT UQ_Usuario UNIQUE (NombreUsuario);

INSERT INTO Usuarios (EmpleadoId, NombreUsuario, Contrasena)
VALUES (1,'administrador','administrador');

-------------------------------------------------
-- TABLA SUCURSALES
-------------------------------------------------

CREATE TABLE Sucursales(

SucursalId INT IDENTITY(1,1) NOT NULL,
NombreSucursal NVARCHAR(50) NOT NULL,
Direccion NVARCHAR(100),
Ciudad NVARCHAR(50),
Telefono NVARCHAR(20),

CONSTRAINT PK_Sucursales
PRIMARY KEY (SucursalId)

);

-------------------------------------------------
-- TABLA PRODUCTOS EN INVENTARIO
-------------------------------------------------

CREATE TABLE Inventario(

ProductoId INT NOT NULL,
SucursalId INT NOT NULL,
Inventario INT NOT NULL,

CONSTRAINT PK_Inventario
PRIMARY KEY (ProductoId, SucursalId),

CONSTRAINT FK_Inventario_Producto
FOREIGN KEY (ProductoId)
REFERENCES Productos(ProductoId),

CONSTRAINT FK_Inventario_Sucursal
FOREIGN KEY (SucursalId)
REFERENCES Sucursales(SucursalId),

CONSTRAINT CHK_Inventario_Stock
CHECK (Inventario >= 0)

);

-------------------------------------------------
-- TABLA VENTAS
-------------------------------------------------

CREATE TABLE Ventas(

VentaId INT IDENTITY(1,1) NOT NULL,
ClienteId NCHAR(5) NOT NULL,
EmpleadoId INT NOT NULL,
FechaVenta DATETIME NOT NULL,

CONSTRAINT PK_Ventas
PRIMARY KEY (VentaId),

CONSTRAINT FK_Ventas_Clientes
FOREIGN KEY (ClienteId)
REFERENCES Clientes(ClienteId),

CONSTRAINT FK_Ventas_Empleados
FOREIGN KEY (EmpleadoId)
REFERENCES Empleados(EmpleadoId)

);

ALTER TABLE Ventas
ADD CONSTRAINT DF_Ventas_Fecha
DEFAULT GETDATE() FOR FechaVenta;

-------------------------------------------------
-- TABLA DETALLES DE VENTA
-------------------------------------------------

CREATE TABLE DetallesVenta(

VentaId INT NOT NULL,
ProductoId INT NOT NULL,
PrecioUnitario MONEY NOT NULL,
Cantidad SMALLINT NOT NULL,
Descuento REAL NOT NULL,

CONSTRAINT PK_DetallesVenta
PRIMARY KEY (VentaId, ProductoId),

CONSTRAINT FK_DetallesVenta_Ventas
FOREIGN KEY (VentaId)
REFERENCES Ventas(VentaId),

CONSTRAINT FK_DetallesVenta_Productos
FOREIGN KEY (ProductoId)
REFERENCES Productos(ProductoId),

CONSTRAINT CHK_DetallesVenta_Cantidad
CHECK (Cantidad > 0),

CONSTRAINT CHK_DetallesVenta_Precio
CHECK (PrecioUnitario > 0),

CONSTRAINT CHK_DetallesVenta_Descuento
CHECK (Descuento >= 0 AND Descuento <= 1)

);

-------------------------------------------------
-- TABLA CREDITOS
-------------------------------------------------

CREATE TABLE Creditos(

CreditoId INT IDENTITY(1,1) NOT NULL,
ClienteId NCHAR(5) NOT NULL,
VentaId INT NOT NULL,
FechaCredito DATETIME NOT NULL,
MontoTotal MONEY NOT NULL,
SaldoActual MONEY NOT NULL,
Estado NVARCHAR(15) NOT NULL,

CONSTRAINT PK_Creditos
PRIMARY KEY (CreditoId),

CONSTRAINT FK_Creditos_Clientes
FOREIGN KEY (ClienteId)
REFERENCES Clientes(ClienteId),

CONSTRAINT FK_Creditos_Ventas
FOREIGN KEY (VentaId)
REFERENCES Ventas(VentaId),

CONSTRAINT CHK_Creditos_Monto
CHECK (MontoTotal >= 0),

CONSTRAINT CHK_Creditos_Saldo
CHECK (SaldoActual >= 0),

CONSTRAINT CHK_Creditos_Estado
CHECK (Estado IN ('ACTIVO','PAGADO','CANCELADO'))

);

ALTER TABLE Creditos
ADD CONSTRAINT DF_Creditos_Fecha
DEFAULT GETDATE() FOR FechaCredito;

ALTER TABLE Creditos
ADD CONSTRAINT DF_Creditos_Estado
DEFAULT 'ACTIVO' FOR Estado;

-------------------------------------------------
-- TABLA ABONOS A CREDITOS
-------------------------------------------------

CREATE TABLE AbonosCreditos(

AbonoId INT IDENTITY(1,1) NOT NULL,
CreditoId INT NOT NULL,
FechaAbono DATETIME NOT NULL,
MontoAbono MONEY NOT NULL,
MetodoPago NVARCHAR(20),

CONSTRAINT PK_AbonosCreditos
PRIMARY KEY (AbonoId),

CONSTRAINT FK_Abonos_Creditos
FOREIGN KEY (CreditoId)
REFERENCES Creditos(CreditoId),

CONSTRAINT CHK_Abonos_Monto
CHECK (MontoAbono > 0),

CONSTRAINT CHK_Abonos_MetodoPago
CHECK (MetodoPago IN ('EFECTIVO','TARJETA','TRANSFERENCIA','DEPOSITO') OR MetodoPago IS NULL)

);

ALTER TABLE AbonosCreditos
ADD CONSTRAINT DF_Abonos_Fecha
DEFAULT GETDATE() FOR FechaAbono;

-------------------------------------------------
-- TABLA CAJA
-------------------------------------------------

CREATE TABLE Caja(

CajaId INT IDENTITY(1,1) NOT NULL,
EmpleadoId INT NOT NULL,
FechaApertura DATETIME NOT NULL,
MontoInicial MONEY NOT NULL,
Estado NVARCHAR(10) NOT NULL,

CONSTRAINT PK_Caja
PRIMARY KEY (CajaId),

CONSTRAINT FK_Caja_Empleado
FOREIGN KEY (EmpleadoId)
REFERENCES Empleados(EmpleadoId),

CONSTRAINT CHK_Caja_MontoInicial
CHECK (MontoInicial >= 0),

CONSTRAINT CHK_Caja_Estado
CHECK (Estado IN ('ABIERTA','CERRADA'))

);

ALTER TABLE Caja
ADD CONSTRAINT DF_Caja_Fecha
DEFAULT GETDATE() FOR FechaApertura;

-------------------------------------------------
-- TABLA MOVIMIENTOS INVENTARIO
-------------------------------------------------

CREATE TABLE MovimientosInventario(

MovimientoId INT IDENTITY(1,1) NOT NULL,
ProductoId INT NOT NULL,
SucursalId INT NOT NULL,
EmpleadoId INT NOT NULL,
TipoMovimiento NVARCHAR(15) NOT NULL,
Cantidad INT NOT NULL,
Descripcion NVARCHAR(30),

FechaMovimiento DATETIME NOT NULL
DEFAULT(GETDATE()),

CONSTRAINT PK_MovimientosInventario
PRIMARY KEY (MovimientoId),

CONSTRAINT FK_Movimientos_Producto
FOREIGN KEY (ProductoId)
REFERENCES Productos(ProductoId),

CONSTRAINT FK_Movimientos_Sucursal
FOREIGN KEY (SucursalId)
REFERENCES Sucursales(SucursalId),

CONSTRAINT FK_Movimientos_Empleado
FOREIGN KEY (EmpleadoId)
REFERENCES Empleados(EmpleadoId),

CONSTRAINT CHK_Movimientos_Tipo
CHECK (TipoMovimiento IN ('ENTRADA','SALIDA','AJUSTE','TRANSFERENCIA')),

CONSTRAINT CHK_Movimientos_Cantidad
CHECK (Cantidad > 0)

);

-------------------------------------------------
-- TABLA INICIOS DE SESION
-------------------------------------------------

CREATE TABLE IniciosSesion(

SesionId INT IDENTITY(1,1) NOT NULL,
EmpleadoId INT NOT NULL,
FechaInicio DATETIME NOT NULL,
FechaCierre DATETIME,
DireccionIP NVARCHAR(50),

CONSTRAINT PK_IniciosSesion
PRIMARY KEY (SesionId),

CONSTRAINT FK_IniciosSesion_Empleado
FOREIGN KEY (EmpleadoId)
REFERENCES Empleados(EmpleadoId)

);

ALTER TABLE IniciosSesion
ADD CONSTRAINT DF_IniciosSesion_Fecha
DEFAULT GETDATE() FOR FechaInicio;

