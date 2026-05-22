# Plan de Migración de Datos

> **Versión:** 1.0 | **Responsable:** Especialista de Datos

## Resumen
Migración de datos NAV 2016 → BC SaaS usando PowerShell + BC API v2.0.

## Capas de Migración
| Capa | Contenido | Herramienta | Estimado |
|------|-----------|-------------|---------|
| 1 - Config | Series num., grupos registro, dimensiones | RapidStart | [COMPLETAR]h |
| 2 - Maestros | Clientes, Proveedores, Artículos, Cuentas | PowerShell + API | [COMPLETAR]h |
| 3 - Saldos | Saldos CxC, CxP, Inventario a fecha corte | PowerShell + API | [COMPLETAR]h |
| 4 - Histórico | Movimientos históricos (según decisión negocio) | PowerShell + paginación | [COMPLETAR]h |

## Cronograma de Simulacros
| Simulacro | Entorno | Fecha | Objetivo |
|-----------|---------|-------|---------|
| #1 | QA | [COMPLETAR] | Validar scripts, identificar errores |
| #2 | UAT | [COMPLETAR] | Validar con usuarios clave |
| Dress Rehearsal | Copia PROD | [COMPLETAR] | Medir tiempos reales |
| Cutover real | PROD | [COMPLETAR] | Go-Live |

## Criterio GO/NO-GO
- ✅ Reconciliación contable: diferencia = 0
- ✅ Saldos CxC/CxP cuadrados
- ✅ Sign-off de usuario de Finanzas
- ✅ Migración completada en ventana planificada

**Referencia:** [BC Data Migration](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/administration/migrate-data)
