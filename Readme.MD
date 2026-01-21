# 🏛️ Reto SQL Architect & Tuner Protocol

**Diplomado en Gestión de Datos 2026 | Módulos: Diseño Relacional y SQL Performance**

---

## 🛑 Contexto Crítico del Negocio
Eres el nuevo **Lead Data Engineer** de **LegacyRetail S.A.**, una empresa que está a punto de colapsar técnicamente.

### El Problema
Durante 10 años, la empresa registró sus ventas en una sola "hoja de cálculo infinita" (Flat File). Recientemente, intentaron migrar esto a SQL Server tal cual (una sola tabla gigante), lo que causó dos desastres:
1.  **Inconsistencia de Datos:** El cliente "Juan Pérez" está escrito de 5 formas distintas y su dirección no coincide.
2.  **Caída del Servidor:** El desarrollador junior intentó hacer un reporte de combinaciones de productos usando un `CROSS JOIN`, lo que generó un bucle que consumió el 100% de la CPU y tumbó el servicio de facturación.

### 🎯 Tu Misión
Tienes 2 objetivos mandatorios para salvar la operación:

#### Misión A: Ingeniería Inversa (Normalización 3NF)
Debes tomar el archivo sucio (`raw_sales_dump.csv`), analizar sus patrones y diseñar un **Esquema Relacional Normalizado** (Tablas separadas con relaciones lógicas) que elimine la redundancia.

#### Misión B: Auditoría de Performance (Tuning)
Debes replicar el error del desarrollador junior en un entorno controlado y demostrar con **métricas de ingeniería** (Lecturas Lógicas y Tiempo de CPU) por qué su consulta mató al servidor, proponiendo la solución óptima (`INNER JOIN`).

---

## 🛠️ Instrucciones de Entrega

El repositorio ya contiene las carpetas necesarias. Debes completar y subir:

### 1. Diseño (`/02_sql/1_ddl_diseno/`)
* **Archivo:** `solution_schema.sql`
* **Requisito:** Código DDL para crear tablas `Clientes`, `Productos`, `Sucursales` y `Ventas`.
* **Condición:** Todas las tablas deben tener `PRIMARY KEY`. Las relaciones deben tener `FOREIGN KEY`. Usa tipos de datos eficientes (`INT`, `VARCHAR`, `DECIMAL`).

### 2. Performance (`/02_sql/2_performance_lab/`)
* **Archivo:** `solution_tuning.sql`
* **Requisito:** Script que ejecute la comparativa entre Cross Join e Inner Join activando `STATISTICS IO`.

### 3. Reporte Final (`/03_docs/entregables/`)
* **Archivo:** `Reporte_Tecnico.pdf`
* **Contenido:**
    * Diagrama Entidad-Relación (DER).
    * Captura de pantalla de los mensajes de SQL Server mostrando la reducción de *Logical Reads*.

---

## 📚 Recursos de Apoyo (¡Léelos!)
En la carpeta `03_docs/teoria_y_guias/` encontrarás:
* `GUIA_NORMALIZACION_3NF.md`: Tutorial paso a paso para pasar de Excel a SQL.
* `GUIA_PERFORMANCE_TUNING.md`: Cómo interpretar los planes de ejecución y lecturas.

¡Manos a la obra, Ingeniero!
