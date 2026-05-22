# Diseño de la Solución Business Central SaaS

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Responsable:** Arquitecto de Solución

---

## 1. Resumen Ejecutivo

Este documento define la arquitectura de la solución para la migración de Microsoft Dynamics NAV 2016 a Business Central SaaS. La solución aprovecha el modelo de extensiones AL (per-tenant extensions), la plataforma Azure y las capacidades nativas de BC SaaS para modernizar el ERP sin sacrificar las personalizaciones críticas del negocio.

**Referencia oficial:** [BC Architecture Overview](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/administration/tenant-admin-center)

---

## 2. Principios de Diseño

| Principio | Descripción | Implicación técnica |
|-----------|-------------|---------------------|
| **Extension-First** | Toda personalización como extensión AL; nunca modificar objetos base | TableExtension, PageExtension, EventSubscribers |
| **API-First** | Integraciones mediante APIs REST estándar de BC o APIs custom | BC API v2.0, API Pages |
| **Cloud-Native** | Aprovechar servicios Azure para lo que BC SaaS no puede hacer nativamente | Azure Functions, Service Bus, Power Automate |
| **Zero Downtime Updates** | Extensiones compatibles con minor updates automáticos de BC | Seguir compatibility guidelines, evitar breaking changes |
| **Least Privilege** | Modelo de seguridad con mínimos permisos necesarios por rol | Permission Sets granulares, Security Groups |

---

## 3. Arquitectura de Alto Nivel

```
┌─────────────────────────────────────────────────────────────────────┐
│                     Microsoft Azure Cloud                           │
│                                                                     │
│  ┌───────────────────────────────────────────────────────────────┐  │
│  │          Business Central SaaS (Microsoft-Managed)           │  │
│  │                                                               │  │
│  │  ┌─────────────────┐    ┌─────────────────────────────────┐  │  │
│  │  │  BC Standard    │    │  Per-Tenant Extension (PTE)     │  │  │
│  │  │  Application    │◄───│  Personalizaciones del cliente  │  │  │
│  │  │  (Base App)     │    │  Desarrolladas en AL            │  │  │
│  │  └─────────────────┘    └─────────────────────────────────┘  │  │
│  │                                                               │  │
│  │  ┌──────────────────────────────────────────────────────┐    │  │
│  │  │  BC SaaS APIs                                        │    │  │
│  │  │  OData v4 / BC API v2.0 / Custom API Pages           │    │  │
│  │  └──────────────────────────────────────────────────────┘    │  │
│  └───────────────────────────────────────────────────────────────┘  │
│                              │                                       │
│  ┌───────────────────────────┼───────────────────────────────────┐  │
│  │       Azure Integration Layer                                 │  │
│  │  ┌──────────────┐  ┌─────────────┐  ┌───────────────────────┐│  │
│  │  │ Power        │  │ Azure       │  │ Azure Service Bus     ││  │
│  │  │ Automate     │  │ Functions   │  │ (mensajería async)    ││  │
│  │  └──────────────┘  └─────────────┘  └───────────────────────┘│  │
│  └───────────────────────────────────────────────────────────────┘  │
│                              │                                       │
└──────────────────────────────┼──────────────────────────────────────┘
                               │
        ┌──────────────────────┼──────────────────────┐
        │                      │                      │
   ┌────┴─────┐        ┌──────┴──────┐        ┌──────┴──────┐
   │ Sistema  │        │   Sistema   │        │   Portal    │
   │ Externo A│        │  Externo B  │        │ Clientes    │
   │(Nóminas) │        │  (eCommerce)│        │  (Web)      │
   └──────────┘        └─────────────┘        └─────────────┘
```

---

## 4. Componentes de la Solución

### 4.1 Business Central SaaS (Core ERP)

