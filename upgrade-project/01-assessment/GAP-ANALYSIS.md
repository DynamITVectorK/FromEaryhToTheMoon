# Análisis de Brechas Funcionales (GAP Analysis)

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Responsable:** [COMPLETAR]

---

## Propósito

Identificar diferencias funcionales entre las capacidades actuales de NAV 2016 (incluyendo personalizaciones) y las capacidades nativas de Business Central SaaS. Para cada brecha se define la estrategia de resolución.

---

## Leyenda de Estado

| Icono | Estado | Descripción |
|-------|--------|-------------|
| ✅ | Estándar BC | La funcionalidad existe de forma nativa en BC SaaS sin necesidad de desarrollo |
| 🔧 | Configuración | Requiere configuración específica en BC pero no desarrollo |
| 💻 | Desarrollo AL | Requiere desarrollo de extensión AL personalizada |
| 🔄 | Rediseño de proceso | El proceso debe rediseñarse; BC ofrece una alternativa diferente |
| ❌ | Gap sin solución inmediata | No hay solución disponible; requiere decisión del negocio |
| 📦 | App AppSource | Disponible como aplicación en Microsoft AppSource |

---

## Módulo: Finanzas (Finance & Accounting)

| # | Funcionalidad | Estado NAV 2016 | Estado BC SaaS | Estrategia | Esfuerzo | Prioridad |
|---|--------------|----------------|----------------|-----------|---------|-----------|
| F01 | Contabilidad general, plan de cuentas | ✅ Estándar | ✅ Estándar BC | Sin cambio | 0h | Alta |
| F02 | Cuentas por pagar y cobrar | ✅ Estándar | ✅ Estándar BC | Sin cambio | 0h | Alta |
| F03 | Activos fijos | ✅ Estándar | ✅ Estándar BC | Sin cambio | 0h | Media |
| F04 | Conciliación bancaria | ✅ Estándar | ✅ Estándar BC (mejorado con Bank Reconciliation AI) | Sin cambio | 0h | Alta |
| F05 | [COMPLETAR - funcionalidad custom Finanzas] | 💻 Personalizado | ❓ Evaluar | 💻 Desarrollo AL | [COMPLETAR]h | Alta |
| F06 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR]h | [COMPLETAR] |
| F07 | Reporting fiscal local ([COMPLETAR - país]) | [COMPLETAR] | 🔧 Localización disponible | Configurar localización | [COMPLETAR]h | Alta |
| F08 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR]h | [COMPLETAR] |

**Resumen Finanzas:** ✅ [COMPLETAR] | 🔧 [COMPLETAR] | 💻 [COMPLETAR] | 🔄 [COMPLETAR] | ❌ [COMPLETAR]

---

## Módulo: Ventas (Sales & Receivables)

| # | Funcionalidad | Estado NAV 2016 | Estado BC SaaS | Estrategia | Esfuerzo | Prioridad |
|---|--------------|----------------|----------------|-----------|---------|-----------|
| V01 | Pedidos de venta, albaranes, facturas | ✅ Estándar | ✅ Estándar BC | Sin cambio | 0h | Alta |
| V02 | Gestión de clientes | ✅ Estándar | ✅ Estándar BC | Sin cambio | 0h | Alta |
| V03 | Precios y descuentos | ✅ Estándar | ✅ Estándar BC (Price List mejorado) | 🔧 Reconfigurar | [COMPLETAR]h | Alta |
| V04 | [COMPLETAR - personalización ventas] | 💻 Personalizado | ❓ | 💻 Desarrollo AL | [COMPLETAR]h | Alta |
| V05 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR]h | [COMPLETAR] |
| V06 | Integración con CRM/Marketplace externo | 🔄 XMLPort/custom | ❓ | 🔄 API REST + Power Automate | [COMPLETAR]h | Media |
| V07 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR]h | [COMPLETAR] |

**Resumen Ventas:** ✅ [COMPLETAR] | 🔧 [COMPLETAR] | 💻 [COMPLETAR] | 🔄 [COMPLETAR] | ❌ [COMPLETAR]

---

## Módulo: Compras (Purchase & Payables)

