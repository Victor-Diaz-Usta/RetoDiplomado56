/*/
RETO PARTE A: DISEÑO DEL ESQUEMA RELACIONAL
Estudiante: Diego Alejandro Gómez Cortes
Fecha: 19/01/2026

```
1. Construccion o creacion de las tablas Maestras

-- =======================================================
-- TABLAS MAESTRAS (Clientes, Productos, Sucursales)
-- =======================================================

Tabla Cliente

*/

CREATE TABLE Clientes ( 
    ClienteID INT IDENTITY(1,1) PRIMARY KEY, --IDENTITY(inicio, incremento)
    Cliente_Nombre VARCHAR(100) NOT NULL, -- Nombre no puede ser nulo
    Cliente_Email VARCHAR(100) NOT NULL UNIQUE ); -- Email no puede ser nulo y debe ser unico 

/*/

Tabla Producto

*/

CREATE TABLE Productos (
    ProductoID INT IDENTITY(1000,10) PRIMARY KEY,
    Productos VARCHAR(100) NOT NULL,
    Categoria VARCHAR(100) NOT NULL,
    Precio_Unitario DECIMAL(10,2) NOT NULL
);

/*/

Tabla Sucursal

*/

CREATE TABLE Sucursales (
    SucursalID INT IDENTITY(10000,1) PRIMARY KEY,
    Sucursal_Nombre VARCHAR(100) NOT NULL,
    Ciudad_Sucursal VARCHAR(100) NOT NULL
);

/*/

-- =======================================================
-- TABLA TRANSACCIONAL (Ventas)
-- =======================================================

*/

CREATE TABLE Ventas (
    VentaID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT NOT NULL,
    ProductoID INT NOT NULL,
    SucursalID INT NOT NULL,
    Fecha_Venta DATE NOT NULL,
    Cantidad INT NOT NULL,

    CONSTRAINT FK_Ventas_Clientes
        FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),

    CONSTRAINT FK_Ventas_Productos
        FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID),

    CONSTRAINT FK_Ventas_Sucursales
        FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID)
);


/*/

2. Insertar datos para cada tabla creada

-- =======================================================
-- TABLAS MAESTRAS (Clientes, Productos, Sucursales)
-- =======================================================

Insertar datos en la tabla Cliente 
 - Primero validaremos los datos que se van a insertar
 - Luego haremos el insert

*/

SELECT
    MAX(Cliente_Nombre) AS Cliente_Nombre,
    UPPER(TRIM(Cliente_Email)) AS Cliente_Email
FROM raw_sales
GROUP BY UPPER(TRIM(Cliente_Email));

INSERT INTO Clientes (Cliente_Nombre, Cliente_Email)
SELECT
    MAX(Cliente_Nombre) AS Cliente_Nombre,
    UPPER(TRIM(Cliente_Email)) AS Cliente_Email
FROM raw_sales
GROUP BY UPPER(TRIM(Cliente_Email));

SELECT * FROM Clientes;

/*/

Insertar datos en la tabla Producto
 - Primero validaremos los datos que se van a insertar y miramos cuantas veces se repiten
 - Luego haremos el insert

*/

SELECT Producto,
    Categoria,
    Precio_Unitario,
    COUNT(*) AS repeticiones
FROM raw_sales
GROUP BY Producto, Categoria, Precio_Unitario
ORDER BY repeticiones DESC;

INSERT INTO Productos (Productos, Categoria, Precio_Unitario)
SELECT DISTINCT
    Producto,
    Categoria,
    Precio_Unitario
FROM raw_sales;

SELECT * FROM Productos;

/*/

Insertar datos en la tabla Sucursal
 - Primero validaremos los datos que se van a insertar
 - Luego haremos el insert

*/

SELECT
    Sucursal,
    Ciudad_Sucursal,
    COUNT(*) AS repeticiones
FROM raw_sales
GROUP BY Sucursal, Ciudad_Sucursal
ORDER BY repeticiones DESC;

INSERT INTO Sucursales (Sucursal_Nombre, Ciudad_Sucursal)
SELECT DISTINCT
    Sucursal,
    Ciudad_Sucursal
FROM raw_sales;

SELECT * FROM Sucursales;
-- DELETE FROM Sucursales;

/*/

-- =======================================================
-- INSERTAR DATOS EN LA TABLA TRANSACCIONAL (Ventas)
-- =======================================================

 - Insertar datos en la tabla Ventas
 
*/

INSERT INTO Ventas ( ClienteID, ProductoID, SucursalID, -- llaves foraneas
    Fecha_Venta, Cantidad -- datos transaccionales de la base raw_sales r
)
SELECT
    c.ClienteID,
    p.ProductoID,
    s.SucursalID,
    r.Fecha_Venta,
    r.Cantidad
FROM raw_sales r
JOIN Clientes c
    ON UPPER(TRIM(r.Cliente_Email)) = c.Cliente_Email
JOIN Productos p
    ON r.Producto = p.Productos
   AND r.Categoria = p.Categoria
   AND r.Precio_Unitario = p.Precio_Unitario
JOIN Sucursales s
    ON r.Sucursal = s.Sucursal_Nombre
   AND r.Ciudad_Sucursal = s.Ciudad_Sucursal;

SELECT * FROM Ventas;