| Componente | Descripción | Responsabilidad Microsoft | Responsabilidad Cliente |
|-----------|-------------|--------------------------|------------------------|
| Plataforma BC | Infraestructura, BD, actualizaciones | 100% Microsoft | Ninguna |
| Base Application | Funcionalidad estándar BC | 100% Microsoft | Configuración |
| Per-Tenant Extension | Personalizaciones del cliente | Ninguna | 100% Cliente/Partner |
| Licencias | Asignación de licencias y entornos | Gestión portal | Adquisición y asignación |

### 4.2 Entornos Business Central

| Entorno | Propósito | Acceso | Datos |
|---------|-----------|--------|-------|
| **Sandbox - DEV** | Desarrollo diario de extensiones AL | Solo equipo técnico | Datos sintéticos |
| **Sandbox - QA** | Integración y testing | Equipo técnico + QA | Copia anonimizada producción |
| **Sandbox - UAT** | User Acceptance Testing | Usuarios clave + equipo | Copia migrada de NAV2016 |
| **Production** | Sistema productivo | Todos los usuarios | Datos reales migrados |

### 4.3 Azure Integration Services

| Servicio | Uso en el proyecto | Costo estimado |
|---------|-------------------|----------------|
| **Power Automate** | Flujos de notificación, integraciones simples, aprobaciones | [COMPLETAR] |
| **Azure Functions** | Lógica de transformación de datos, reemplazo de COM automation | [COMPLETAR] |
| **Azure Service Bus** | Cola de mensajes para integraciones async de alto volumen | [COMPLETAR] |
| **Azure API Management** | Gestión y seguridad de APIs expuestas por BC | [COMPLETAR] |
| **Azure Key Vault** | Almacenamiento seguro de secretos, tokens, certificados | [COMPLETAR] |

---

## 5. Modelo de Licenciamiento

| Tipo de Licencia | Cantidad | Módulos incluidos | Costo mensual estimado |
|-----------------|---------|------------------|----------------------|
| BC Essentials | [COMPLETAR] usuarios | Finanzas, Ventas, Compras, Inventario básico | [COMPLETAR] |
| BC Premium | [COMPLETAR] usuarios | Todo Essentials + Manufacturing, Service | [COMPLETAR] |
| BC Team Members | [COMPLETAR] usuarios | Lectura + aprobaciones simples | [COMPLETAR] |
| **Total** | **[COMPLETAR]** | | **[COMPLETAR]/mes** |

**Referencia:** [BC Licensing Guide](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/deployment/licensing)

---

## 6. Decisiones de Arquitectura

| ID | Decisión | Alternativas consideradas | Razón de la elección |
|----|---------|--------------------------|---------------------|
| AD-001 | Usar Per-Tenant Extension (PTE) en lugar de AppSource App | AppSource App, código base modificado | PTE permite despliegue rápido sin proceso de certificación; el código es propiedad del cliente |
| AD-002 | Azure Functions para lógica COM/DotNet incompatible con SaaS | Eliminar funcionalidad, buscar app ISV | Preserva funcionalidades críticas de negocio sin violar restricciones SaaS |
| AD-003 | Power Automate para flujos de aprobación estándar | Desarrollar Approval Workflows en AL | Solución no-code, mantenible por el negocio sin desarrollo |
| AD-004 | BC API v2.0 + OData para integraciones | SOAP Web Services (obsoleto), acceso directo BD | OData v4 es el estándar soportado; SOAP depreciado; acceso BD no permitido en SaaS |
| AD-005 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |

---

## 7. Consideraciones de Seguridad

- Autenticación mediante Azure Active Directory (Azure AD / Entra ID)
- Multi-Factor Authentication (MFA) obligatorio para todos los usuarios
- Permission Sets granulares por rol de negocio
- Auditoría completa de cambios habilitada en BC
- Datos cifrados en reposo y en tránsito (responsabilidad Microsoft)
- Gestión de secrets en Azure Key Vault (sin credenciales en código)

---

*Referencia: [BC SaaS Security](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/security/security-and-protection)*
