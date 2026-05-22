# Estrategia de Migración de Datos

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Responsable:** Especialista de Migración de Datos

---

## 1. Propósito

Definir la estrategia, enfoque y principios para migrar los datos de NAV 2016 a Business Central SaaS, garantizando integridad, completitud y rendimiento durante el cutover.

**Referencia:** [BC Data Migration](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/administration/migrate-data)

---

## 2. Enfoque de Migración

### Método seleccionado: Migración personalizada mediante PowerShell + BC API

| Opción evaluada | Ventajas | Desventajas | Decisión |
|----------------|---------|-------------|---------|
| **Cloud Migration Tool (nativa BC)** | Automatizada, soportada por Microsoft | Solo para BC on-premise previo; limitada para NAV2016 con personalizaciones | ❌ No seleccionada |
| **RapidStart / Configuration Packages** | Nativo de BC, sin desarrollo | Limitada a datos maestros; no maneja histórico complejo | ⚠️ Usar para datos simples |
| **PowerShell + BC API (seleccionada)** | Control total, validaciones custom, soporte para personalizaciones | Requiere desarrollo de scripts | ✅ Seleccionada |
| **SSMS Direct SQL a BC** | Rápida para grandes volúmenes | No permitida en SaaS | ❌ No aplicable |

---

## 3. Capas de Migración

### Capa 1: Datos de Configuración (Config)
Parámetros del sistema que no son transaccionales:
- Configuración general de empresa
- Series de números (No. Series)
- Grupos de registro (Posting Groups)
- Dimensiones y valores de dimensiones
- Unidades de medida, divisas, países

**Herramienta:** RapidStart / Configuration Packages
**Tiempo estimado:** [COMPLETAR] horas

### Capa 2: Datos Maestros (Masters)
Registros de referencia sin transacciones:
- Clientes (Customer)
- Proveedores (Vendor)
- Artículos (Item)
- Plan de Cuentas (Chart of Accounts)
- Activos Fijos
- Recursos

**Herramienta:** PowerShell + BC API v2.0
**Tiempo estimado:** [COMPLETAR] horas

### Capa 3: Saldos Abiertos (Open Balances)
Saldos pendientes a fecha de corte:
- Saldos pendientes Cuentas por Cobrar (facturas sin cobrar)
- Saldos pendientes Cuentas por Pagar (facturas sin pagar)
- Inventario actual a fecha de corte (valorado)
- Saldos contables por cuenta a fecha de corte

**Herramienta:** PowerShell + BC API
**Tiempo estimado:** [COMPLETAR] horas

### Capa 4: Datos Históricos (Historical)
Historial transaccional anterior a la fecha de corte:
- Movimientos contables históricos (G/L Entries)
- Historial de documentos (facturas, albaranes registrados)
- Movimientos de inventario históricos

**Decisión de negocio:** ¿Migrar [COMPLETAR] años de historial?
**Herramienta:** PowerShell con paginación + pre-migración anticipada
**Tiempo estimado:** [COMPLETAR] horas (pre-migración) + [COMPLETAR] horas (cutover)

---

## 4. Secuencia de Migración

```
Semana -8:  Análisis de calidad de datos (Data Profiling)
Semana -6:  Data Cleansing en NAV 2016
Semana -4:  Simulacro de migración #1 (entorno QA)
            → Validación de resultados
            → Corrección de scripts
Semana -2:  Simulacro de migración #2 (entorno UAT)
            → Validación con usuarios clave
            → Ajuste fino de scripts
Semana -1:  Dress Rehearsal (simulacro completo en copia de producción)
            → Medir tiempos reales de migración
            → Validar ventana de cutover

CUTOVER:
  T-0:      Freeze de transacciones en NAV 2016
  T+1h:     Inicio migración Capa 1 (Config)
  T+2h:     Inicio migración Capa 2 (Masters)
  T+4h:     Inicio migración Capa 3 (Saldos)
  T+Xh:     Validación automática de datos
  T+Xh:     Validación manual por usuarios clave (Finanzas)
  T+Xh:     ✅ GO/NO-GO para abrir sistema a usuarios
```

---

## 5. Reglas de Validación Post-Migración

| Validación | Tipo | Criterio de éxito |
|-----------|------|------------------|
| Recuento de registros maestros | Automática | 100% de registros migrados (cero diferencia) |
| Suma de saldos CxC | Automática | Diferencia = 0 con NAV 2016 |
| Suma de saldos CxP | Automática | Diferencia = 0 con NAV 2016 |
| Valoración total de inventario | Automática | Diferencia < [COMPLETAR]% |
| Balance general contable | Manual (Finanzas) | Activo = Pasivo + Patrimonio |
| Verificación de documentos abiertos | Manual (usuarios) | Pedidos pendientes presentes y correctos |
| Datos de personalizaciones | Manual (técnico) | Campos custom migrados correctamente |

---

## 6. Criterio GO/NO-GO

| Criterio | GO | NO-GO (acción) |
|---------|-----|----------------|
| Migración completada en tiempo planificado | ✅ | Ejecutar plan de rollback |
| Reconciliación contable OK | ✅ | NO-GO: no abrir sistema |
| Saldos CxC/CxP cuadrados | ✅ | NO-GO: no abrir sistema |
| 0 errores críticos en migración | ✅ | Evaluar según impacto |
| Sign-off de usuario Finanzas | ✅ | NO-GO si Finanzas no aprueba |

---

*Referencia: [RapidStart Migration](https://learn.microsoft.com/es-es/dynamics365/business-central/admin-migrate-customer-data)*
