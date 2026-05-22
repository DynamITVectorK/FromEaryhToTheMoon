# Mapeo de Tablas NAV 2016 → Business Central

> **Versión:** 1.0 | **Responsable:** Especialista de Datos

## Datos Maestros

| Tabla NAV 2016 | ID | Tabla BC | API Endpoint | Campos excluidos | Notas |
|---------------|-----|---------|-------------|-----------------|-------|
| Customer | 18 | Customer | /customers | [COMPLETAR] | Mapear campos custom |
| Vendor | 23 | Vendor | /vendors | [COMPLETAR] | [COMPLETAR] |
| Item | 27 | Item | /items | [COMPLETAR] | Verificar unidades de medida |
| G/L Account | 15 | G/L Account | /accounts | [COMPLETAR] | [COMPLETAR] |
| Dimension | 348 | Dimension | /dimensions | [COMPLETAR] | [COMPLETAR] |
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |

## Saldos Abiertos

| Tabla NAV 2016 | Tabla BC | Método de carga | Fecha corte |
|---------------|---------|----------------|------------|
| Cust. Ledger Entry (saldos abiertos) | Customer Ledger Entry | Journal import via API | [COMPLETAR] |
| Vendor Ledger Entry (saldos abiertos) | Vendor Ledger Entry | Journal import via API | [COMPLETAR] |
| Item Ledger Entry (inventario actual) | Item Journal | Item Journal import | [COMPLETAR] |

## Campos Custom a Migrar

| Campo NAV 2016 | Tabla | Campo BC (extensión) | Transformación requerida |
|---------------|-------|---------------------|------------------------|
| [COMPLETAR] | Customer | [PREFIX] [COMPLETAR] | [COMPLETAR o Ninguna] |
| [COMPLETAR] | Item | [PREFIX] [COMPLETAR] | [COMPLETAR] |

## Transformaciones de Datos

| Campo | Tipo NAV 2016 | Tipo BC | Transformación |
|-------|-------------|---------|---------------|
| Código país | Code[10] | Code[10] (ISO) | Mapear a ISO 3166-1 alpha-2 |
| Moneda | Code[3] | Code[10] | Verificar códigos ISO 4217 |
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |

**Referencia:** [BC API v2.0 Reference](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/api-reference/v2.0/)
