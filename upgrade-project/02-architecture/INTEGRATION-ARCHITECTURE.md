# Arquitectura de Integraciones BC SaaS

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Responsable:** Arquitecto de Integración

---

## 1. Propósito

Definir los patrones y tecnologías de integración para conectar Business Central SaaS con los sistemas externos del cliente, respetando las restricciones de la plataforma SaaS (sin acceso directo a SQL, sin NAS, sin COM).

**Referencia:** [BC Integration Patterns](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-integration-overview)

---

## 2. Restricciones SaaS vs NAV 2016

| Característica | NAV 2016 On-Premise | BC SaaS | Alternativa |
|---------------|--------------------|---------|-----------:|
| Acceso directo a SQL Server | ✅ Permitido | ❌ No permitido | BC OData API / API Pages |
| NAS (Background Services) | ✅ Disponible | ❌ No disponible | Job Queue Entries + Azure Functions |
| COM / DotNet Interop | ✅ Disponible | ❌ No permitido | Azure Functions (.NET) |
| SOAP Web Services | ✅ Disponible | ⚠️ Depreciado | BC API v2.0 (OData v4) |
| File System access | ✅ Disponible | ❌ No permitido | Azure Blob Storage / SharePoint |
| HTTP Client outbound | ✅ Manual | ✅ HttpClient AL nativo | HttpClient en AL |
| Webhooks outbound | ❌ No disponible | ✅ Disponible nativo | Webhooks BC nativos |

---

## 3. Patrones de Integración Disponibles

### Patrón 1: BC API (OData v4) - Síncrono

Uso: Sistemas externos que leen/escriben en BC en tiempo real.

```
Sistema Externo ──HTTPS/OData v4──► BC API Pages / API v2.0
                                    (Autenticación: OAuth2 + Azure AD)
```

**Cuándo usar:** CRM, e-commerce, portales de cliente que necesitan datos BC en tiempo real.
**Referencia:** [BC API v2.0](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/api-reference/v2.0/)

### Patrón 2: Power Automate - Eventos/Flujos

Uso: Automatización de flujos de trabajo, notificaciones, aprobaciones.

```
BC Event ──Webhook──► Power Automate Flow ──► Acción (Email, Teams, Sistema externo)
```

**Cuándo usar:** Notificaciones, aprobaciones, flujos simples de negocio.
**Referencia:** [Power Automate + BC](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/powerplatform/power-automate-overview)

### Patrón 3: Azure Service Bus - Mensajería Asíncrona

Uso: Integraciones de alto volumen que no requieren respuesta inmediata.

```
BC (AL HttpClient) ──mensaje──► Azure Service Bus ──► Sistema Externo
Sistema Externo ──mensaje──► Azure Service Bus ──► Azure Function ──► BC API
```

**Cuándo usar:** Integración con ERP/WMS de alto volumen, procesamiento batch.

### Patrón 4: Azure Functions - Transformación y Lógica

Uso: Lógica que no puede ejecutarse en AL (DotNet, librerías externas, cálculos pesados).

```
BC (HttpClient) ──HTTPS──► Azure Function (.NET/Python) ──► Resultado ──► BC
```

**Cuándo usar:** Reemplazo de COM automation, transformaciones complejas, llamadas a APIs externas con librerías especiales.

### Patrón 5: File Exchange - Intercambio de Archivos

Uso: Integraciones legacy que usan archivos CSV/XML/TXT.

```
BC (Report/XMLPort) ──genera archivo──► Azure Blob Storage / SharePoint
Azure Blob ──Power Automate──► Sistema Externo (SFTP, Email, etc.)
```

---

## 4. Mapa de Integraciones del Proyecto

| Integración | Sistema Externo | Patrón | Tecnología | Estado |
|------------|----------------|--------|-----------|--------|
| INT-001 | [COMPLETAR] | [Patrón X] | [COMPLETAR] | Pendiente diseño |
| INT-002 | [COMPLETAR] | [Patrón X] | [COMPLETAR] | Pendiente diseño |
| INT-003 | [COMPLETAR] | [Patrón X] | [COMPLETAR] | Pendiente diseño |
| INT-004 | [COMPLETAR] | File Exchange | Power Automate + SharePoint | Pendiente diseño |
| INT-005 | [COMPLETAR] | [Patrón X] | [COMPLETAR] | Pendiente diseño |

---

## 5. Seguridad de Integraciones

| Aspecto | Implementación |
|---------|---------------|
| **Autenticación BC API** | OAuth 2.0 + Azure AD App Registration (Client Credentials flow) |
| **Secretos y tokens** | Azure Key Vault (nunca en código ni config files) |
| **Certificados** | Gestión en Azure Key Vault |
| **Auditoría** | Logs en Azure Monitor / Application Insights |
| **Rate limiting** | Respetar límites de BC API: [BC API Limits](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/administration/operational-limits-online) |

---

## 6. Configuración Azure AD App Registration

Para acceso programático a BC API:

1. Crear App Registration en Azure AD del tenant
2. Asignar API Permission: `Dynamics 365 Business Central > Financials.ReadWrite.All` (o específico)
3. Crear Client Secret (o certificado) - almacenar en Key Vault
4. En BC Admin Center: registrar la App con el Client ID
5. Asignar Permission Set apropiado al usuario de servicio en BC

```
Azure AD App Registration
├── Client ID: [COMPLETAR al crear]
├── Tenant ID: [COMPLETAR]
├── Client Secret: → Azure Key Vault
└── Redirect URI: https://[COMPLETAR]/OAuthLanding.htm
```

---

*Referencia: [BC Web Services](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/webservices/web-services)*
