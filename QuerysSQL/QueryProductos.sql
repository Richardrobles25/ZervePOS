use ZervePos
SELECT * FROM Productos
SELECT * FROM Inventario

Select * from Usuarios

SELECT * FROM Productos


ALTER TABLE Productos
DROP COLUMN Descontinuado;

CREATE LOGIN logRasshidZervePos WITH PASSWORD = '1234';
CREATE USER usRasshidZervePos FOR LOGIN logRasshidZervePos;
use master

ALTER ROLE db_datareader ADD MEMBER logRasshidZervePos;
ALTER ROLE db_datawriter ADD MEMBER logRasshidZervePos;

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

CREATE ROLE RSUPERADMIN;
EXEC sp_addrolemember db_datawriter,RSUPERADMIN;
EXEC sp_addrolemember db_datareader,RSUPERADMIN;
EXEC sp_addrolemember db_ddladmin,RSUPERADMIN;
ALTER ROLE RSUPERADMIN ADD MEMBER logRasshidZervePos;


-- 1. Asegurarnos de estar en el nivel de servidor maestro
USE master;
GO

-- 2. Crear el Login a nivel de servidor (con la contraseña que tienes en tu PHP)
-- Si el login ya existe, lo borramos y lo recreamos para evitar errores
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = N'logRasshidZervePos')
    DROP LOGIN [logRasshidZervePos];
GO

CREATE LOGIN [logRasshidZervePos] WITH PASSWORD = N'1234', 
    DEFAULT_DATABASE = [ZervePOS], 
    CHECK_EXPIRATION = OFF, 
    CHECK_POLICY = OFF;
GO

-- 3. Movernos a tu base de datos
USE ZervePOS;
GO

-- 4. Crear el usuario dentro de la base de datos (eliminándolo primero si ya estaba roto)
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'logRasshidZervePos')
    DROP USER [logRasshidZervePos];
GO

CREATE USER [logRasshidZervePos] FOR LOGIN [logRasshidZervePos];
GO

-- 5. Asignar los permisos de lectura y escritura
ALTER ROLE db_datareader ADD MEMBER [logRasshidZervePos];
ALTER ROLE db_datawriter ADD MEMBER [logRasshidZervePos];
GO
