# Reporte Técnico - Reto SQL Architect & Tuner Protocol
- **Nombre:** Víctor Hugo Díaz  
- **Fecha:** 21 enero de 2026  
- **Repositorio:** https://github.com/Victor-Diaz-Usta/RetoDiplomado56.git 

## 1. Diagrama Entidad–Relación (DER)
Diagrama Entidad–Relación (DER) del modelo normalizado (3NF).  
A partir del archivo plano **RAW_SALES** (CSV) se diseñó un esquema relacional normalizado para eliminar redundancias y asegurar consistencia. El modelo separa los datos maestros en tablas independientes (**Clientes**, **Productos** y **Sucursales**) y concentra los eventos transaccionales en **Ventas**, que actúa como tabla de hechos. 

<img width="1266" height="742" alt="Diagrama" src="https://github.com/user-attachments/assets/b8447f37-ea6a-4b71-aec2-8c080d4199d3" />



## 2. Evidencia de Performance (Logical Reads)
**Configuración usada:** `SET STATISTICS IO ON` y `SET STATISTICS TIME ON`. :contentReference[oaicite:2]{index=2}

### 2.1 CROSS JOIN (caso no relacional)
En esta prueba se ejecuta un **CROSS JOIN** entre **Clientes** y **Productos**, por lo que SQL Server combina todas las filas de una tabla con todas las de la otra (producto cartesiano), sin usar llaves ni condición de unión. En la pestaña **Messages** se observan las métricas de **STATISTICS IO** y **STATISTICS TIME**, donde se refleja el costo de esta operación (lecturas lógicas y tiempo). :contentReference[oaicite:3]{index=3}

<img width="1919" height="984" alt="CROSS JOIN " src="https://github.com/user-attachments/assets/96ed9077-38cb-43f0-bc74-b93b24276510" />



### 2.2 INNER JOIN (caso relacional)
En esta segunda prueba se ejecuta un **INNER JOIN** usando la tabla **Ventas** y sus llaves foráneas para relacionar **Clientes** y **Productos**. A diferencia del **CROSS JOIN**, aquí solo se devuelven registros con relación válida, lo que reduce el trabajo del motor. En la pestaña **Messages** se evidencian las métricas de **STATISTICS IO** y **STATISTICS TIME**, mostrando menor costo (lecturas lógicas/tiempo) frente a la prueba anterior. :contentReference[oaicite:4]{index=4}

<img width="1919" height="972" alt="INNER JOIN " src="https://github.com/user-attachments/assets/91054b0f-fd7b-44ef-81fe-576d199dcde0" />



## Conclusión
En este ejercicio se confirma que un modelo normalizado con relaciones **PK–FK** no solo mejora el orden y la consistencia de los datos, sino también el rendimiento al consultar. El **INNER JOIN** se apoya en esas relaciones para evitar lecturas y combinaciones innecesarias, lo que se evidencia en menos **logical reads** frente al **CROSS JOIN**. Por eso, en un escenario real, la recomendación es usar **INNER JOIN** y reservar **CROSS JOIN** únicamente para casos donde se necesite explícitamente un producto cartesiano. :contentReference[oaicite:5]{index=5}
