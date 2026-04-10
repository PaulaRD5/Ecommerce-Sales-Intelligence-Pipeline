# E-commerce Sales Intelligence: End-to-End BI Pipeline

Este proyecto presenta una solución integral de Business Intelligence para transformar datos transaccionales brutos en una herramienta 
de decisión estratégica. El pipeline abarca desde la limpieza de datos masivos (+500k registros) con Python, el modelado robusto en SQL,
hasta la visualización ejecutiva en Power BI.

---

## Stack Tecnológico
- Lenguajes: Python (Pandas, SQLAlchemy), SQL (MySQL/MariaDB).

- Herramientas BI: Power BI Desktop (DAX).

- Modelado: Arquitectura de Esquema en Estrella (Star Schema).

---
## Fases del Proyecto

1. ETL y Limpieza (Python)
  Se procesó el dataset original para garantizar la integridad de los datos:
  - Tratamiento de valores nulos en CustomerID.
  - Limpieza de registros con cantidades negativas (devoluciones).
  - Normalización de tipos de datos y exportación automatizada a MySQL.
 `- Archivo: **ETL_Data_Cleaning_Ecommerce.ipynb**

2. Modelado de Datos (SQL)
  Se transformó una tabla plana denormalizada en un modelo eficiente para analítica:
  - Creación de tablas de Dimensiones (dim_clientes, dim_productos) y tabla de Hechos (fact_ventas).
  - Implementación de una Vista Maestra para optimizar la carga en el Dashboard.
  - Archivo: **Data_Modeling_Star_Schema.sql**

3. Análisis Avanzado (Business Insights)
  Desarrollo de consultas complejas para extraer valor de negocio:
  - Segmentación RFM: Clasificación de clientes según Recencia, Frecuencia y Valor Monetario para estrategias de fidelización.
  - Crecimiento MoM: Cálculo del crecimiento mes a mes mediante funciones de ventana (LAG).
  - Archivo: **Business_Insights_&_Advanced_Analytics.sql**

4. Visualización Interactiva (Power BI)
  Diseño de un dashboard ejecutivo centrado en KPIs críticos:
  -  Revenue Total: 10.10M.
  - Ticket Medio (AOV): Análisis de rentabilidad por pedido.
  - Distribución Geográfica: Identificación de mercados clave.
  - Archivo: **Executive_Sales_Intelligence_Dashboard.pbix**

5. Dashboard Final
---
## Conclusiones de Negocio 
1. Dominio de Mercado: El mercado del Reino Unido concentra el mayor volumen de ventas, 
   sugiriendo una oportunidad de expansión dirigida en Europa Continental.

2. Estacionalidad: Se identifica un pico crítico de ventas en el cuarto trimestre, 
   fundamental para la planificación de inventarios.

3. Fidelización: El modelo RFM permite identificar un segmento de clientes "Champions" 
   que generan el 20% de los ingresos recurrentes.

---
## Autor

Paula Ramos Delgado 

[LinkedIn](www.linkedin.com/in/paula-ramos-delgado-1bb425163)

[Github](https://github.com/PaulaRD5)

[Email](ramosdelgado@hotmail.es)
