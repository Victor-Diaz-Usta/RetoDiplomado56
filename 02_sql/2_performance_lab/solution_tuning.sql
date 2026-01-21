/*/

RETO PARTE B: LABORATORIO DE PERFORMANCE
Estudiante: Victor Hugo Díaz
Objetivo: Comparar CROSS JOIN vs INNER JOIN usando métricas reales

*/
-- Activar estadisticas de rendimiento
SET STATISTICS IO ON;   -- Lecturas lógicas de disco
SET STATISTICS TIME ON; -- Tiempo de CPU

/*/
-- ===============================================================
-- CROSS JOIN DEMOSTRANDO EL PROBLEMA QUE PUEDE LLEGAR A SER 
-- ===============================================================

-- Combinar cada fila de la tabla A con cada fila de la tabla B, sin importar si tienen relación o no.
-- NO usa claves foráneas

*/

SELECT
    c.Cliente_Nombre,
    p.Productos
FROM Clientes c
CROSS JOIN Productos p;


-- =======================================================
-- INNER JOIN - LA EFICIENCIA DE USARLO 
-- =======================================================

-- Utilizando la tabla transaccional Ventas y las claves foráneas para unir solo registros existentes.
-- Uniendo filas de dos (o más) tablas solo cuando existe una relación válida entre ellas.

SELECT
    c.Cliente_Nombre AS Cliente,
    p.Productos AS Producto,
    v.Fecha_Venta,
    v.Cantidad
FROM Ventas v
INNER JOIN Clientes c
    ON v.ClienteID = c.ClienteID
INNER JOIN Productos p
    ON v.ProductoID = p.ProductoID;