# Catálogo de Integraciones NAV 2016

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Responsable:** [COMPLETAR]

---

## Propósito

Documentar todas las integraciones existentes entre NAV 2016 y sistemas externos. Para cada integración se analiza la compatibilidad con Business Central SaaS y se define la estrategia de migración, considerando que el modelo SaaS elimina el acceso directo a la base de datos, NAS y COM automation.

**Restricciones clave en BC SaaS:**
- ❌ No se permite acceso directo a la base de datos SQL
- ❌ No se permite NAS (NAV Application Server)
- ❌ No se permiten COM/DotNet Add-ins en runtime
- ❌ No se permiten Web Services basados en SOAP (reemplazar por OData/API)
- ✅ Disponible: API Pages (OData v4), Business Central API v2.0
- ✅ Disponible: Azure Service Bus, Power Automate, Logic Apps, Azure Functions
- ✅ Disponible: Webhooks nativos de BC

**Referencia:** [Business Central Integration Overview](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-integration-overview)

---

## Plantilla de Integración

Para cada integración se documenta:

| Campo | Descripción |
|-------|-------------|
| **ID** | Identificador único (INT-XXX) |
| **Nombre** | Nombre descriptivo de la integración |
| **Sistema externo** | Sistema o aplicación externa |
| **Dirección** | Entrada (→BC), Salida (BC→), Bidireccional (↔) |
| **Protocolo actual** | Tecnología usada en NAV 2016 (SOAP, archivo, BD, etc.) |
| **Frecuencia** | Real-time, Batch diario, Bajo demanda, etc. |
| **Datos intercambiados** | Qué información fluye entre sistemas |
| **Restricciones SaaS** | ¿Es compatible directamente con SaaS? |
| **Estrategia BC SaaS** | Cómo se implementará en BC SaaS |
| **Esfuerzo estimado** | Horas/días de desarrollo |
| **Prioridad** | Alta/Media/Baja |

---

## INT-001

| Campo | Detalle |
|-------|---------|
| **ID** | INT-001 |
| **Nombre** | [COMPLETAR - nombre de la integración] |
| **Sistema externo** | [COMPLETAR - nombre del sistema externo] |
| **Dirección** | [COMPLETAR - Entrada / Salida / Bidireccional] |
| **Protocolo actual** | [COMPLETAR - ej: Web Service SOAP, XML sobre carpeta compartida, acceso directo BD] |
| **Frecuencia** | [COMPLETAR - Real-time / Batch diario / Bajo demanda] |
| **Datos intercambiados** | [COMPLETAR - ej: Pedidos de venta, albaranes, facturas] |
| **Volumen estimado** | [COMPLETAR - ej: 500 registros/día] |
| **Restricciones SaaS** | [COMPLETAR - Sí: describe restricción / No: compatible directamente] |
| **Estrategia BC SaaS** | [COMPLETAR - ej: API Page + Power Automate, Azure Service Bus, BC API v2.0] |
| **Esfuerzo estimado** | [COMPLETAR] horas |
| **Prioridad** | Alta |
| **Propietario técnico** | [COMPLETAR] |
| **Notas** | [COMPLETAR] |

---

## INT-002

| Campo | Detalle |
|-------|---------|
| **ID** | INT-002 |
| **Nombre** | [COMPLETAR] |
| **Sistema externo** | [COMPLETAR] |
| **Dirección** | [COMPLETAR] |
| **Protocolo actual** | [COMPLETAR] |
| **Frecuencia** | [COMPLETAR] |
| **Datos intercambiados** | [COMPLETAR] |
| **Volumen estimado** | [COMPLETAR] |
| **Restricciones SaaS** | [COMPLETAR] |
| **Estrategia BC SaaS** | [COMPLETAR] |
| **Esfuerzo estimado** | [COMPLETAR] horas |
| **Prioridad** | [COMPLETAR] |
| **Propietario técnico** | [COMPLETAR] |
| **Notas** | [COMPLETAR] |

---

## INT-003

| Campo | Detalle |
|-------|---------|
| **ID** | INT-003 |
| **Nombre** | [COMPLETAR] |
| **Sistema externo** | [COMPLETAR] |
| **Dirección** | [COMPLETAR] |
| **Protocolo actual** | [COMPLETAR] |
| **Frecuencia** | [COMPLETAR] |
| **Datos intercambiados** | [COMPLETAR] |
| **Volumen estimado** | [COMPLETAR] |
| **Restricciones SaaS** | [COMPLETAR] |
| **Estrategia BC SaaS** | [COMPLETAR] |
| **Esfuerzo estimado** | [COMPLETAR] horas |
| **Prioridad** | [COMPLETAR] |
| **Propietario técnico** | [COMPLETAR] |
| **Notas** | [COMPLETAR] |

---

## INT-004

