# Reglas de Limpieza de Datos

> **Versión:** 1.0 | **Responsable:** Especialista de Datos

## Propósito
Definir las reglas de limpieza a aplicar sobre los datos de NAV 2016 ANTES de la migración a BC SaaS para asegurar calidad e integridad.

## Reglas por Entidad

### Clientes (Customer)
| # | Problema | Query de detección | Acción correctiva |
|---|---------|-------------------|------------------|
| C01 | Clientes duplicados (mismo NIF) | `SELECT "VAT Registration No.", COUNT(*) FROM Customer GROUP BY "VAT Registration No." HAVING COUNT(*) > 1` | Fusionar o marcar como obsoleto |
| C02 | Clientes sin nombre | `SELECT * FROM Customer WHERE Name = ''` | Completar o eliminar |
| C03 | Clientes bloqueados sin saldo | [COMPLETAR] | Evaluar si migrar o archivar |
| C04 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |

### Proveedores (Vendor)
| # | Problema | Query de detección | Acción correctiva |
|---|---------|-------------------|------------------|
| V01 | Proveedores duplicados | [COMPLETAR] | [COMPLETAR] |
| V02 | Sin datos bancarios (si aplica pagos electrónicos) | [COMPLETAR] | Completar antes de migración |

### Artículos (Item)
| # | Problema | Query de detección | Acción correctiva |
|---|---------|-------------------|------------------|
| I01 | Artículos con stock negativo | `SELECT * FROM "Item Ledger Entry" WHERE Quantity < 0` | Ajustar inventario antes de corte |
| I02 | Artículos bloqueados sin stock | [COMPLETAR] | No migrar o migrar sin stock |
| I03 | Coste unitario = 0 | [COMPLETAR] | Revisar y corregir |

### Contabilidad
| # | Problema | Query de detección | Acción correctiva |
|---|---------|-------------------|------------------|
| G01 | Asientos sin cuadrar | `SELECT * FROM "G/L Entry" GROUP BY "Transaction No." HAVING SUM(Amount) <> 0` | Corregir antes de migración |
| G02 | Cuentas sin tipo asignado | [COMPLETAR] | Completar |

## Proceso de Limpieza
1. Ejecutar queries de detección → exportar a Excel
2. Revisar con usuario clave del módulo correspondiente
3. Aplicar correcciones en NAV 2016
4. Re-ejecutar queries → confirmar 0 registros problemáticos
5. Documentar resolución de cada ítem

**Referencia:** [Data Quality for Migration](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/administration/migrate-data)
