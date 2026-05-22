# Análisis de Volumen de Datos NAV 2016

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Responsable:** [COMPLETAR]

---

## Propósito

Cuantificar el volumen de datos existente en NAV 2016 para estimar tiempos de migración, identificar tablas de alto volumen que requieran estrategias especiales y planificar la ventana de cutover.

---

## Query SQL para Análisis de Tamaño

```sql
-- Tamaño de la base de datos NAV 2016 por tabla
SELECT 
    t.name                           AS NombreTabla,
    p.rows                           AS NumeroFilas,
    CAST(ROUND(
        (SUM(a.total_pages) * 8) / 1024.0, 2
    ) AS DECIMAL(18,2))              AS TamanioMB,
    CAST(ROUND(
        (SUM(a.used_pages) * 8) / 1024.0, 2
    ) AS DECIMAL(18,2))              AS UsadoMB,
    CAST(ROUND(
        ((SUM(a.total_pages) - SUM(a.used_pages)) * 8) / 1024.0, 2
    ) AS DECIMAL(18,2))              AS LibreMB
FROM 
    sys.tables t
    INNER JOIN sys.indexes i ON t.object_id = i.object_id
    INNER JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
    INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
WHERE 
    t.name NOT LIKE 'dt%'
    AND i.object_id > 255
    AND i.index_id <= 1
GROUP BY 
    t.name, p.rows
ORDER BY 
    TamanioMB DESC;

-- Total de la base de datos
SELECT 
    database_name = DB_NAME(),
    log_size_mb = CAST(SUM(size) * 8.0 / 1024 AS DECIMAL(18,2)),
    space_used_mb = CAST(SUM(FILEPROPERTY(name, 'SpaceUsed')) * 8.0 / 1024 AS DECIMAL(18,2))
FROM sys.database_files;
```

---

## Resumen General de la Base de Datos

| Métrica | Valor |
|---------|-------|
| **Tamaño total de la BD** | [COMPLETAR] GB |
| **Espacio utilizado** | [COMPLETAR] GB |
| **Número total de tablas** | [COMPLETAR] |
| **Número de tablas con > 100k registros** | [COMPLETAR] |
| **Año de registro más antiguo** | [COMPLETAR] |
| **Registros totales estimados** | [COMPLETAR] millones |

---

## Top 20 Tablas por Volumen

| Rank | Tabla NAV | Nombre en BC | Filas | Tamaño (MB) | En alcance migración | Estrategia |
|------|-----------|-------------|-------|-------------|---------------------|-----------|
| 1 | G/L Entry (17) | G/L Entry | [COMPLETAR] | [COMPLETAR] | [COMPLETAR - Sí/No] | [COMPLETAR] |
| 2 | Value Entry (5802) | Value Entry | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| 3 | Item Ledger Entry (32) | Item Ledger Entry | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| 4 | Cust. Ledger Entry (21) | Cust. Ledger Entry | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| 5 | Vendor Ledger Entry (25) | Vendor Ledger Entry | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| 6 | Sales Invoice Header (112) | Sales Invoice Header | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| 7 | Sales Invoice Line (113) | Sales Invoice Line | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| 8 | Purch. Inv. Header (122) | Purch. Inv. Header | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| 9 | Purch. Inv. Line (123) | Purch. Inv. Line | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| 10 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| 11-20 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |

---

## Análisis por Módulo

### Finanzas (Finance)

| Tabla | Filas | MB | Años de historia | Migrar |
|-------|-------|----|-----------------|--------|
| G/L Entry | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| G/L Register | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| Bank Account Ledger Entry | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |

### Ventas (Sales)

| Tabla | Filas | MB | Años de historia | Migrar |
|-------|-------|----|-----------------|--------|
| Sales Invoice Header | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| Sales Invoice Line | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| Sales Cr. Memo Header | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| Cust. Ledger Entry | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |

### Compras (Purchasing)

| Tabla | Filas | MB | Años de historia | Migrar |
|-------|-------|----|-----------------|--------|
| Purch. Inv. Header | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| Purch. Inv. Line | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| Vendor Ledger Entry | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |

### Inventario (Inventory)

| Tabla | Filas | MB | Años de historia | Migrar |
|-------|-------|----|-----------------|--------|
| Item Ledger Entry | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| Value Entry | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |

---

## Estrategia de Migración por Volumen

| Categoría | Criterio | Estrategia | Herramienta |
|-----------|---------|-----------|-------------|
| **Tablas maestras** | < 50,000 registros | Migración completa en un batch | PowerShell + BC API |
| **Tablas transaccionales altas** | > 1M registros | Migración por lotes con fechas de corte | PowerShell con paginación |
| **Datos históricos** | > 5 años antigüedad | Evaluación: migrar resumidos o solo saldos | Decisión por negocio |
| **Tablas de movimientos contables** | Movimientos contables | Solo saldos a fecha de corte o histórico completo | Decisión por negocio |

---

## Estimación de Tiempos de Migración

| Escenario | Volumen total | Tiempo estimado | Ventana de cutover |
|-----------|--------------|----------------|-------------------|
| Solo datos maestros + saldos | [COMPLETAR] GB | [COMPLETAR] horas | [COMPLETAR] horas |
| Maestros + saldos + 3 años transaccional | [COMPLETAR] GB | [COMPLETAR] horas | [COMPLETAR] horas |
| Migración completa histórico | [COMPLETAR] GB | [COMPLETAR] horas | Requiere pre-migración |

> ⚠️ **Recomendación:** Pre-migrar datos históricos (> fecha de corte) antes de la ventana de cutover para reducir el tiempo de inactividad al mínimo.

---

*Referencia: [Business Central Data Migration](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/administration/migrate-data)*
