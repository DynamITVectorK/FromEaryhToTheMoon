# Modelo de Seguridad Business Central SaaS

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Responsable:** Consultor Funcional / Líder Técnico

---

## 1. Propósito

Definir el modelo de seguridad de Business Central SaaS para el proyecto, incluyendo el mapeo de roles de NAV 2016 a Permission Sets de BC, la integración con Azure AD y las políticas de acceso.

**Referencia:** [BC Security Overview](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/security/security-and-protection)

---

## 2. Principios de Seguridad

1. **Mínimos privilegios:** Cada usuario tiene solo los permisos necesarios para su función
2. **Autenticación centralizada:** Azure Active Directory (Entra ID) como proveedor de identidad
3. **MFA obligatorio:** Autenticación multifactor para todos los usuarios
4. **Sin contraseñas locales:** No se crean usuarios con contraseña en BC; todo via Azure AD
5. **Auditoría:** Registro de cambios activado en tablas críticas

---

## 3. Integración con Azure Active Directory

```
Usuario → Azure AD (Entra ID) → MFA → BC SaaS
                ↑
         Grupos de seguridad Azure AD
         (mapean a Permission Sets en BC)
```

**Configuración:**
- Sincronización de usuarios Azure AD con BC via licencias Microsoft 365 / Dynamics 365
- Grupos de seguridad Azure AD asignados a Permission Sets en BC
- Single Sign-On (SSO) sin contraseñas adicionales

---

## 4. Mapeo de Roles NAV 2016 → Permission Sets BC SaaS

### Roles Estándar

| Rol NAV 2016 | Permission Set BC Equivalente | Ajustes necesarios |
|-------------|------------------------------|-------------------|
| SUPER | SUPER (BC) | Solo para administradores; limitar al mínimo |
| BASIC | D365 BASIC | Acceso básico de lectura |
| Contabilidad | D365 BUS FULL ACCESS (parcial) + módulos Finanzas | [COMPLETAR] |
| Ventas | D365 SALES | [COMPLETAR] |
| Compras | D365 PURCHASING | [COMPLETAR] |
| Almacén | D365 INVENTORY | [COMPLETAR] |
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |

### Roles Personalizados (Permission Sets custom de la extensión)

| Rol de Negocio | Permission Set Custom | Descripción |
|---------------|----------------------|-------------|
| [COMPLETAR - rol específico cliente] | [PREFIX]-[COMPLETAR] | [COMPLETAR] |
| [COMPLETAR] | [PREFIX]-[COMPLETAR] | [COMPLETAR] |

---

## 5. Clasificación de Datos (Data Classification)

En BC SaaS, todos los campos de tablas custom deben tener `DataClassification` definida:

| Clasificación | Uso | Ejemplo |
|--------------|-----|---------|
| `CustomerContent` | Datos operacionales del cliente | Nombre, dirección, importes |
| `EndUserIdentifiableInformation` | Datos personales identificables (GDPR) | NIF, email personal |
| `AccountData` | Datos de cuenta/licencia | No aplica en extensiones |
| `SystemMetadata` | Metadatos del sistema | Timestamps, user IDs |
| `ToBeClassified` | Sin clasificar (temporal, no dejar en producción) | ❌ Eliminar antes de go-live |

```al
// ✅ CORRECTO: Siempre declarar DataClassification
field(50100; "[PREFIX] Customer Type"; Enum "[PREFIX] Customer Type")
{
    DataClassification = CustomerContent;
    Caption = 'Customer Type';
}
```

---

## 6. Registro de Cambios (Change Log)

Activar Change Log para tablas críticas:

| Tabla | Campos monitoreados | Responsable |
|-------|--------------------|-----------:|
| Customer | "Credit Limit (LCY)", "Payment Terms Code", campos custom sensibles | Contabilidad |
| Vendor | "Payment Terms Code", campos bancarios | Contabilidad |
| Item | "Unit Cost", "Unit Price" | Inventario |
| G/L Account | "Direct Posting", "Account Type" | Finanzas |
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |

---

## 7. Políticas de Acceso por Entorno

| Política | DEV | QA | UAT | Production |
|---------|-----|-----|-----|-----------|
| MFA requerido | No (recomendado) | No | Sí | Sí (obligatorio) |
| Acceso externo (partner) | Sí (admin delegado) | Sí | Sí (supervisado) | Sí (limitado post go-live) |
| Exportación de datos sensibles | Permitido (datos sintéticos) | Restringido | Restringido | Auditado |
| Delegated Admin (partner) | Sí | Sí | Sí | Solo durante soporte; revocar post-proyecto |

---

*Referencia: [BC Permission Sets](https://learn.microsoft.com/es-es/dynamics365/business-central/ui-define-granular-permissions)*
