/* PROYECTO: E-commerce Business Intelligence Pipeline
==============================================================================
AUTOR: Paula Ramos Delgado
DESCRIPCIÓN: Transformación de datos de tabla plana (Denormalizada) a 
             Modelo en Estrella (Normalizado).
HERRAMIENTAS: MySQL 
==============================================================================
*/

/* Justificación del Modelo
==============================================================================
Se separa la información en Dimensiones (Dim) y Hechos (Fact) para eliminar 
la redundancia de datos, mejorar la integridad referencial y optimizar la 
velocidad de respuesta de Power BI al filtrar por atributos específicos 
(Clientes/Productos).
==============================================================================
*/

CREATE TABLE dim_clientes AS
SELECT DISTINCT 
    CustomerID, 
    Country
FROM ventas_raw;
ALTER TABLE dim_clientes ADD PRIMARY KEY (CustomerID);

# ========================================================================== #

CREATE TABLE dim_productos AS
SELECT DISTINCT 
    StockCode, 
    Description
FROM ventas_raw;
ALTER TABLE dim_productos ADD PRIMARY KEY (StockCode);

# ========================================================================== #

CREATE TABLE fact_ventas AS
SELECT 
    InvoiceNo,
    StockCode,
    CustomerID,
    InvoiceDate,
    UnitPrice,
    TotalAmount
FROM ventas_raw;

# ========================================================================== #

DROP TABLE ventas_raw;

SELECT * FROM dim_clientes; 
SELECT * FROM dim_productos; 
SELECT * FROM fact_ventas; 