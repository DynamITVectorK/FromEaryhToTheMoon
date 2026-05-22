# Scripts de Migración de Datos

> **Versión:** 1.0 | **Responsable:** Especialista de Datos

## Contenido

| Script | Propósito | Capa |
|--------|-----------|------|
| `01-migrate-masters.ps1` | Migrar datos maestros (Clientes, Proveedores, Artículos) | 2 |
| `02-migrate-balances.ps1` | Migrar saldos abiertos CxC, CxP e Inventario | 3 |
| `03-validate-migration.ps1` | Validar recuentos y reconciliaciones automáticas | Post-migración |

## Prerequisitos
- PowerShell 7.x o superior
- Acceso a BD SQL Server de NAV 2016
- Azure AD App Registration con permisos BC API
- Client Secret almacenado en Azure Key Vault

## Variables de Entorno Requeridas
```powershell
$env:BC_TENANT_ID      = "[COMPLETAR]"
$env:BC_CLIENT_ID      = "[COMPLETAR]"  # Azure AD App Client ID
$env:BC_CLIENT_SECRET  = "[COMPLETAR]"  # Desde Key Vault, nunca hardcoded
$env:BC_ENVIRONMENT    = "[COMPLETAR]"  # Nombre del entorno BC (ej: UAT, Production)
$env:BC_COMPANY_ID     = "[COMPLETAR]"  # ID de la empresa en BC
$env:NAV_SQL_SERVER    = "[COMPLETAR]"  # Servidor SQL NAV 2016
$env:NAV_DATABASE      = "[COMPLETAR]"  # Nombre BD NAV 2016
```

## Ejecución
```powershell
# 1. Configurar variables de entorno
# 2. Ejecutar en orden:
.\01-migrate-masters.ps1 -Mode DryRun   # Primero en modo dry-run
.\01-migrate-masters.ps1 -Mode Execute  # Luego ejecución real
.\02-migrate-balances.ps1 -Mode DryRun
.\02-migrate-balances.ps1 -Mode Execute
.\03-validate-migration.ps1             # Siempre al final
```

**Referencia:** [BC API Authentication](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-develop-connect-apps)