| Campo | Detalle |
|-------|---------|
| **ID** | INT-004 |
| **Nombre** | Integración con sistema de nóminas |
| **Sistema externo** | [COMPLETAR - nombre sistema nóminas] |
| **Dirección** | Salida (BC→Nóminas) |
| **Protocolo actual** | [COMPLETAR - ej: Exportación de archivo CSV/TXT generado desde reporte NAV] |
| **Frecuencia** | Mensual (cierre de nómina) |
| **Datos intercambiados** | Asientos contables de nómina, centros de coste, dimensiones |
| **Volumen estimado** | [COMPLETAR] registros/mes |
| **Restricciones SaaS** | No aplica restricciones críticas; el reporte puede generarse desde BC |
| **Estrategia BC SaaS** | Report Layout (RDLC/Excel) + descarga manual o Power Automate para envío automático |
| **Esfuerzo estimado** | [COMPLETAR] horas |
| **Prioridad** | Alta |
| **Propietario técnico** | [COMPLETAR] |
| **Notas** | Coordinar con proveedor de nóminas para validar formato de archivo |

---

## INT-005

| Campo | Detalle |
|-------|---------|
| **ID** | INT-005 |
| **Nombre** | [COMPLETAR] |
| **Sistema externo** | [COMPLETAR] |
| **Dirección** | [COMPLETAR] |
| **Protocolo actual** | [COMPLETAR] |
| **Frecuencia** | [COMPLETAR] |
| **Datos intercambiados** | [COMPLETAR] |
| **Volumen estimado** | [COMPLETAR] |
| **Restricciones SaaS** | [COMPLETAR] |
| **Estrategia BC SaaS** | [COMPLETAR] |
| **Esfuerzo estimado** | [COMPLETAR] horas |
| **Prioridad** | [COMPLETAR] |
| **Propietario técnico** | [COMPLETAR] |
| **Notas** | [COMPLETAR] |

---

## INT-006

| Campo | Detalle |
|-------|---------|
| **ID** | INT-006 |
| **Nombre** | [COMPLETAR] |
| **Sistema externo** | [COMPLETAR] |
| **Dirección** | [COMPLETAR] |
| **Protocolo actual** | [COMPLETAR] |
| **Frecuencia** | [COMPLETAR] |
| **Datos intercambiados** | [COMPLETAR] |
| **Volumen estimado** | [COMPLETAR] |
| **Restricciones SaaS** | [COMPLETAR] |
| **Estrategia BC SaaS** | [COMPLETAR] |
| **Esfuerzo estimado** | [COMPLETAR] horas |
| **Prioridad** | [COMPLETAR] |
| **Propietario técnico** | [COMPLETAR] |
| **Notas** | [COMPLETAR] |

---

## INT-007

| Campo | Detalle |
|-------|---------|
| **ID** | INT-007 |
| **Nombre** | [COMPLETAR] |
| **Sistema externo** | [COMPLETAR] |
| **Dirección** | [COMPLETAR] |
| **Protocolo actual** | [COMPLETAR] |
| **Frecuencia** | [COMPLETAR] |
| **Datos intercambiados** | [COMPLETAR] |
| **Volumen estimado** | [COMPLETAR] |
| **Restricciones SaaS** | [COMPLETAR] |
| **Estrategia BC SaaS** | [COMPLETAR] |
| **Esfuerzo estimado** | [COMPLETAR] horas |
| **Prioridad** | [COMPLETAR] |
| **Propietario técnico** | [COMPLETAR] |
| **Notas** | [COMPLETAR] |

---

## INT-008

| Campo | Detalle |
|-------|---------|
| **ID** | INT-008 |
| **Nombre** | [COMPLETAR] |
| **Sistema externo** | [COMPLETAR] |
| **Dirección** | [COMPLETAR] |
| **Protocolo actual** | [COMPLETAR] |
| **Frecuencia** | [COMPLETAR] |
| **Datos intercambiados** | [COMPLETAR] |
| **Volumen estimado** | [COMPLETAR] |
| **Restricciones SaaS** | [COMPLETAR] |
| **Estrategia BC SaaS** | [COMPLETAR] |
| **Esfuerzo estimado** | [COMPLETAR] horas |
| **Prioridad** | [COMPLETAR] |
| **Propietario técnico** | [COMPLETAR] |
| **Notas** | [COMPLETAR] |

---

## Resumen por Estrategia de Migración

| Estrategia | # Integraciones | Esfuerzo Total (h) | Notas |
|-----------|----------------|-------------------|-------|
| BC API v2.0 (OData) | [COMPLETAR] | [COMPLETAR] | Reemplazo de SOAP Web Services |
| Power Automate / Logic Apps | [COMPLETAR] | [COMPLETAR] | Flujos de automatización |
| Azure Service Bus | [COMPLETAR] | [COMPLETAR] | Mensajería async de alto volumen |
| Azure Functions | [COMPLETAR] | [COMPLETAR] | Lógica de transformación en la nube |
| File Exchange (SharePoint/SFTP) | [COMPLETAR] | [COMPLETAR] | Integraciones basadas en archivos |
| Sin cambio (compatible SaaS) | [COMPLETAR] | [COMPLETAR] | Integraciones ya basadas en API REST |
| **TOTAL** | **[COMPLETAR]** | **[COMPLETAR]** | |

---

*Referencia: [BC Integration Architecture](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-integration-overview)*
