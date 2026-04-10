/*ESTRATEGIA DE NEGOCIO Y ANÁLISIS AVANZADO DE E-COMMERCE
==============================================================================
DESCRIPCIÓN: Este script extrae inteligencia de negocio de alto nivel 
             utilizando funciones analíticas avanzadas.
OBJETIVO: Proporcionar métricas clave sobre fidelización, tendencias 
          temporales y concentración de ingresos para soporte ejecutivo.
AUTOR: Paula Ramos Delgado
==============================================================================
*/

-- ======================================================
-- Top 5 de paises que mas ingresos han generado: 
-- ======================================================
SELECT 
c.country, 
ROUND(SUM(v.TotalAmount),2)  AS Total_por_continente
FROM fact_ventas AS v
JOIN dim_clientes c ON c.CustomerID=v.CustomerID
GROUP BY country
ORDER BY Total_por_continente DESC
LIMIT 5; 

-- ==================================================================================================
-- Análisis de fidelización
-- Identificar cuando realizo la ultima compra cada cliente, para saber quien nos abandona
-- ==================================================================================================
SELECT
v.customerID, 
MAX(v.InvoiceDate) AS Ultima_Compra, 
DATEDIFF('2011-12-10', MAX(v.InvoiceDate)) AS Dias_inactivo
FROM fact_ventas v
GROUP BY CustomerID
ORDER BY Dias_Inactivo DESC; 

-- ==================================================================================================
-- Análisis de concentracion de ventas 
-- Conocer el producto que ha generado mas del 5% de las ventas 
-- ==================================================================================================
WITH VentasPorProducto AS (
    SELECT 
        p.Description,
        SUM(v.TotalAmount) AS Ingresos_producto,
        (SUM(v.TotalAmount) / (SELECT SUM(TotalAmount) FROM fact_ventas)) * 100 AS Porcentaje_Individual
    FROM fact_ventas v
    JOIN dim_productos p ON v.StockCode = p.StockCode
    GROUP BY p.Description
),
CalculoAcumulado AS (
    SELECT 
        Description,
        Ingresos_producto,
        Porcentaje_Individual,
        SUM(Porcentaje_Individual) OVER (ORDER BY Ingresos_producto DESC) AS Porcentaje_Acumulado
    FROM VentasPorProducto
)
SELECT 
    Description,
    ROUND(Ingresos_producto, 2) AS Ingresos_producto,
    ROUND(Porcentaje_Individual, 2) AS Porcentaje_Individual,
    ROUND(Porcentaje_Acumulado, 2) AS Porcentaje_Acumulado
FROM CalculoAcumulado
WHERE Porcentaje_Acumulado - Porcentaje_Individual > 5
ORDER BY Ingresos_producto DESC;

-- ==================================================================================================
-- Estacionalidad Mensual
-- Evolucion del negocio mes a mes 
-- ==================================================================================================
SELECT 
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS Mes,
    COUNT(DISTINCT InvoiceNo) AS Numero_Pedidos,
    ROUND(SUM(TotalAmount), 2) AS Facturacion_Mensual
FROM fact_ventas
GROUP BY Mes
ORDER BY Mes;

-- ==================================================================================================
-- Segmentacion estrategica de clientes (MODELO RFM)
-- Clasificacion de clientes segun cuanto gastan y frecuencia de compra 
-- ==================================================================================================
SELECT 
    CustomerID,
    NTILE(5) OVER (ORDER BY MAX(InvoiceDate) DESC) AS R_Score, -- Recencia
    NTILE(5) OVER (ORDER BY COUNT(InvoiceNo) DESC) AS F_Score,   -- Frecuencia
    NTILE(5) OVER (ORDER BY SUM(TotalAmount) DESC) AS M_Score    -- Valor Monetario
FROM fact_ventas
GROUP BY CustomerID;

-- ==================================================================================================
-- Crecimiento mes a mes
-- Venta del mes y crecimiento respecto al mes anterior 
-- ==================================================================================================
SELECT 
    Mes,
    Ventas_Mes,
    LAG(Ventas_Mes) OVER (ORDER BY Mes) AS Ventas_Mes_Anterior,
    ROUND(((Ventas_Mes - LAG(Ventas_Mes) OVER (ORDER BY Mes)) / LAG(Ventas_Mes) OVER (ORDER BY Mes)) * 100, 2) AS Crecimiento_MoM
FROM (
    SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS Mes, SUM(TotalAmount) AS Ventas_Mes
    FROM fact_ventas
    GROUP BY Mes
) AS Totales;

-- ==================================================================================================
CREATE OR REPLACE VIEW v_analisis_comercial AS
SELECT 
    f.InvoiceNo,
    f.InvoiceDate,
    f.UnitPrice,
    f.TotalAmount,
    c.Country,
    p.Description,
    f.CustomerID
FROM fact_ventas f
LEFT JOIN dim_clientes c ON f.CustomerID = c.CustomerID
LEFT JOIN dim_productos p ON f.StockCode = p.StockCode;