| # | Funcionalidad | Estado NAV 2016 | Estado BC SaaS | Estrategia | Esfuerzo | Prioridad |
|---|--------------|----------------|----------------|-----------|---------|-----------|
| C01 | Pedidos de compra, recepciones, facturas | ✅ Estándar | ✅ Estándar BC | Sin cambio | 0h | Alta |
| C02 | Gestión de proveedores | ✅ Estándar | ✅ Estándar BC | Sin cambio | 0h | Alta |
| C03 | Flujo de aprobación de pedidos | 💻 Personalizado | 🔧 Approval Workflows nativos BC | 🔄 Reconfigurar con Approval Workflows | [COMPLETAR]h | Alta |
| C04 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR]h | [COMPLETAR] |
| C05 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR]h | [COMPLETAR] |

**Resumen Compras:** ✅ [COMPLETAR] | 🔧 [COMPLETAR] | 💻 [COMPLETAR] | 🔄 [COMPLETAR] | ❌ [COMPLETAR]

---

## Módulo: Inventario (Inventory Management)

| # | Funcionalidad | Estado NAV 2016 | Estado BC SaaS | Estrategia | Esfuerzo | Prioridad |
|---|--------------|----------------|----------------|-----------|---------|-----------|
| I01 | Gestión de artículos | ✅ Estándar | ✅ Estándar BC | Sin cambio | 0h | Alta |
| I02 | Valoración de inventario (FIFO, Promedio) | ✅ Estándar | ✅ Estándar BC | Sin cambio | 0h | Alta |
| I03 | Trazabilidad de lotes y números de serie | ✅ Estándar | ✅ Estándar BC | Sin cambio | 0h | Alta |
| I04 | [COMPLETAR - personalización inventario] | 💻 Personalizado | ❓ | 💻 Desarrollo AL | [COMPLETAR]h | Media |
| I05 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR]h | [COMPLETAR] |

**Resumen Inventario:** ✅ [COMPLETAR] | 🔧 [COMPLETAR] | 💻 [COMPLETAR] | 🔄 [COMPLETAR] | ❌ [COMPLETAR]

---

## Módulo: Reporting y Business Intelligence

| # | Funcionalidad | Estado NAV 2016 | Estado BC SaaS | Estrategia | Esfuerzo | Prioridad |
|---|--------------|----------------|----------------|-----------|---------|-----------|
| R01 | Reportes estándar RDLC | ✅ Estándar | ✅ Estándar BC | Revisar layouts | [COMPLETAR]h | Media |
| R02 | Reportes custom [COMPLETAR] | 💻 Custom RDLC | 💻 | 💻 Convertir a RDLC/Word BC | [COMPLETAR]h | Alta |
| R03 | Business Intelligence / Dashboards | ❌ No disponible | ✅ Power BI integrado nativamente | 🔄 Implementar Power BI dashboards | [COMPLETAR]h | Media |
| R04 | Account Schedules / Financial Reports | ✅ Estándar | ✅ Estándar BC (Financial Reports) | 🔧 Reconfigurar | [COMPLETAR]h | Alta |

**Resumen Reporting:** ✅ [COMPLETAR] | 🔧 [COMPLETAR] | 💻 [COMPLETAR] | 🔄 [COMPLETAR] | ❌ [COMPLETAR]

---

## Brechas Críticas (Gaps sin Solución Inmediata ❌)

| # | Funcionalidad | Módulo | Impacto | Opciones evaluadas | Decisión requerida |
|---|--------------|--------|---------|-------------------|-------------------|
| GAP-001 | [COMPLETAR - funcionalidad crítica sin alternativa clara] | [COMPLETAR] | Alto | [COMPLETAR] | Decisión del negocio: ¿Cambiar proceso? ¿Desarrollo custom? ¿App ISV? |
| GAP-002 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |

---

## Resumen Ejecutivo del GAP Analysis

| Módulo | ✅ Std | 🔧 Config | 💻 Dev AL | 🔄 Rediseño | ❌ Gap | Horas Dev |
|--------|--------|---------|---------|----------|-------|-----------|
| Finanzas | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR]h |
| Ventas | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR]h |
| Compras | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR]h |
| Inventario | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR]h |
| Reporting | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR]h |
| **TOTAL** | **[COMPLETAR]** | **[COMPLETAR]** | **[COMPLETAR]** | **[COMPLETAR]** | **[COMPLETAR]** | **[COMPLETAR]h** |

---

*Referencia: [Business Central Capabilities](https://learn.microsoft.com/es-es/dynamics365/business-central/)*
