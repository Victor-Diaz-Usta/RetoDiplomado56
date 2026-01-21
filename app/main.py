import pyodbc
import pandas as pd
import time
import os

# Credenciales
DB_HOST = os.getenv('DB_HOST', 'db')
DB_USER = os.getenv('DB_USER', 'sa')
DB_PASS = os.getenv('DB_PASS', 'TuPasswordFuerte123!')
DB_NAME = 'master'  # 🔹 nueva base

def get_connection():
    conn_str = (
        f"DRIVER={{ODBC Driver 17 for SQL Server}};"
        f"SERVER={DB_HOST};"
        f"DATABASE={DB_NAME};"
        f"UID={DB_USER};"
        f"PWD={DB_PASS};"
        "TrustServerCertificate=yes;"
    )
    return pyodbc.connect(conn_str, autocommit=True)

def run_ingestion():
    print("--- 🚀 Iniciando Proceso ETL ---")
    
    # 1. Leer el CSV
    try:
        print("📂 Leyendo archivo CSV...")
        df = pd.read_csv('raw_sales_dump.csv')  # 🔹 nueva ruta
        print(f"✅ CSV cargado. Filas encontradas: {len(df)}")
    except Exception as e:
        print(f"❌ Error leyendo el CSV: {e}")
        return

    # 2. Conectar a BD
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor()
        print("✅ Conectado a SQL Server")

        # 3. Crear tabla RAW
        print("🛠  Creando tabla 'raw_sales'...")
        cursor.execute("IF OBJECT_ID('raw_sales', 'U') IS NOT NULL DROP TABLE raw_sales")
        cursor.execute("""
            CREATE TABLE raw_sales (
                Transaccion_ID   INT,
                Cliente_Nombre   NVARCHAR(150),
                Cliente_Email    NVARCHAR(150),
                Producto         NVARCHAR(150),
                Categoria        NVARCHAR(100),
                Sucursal         NVARCHAR(100),
                Ciudad_Sucursal  NVARCHAR(100),
                Fecha_Venta      DATE,
                Cantidad         INT,
                Precio_Unitario  DECIMAL(12,2)
            )
        """)
        
        # 4. Insertar datos
        print("📥 Insertando datos en SQL Server...")
        for index, row in df.iterrows():
            cursor.execute("""
                INSERT INTO raw_sales (
                    Transaccion_ID,
                    Cliente_Nombre,
                    Cliente_Email,
                    Producto,
                    Categoria,
                    Sucursal,
                    Ciudad_Sucursal,
                    Fecha_Venta,
                    Cantidad,
                    Precio_Unitario
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, 
            row.Transaccion_ID,
            row.Cliente_Nombre,
            row.Cliente_Email,
            row.Producto,
            row.Categoria,
            row.Sucursal,
            row.Ciudad_Sucursal,
            row.Fecha_Venta,
            row.Cantidad,
            row.Precio_Unitario
            )
        
        print(f"✨ ¡Éxito! Se insertaron {len(df)} registros.")

    except Exception as e:
        print(f"❌ Error en la base de datos: {e}")
    finally:
        if conn: conn.close()

if __name__ == "__main__":
    # Esperamos unos segundos extra para asegurar que SQL Server esté listo
    time.sleep(5)
    run_ingestion()