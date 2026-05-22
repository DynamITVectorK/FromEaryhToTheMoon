# Estrategia de Entornos Business Central

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Responsable:** Líder Técnico

---

## 1. Propósito

Definir la estrategia de gestión de entornos de Business Central SaaS para el proyecto, incluyendo cuántos entornos se necesitan, su propósito, acceso y ciclo de vida.

**Referencia:** [BC Admin Center - Environments](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/administration/tenant-admin-center-environments)

---

## 2. Entornos del Proyecto

### Entorno 1: Sandbox DEV (Desarrollo)

| Campo | Detalle |
|-------|---------|
| **Nombre** | [COMPLETAR-DEV] |
| **Tipo** | Sandbox |
| **Versión BC** | Última versión estable (actualizado automáticamente) |
| **Propósito** | Desarrollo diario de extensiones AL; pruebas unitarias |
| **Acceso** | Solo equipo técnico (desarrolladores AL) |
| **Datos** | Datos sintéticos / CRONUS de demostración |
| **Extensiones desplegadas** | Versiones en desarrollo (debug mode) |
| **Refresh** | Semanal desde producción (cuando exista) o periódico |

**Flujo de trabajo:**
```
Desarrollador → VS Code → Publish & Debug → Sandbox DEV
```

---

### Entorno 2: Sandbox QA (Testing)

| Campo | Detalle |
|-------|---------|
| **Nombre** | [COMPLETAR-QA] |
| **Tipo** | Sandbox |
| **Versión BC** | Misma que producción |
| **Propósito** | Integración, testing funcional, validación de extensiones |
| **Acceso** | Equipo técnico + QA + consultor funcional |
| **Datos** | Copia anonimizada de datos NAV 2016 (sin datos personales sensibles) |
| **Extensiones desplegadas** | Release candidates del sprint actual |
| **Refresh** | Antes de cada ciclo de testing |

---

### Entorno 3: Sandbox UAT (User Acceptance Testing)

| Campo | Detalle |
|-------|---------|
| **Nombre** | [COMPLETAR-UAT] |
| **Tipo** | Sandbox |
| **Versión BC** | Misma que producción |
| **Propósito** | UAT con usuarios clave, validación de datos migrados, capacitación |
| **Acceso** | Usuarios clave + super usuarios + equipo técnico/funcional |
| **Datos** | Migración completa de datos NAV 2016 (para UAT de migración) |
| **Extensiones desplegadas** | Versión candidata a producción (release candidate) |
| **Refresh** | Antes de inicio de UAT; no se refresca durante UAT |

---

### Entorno 4: Production (Producción)

| Campo | Detalle |
|-------|---------|
| **Nombre** | [COMPLETAR-PROD] |
| **Tipo** | Production |
| **Versión BC** | Gestionada por Microsoft (major updates 2/año) |
| **Propósito** | Sistema productivo del cliente |
| **Acceso** | Todos los usuarios (según licencia y permission sets) |
| **Datos** | Datos reales migrados desde NAV 2016 |
| **Extensiones desplegadas** | Versiones certificadas y aprobadas en UAT |
| **Backup** | Gestionado automáticamente por Microsoft (Point-in-Time restore) |

---

## 3. Ciclo de Vida de Despliegues

```
Rama feature/XXXX → DEV sandbox (debug)
         ↓
Merge a rama develop → QA sandbox (testing automático)
         ↓
Release candidate → UAT sandbox (UAT con usuarios)
         ↓
Aprobación UAT → Production (tras sign-off)
```

---

## 4. Gestión de Actualizaciones Automáticas BC

| Tipo de Update | Frecuencia | Ventana de Mantenimiento | Acción requerida |
|---------------|-----------|--------------------------|-----------------|
| Minor update (hotfixes) | Mensual | Configurable (ej: domingos 2-6am) | Monitorear compatibilidad |
| Major update | 2 veces/año (Abr y Oct) | Configurable; opt-in/out-out limitado | Probar extensiones con preview; aprobar update |

**Proceso para Major Updates:**
1. Microsoft publica preview de la nueva versión
2. Actualizar sandbox DEV a la versión preview
3. Compilar y publicar extensiones en el preview
4. Corregir incompatibilidades
5. Aceptar el major update en producción antes del deadline de Microsoft

---

## 5. Acceso y Seguridad de Entornos

| Entorno | Acceso admin | Tipo de autenticación | Quién puede hacer backup/restore |
|---------|-------------|----------------------|----------------------------------|
| DEV | Partner + Admin cliente | Azure AD | Partner |
| QA | Partner + Admin cliente | Azure AD | Partner |
| UAT | Partner + Admin cliente | Azure AD | Partner + Admin cliente |
| Production | Admin cliente (post go-live) | Azure AD + MFA obligatorio | Microsoft (Point-in-Time) |

---

*Referencia: [Managing Environments](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/administration/tenant-admin-center-environments)*
