# Funcionalidades Obsoletas: NAV 2016 → Business Central SaaS

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Responsable:** Líder Técnico

---

## Propósito

Documentar todas las funcionalidades, patrones y objetos de NAV 2016 que están obsoletos o son incompatibles con Business Central SaaS, junto con las alternativas oficiales de Microsoft.

**Referencia:** [Deprecated Features BC](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-deprecation-code-changes)

---

## 1. Características del Lenguaje C/AL Depreciadas

| Característica C/AL | Estado en BC AL | Alternativa | Prioridad de Conversión |
|--------------------|----------------|-------------|------------------------|
| `WITH` implícito | ❌ Eliminado (feature `NoImplicitWith`) | Siempre usar `Rec.` o variable explícita | Alta - Error de compilación |
| `TEXTCONST` | ⚠️ Depreciado | `Label` con `MaxLength` | Alta |
| `OPTION` type fields | ⚠️ Depreciado | `Enum` objects | Media |
| `FORM` type | ❌ Eliminado | `Page` type | N/A (no existe en AL) |
| `REPORT.PREVIEW` | ⚠️ Cambiado | `Report.Print` / `CurrReport.Preview` | Media |
| Variables globales de objeto | ❌ Cambiado | `var` en procedures; pasar como parámetros | Alta |
| Modificación directa de objetos base | ❌ No permitido | `TableExtension`, `PageExtension`, EventSubscribers | Crítica |
| `DATAPORT` | ❌ Eliminado | `XMLPort` → `API Page` | N/A (convertir a API) |
| `HYPERLINK` con rutas locales | ❌ No permitido en SaaS | Solo URLs HTTPS | Alta |
| `SLEEP` | ⚠️ Limitado | Evitar en SaaS; usar Job Queue para diferir | Media |

---

## 2. Tecnologías Incompatibles con SaaS

| Tecnología | Estado | Razón | Alternativa |
|-----------|--------|-------|-------------|
| **DotNet Interop** | ❌ No permitido en runtime SaaS | Seguridad y aislamiento del tenant | Azure Functions (.NET 6/8) |
| **COM Automation** | ❌ No permitido | Sin acceso a COM en la nube | Azure Functions |
| **ActiveX / OCX** | ❌ No permitido | Sin cliente rich Windows | JavaScript Control Add-ins |
| **NAS (NAV Application Server)** | ❌ No existe en SaaS | Sustituido por Job Queue y Azure | Job Queue Entries + Azure Functions |
| **File System Access** | ❌ No permitido | Sin acceso al sistema de archivos del servidor | `DownloadFromStream`, Azure Blob Storage |
| **SQL Server Direct Access** | ❌ No permitido | Sin acceso a la capa de BD | AL Queries, OData API, BC API |
| **Windows Task Scheduler** | ❌ No aplica | Sin servidor propio | Job Queue Entries |
| **SMTP directo desde servidor** | ⚠️ Cambiado | Usar Microsoft 365 Mail o conector | BC Email Module + M365 / SMTP via Azure |
| **SOAP Web Services** | ⚠️ Depreciado (funciona pero limitado) | Microsoft reemplazando por OData/API | BC API v2.0 (OData v4) |
| **NET Add-ins en servidor** | ❌ No permitido | Sin add-ins de servidor en SaaS | Azure Functions |

---

## 3. Funcionalidades BC Eliminadas vs NAV 2016

| Funcionalidad NAV 2016 | Estado en BC SaaS | Alternativa/Nota |
|----------------------|------------------|----------------|
| **MENU SUITE** | ❌ Eliminado | Navigation Menus en páginas, Profile-based navigation |
| **Classic Client (RTC legacy)** | ❌ Eliminado | Solo Web Client y móvil |
| **Windows Client** | ❌ Eliminado | Solo Web Client (browser y app móvil) |
| **Report Viewer (RDLC directo)** | ⚠️ Cambiado | RDLC + Word Layouts; Preview en browser |
| **Pages de tipo Chart** | ⚠️ Cambiado | Charts en páginas mediante AL; Power BI integrado |
| **Job Queue (legacy)** | 🔄 Mejorado | Job Queue nativo de BC SaaS con más opciones |
| **Batch Jobs estilo NAV** | 🔄 Mejorado | Reports con RequestPage o Job Queue |

---

## 4. APIs y Web Services Depreciados

| API / Web Service | Estado | Alternativa | Fecha límite |
|------------------|--------|-------------|-------------|
| SOAP Web Services (generados desde BC) | ⚠️ Funciona pero depreciado | BC API v2.0 (OData v4) | Revisar anuncios Microsoft |
| OData v3 | ❌ Eliminado en versiones recientes | OData v4 | Ya eliminado |
| Basic Auth para Web Services | ❌ Eliminado | OAuth 2.0 + Azure AD | Ya eliminado |
| NavUserPassword (en SaaS) | ❌ No aplica | Solo Azure AD auth | N/A |

---

## 5. Impacto en el Proyecto

### Objetos del cliente que usan características depreciadas

| Objeto NAV 2016 | Característica depreciada | Impacto | Acción requerida |
|----------------|--------------------------|---------|-----------------|
| [COMPLETAR] | DotNet interop | Alto | Rediseñar con Azure Function |
| [COMPLETAR] | NAS / background process | Alto | Rediseñar con Job Queue |
| [COMPLETAR] | OPTION field | Bajo | Convertir a Enum |
| [COMPLETAR] | Implicit WITH | Bajo | Añadir prefijo Rec. |
| [COMPLETAR] | File system access | [COMPLETAR] | [COMPLETAR] |

---

*Referencia: [BC Deprecated Features](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-deprecation-guidelines)*
