#Requires -Version 7.0
<#
.SYNOPSIS
    Migración de saldos abiertos NAV 2016 → BC SaaS (CxC, CxP, Inventario)
.PARAMETER Mode
    DryRun | Execute
.PARAMETER CutoffDate
    Fecha de corte para saldos (formato: yyyy-MM-dd)
#>
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('DryRun','Execute')]
    [string]$Mode,

    [Parameter(Mandatory=$true)]
    [DateTime]$CutoffDate
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$TenantId     = $env:BC_TENANT_ID
$ClientId     = $env:BC_CLIENT_ID
$ClientSecret = $env:BC_CLIENT_SECRET
$Environment  = $env:BC_ENVIRONMENT
$CompanyId    = $env:BC_COMPANY_ID
$LogFile      = "migration-balances-$(Get-Date -Format 'yyyyMMdd-HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $entry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') [$Level] $Message"
    Write-Host $entry
    Add-Content -Path $LogFile -Value $entry
}

# [COMPLETAR: reutilizar Get-BCAccessToken, Get-NAVData, Invoke-BCApi del script 01]

function Migrate-OpenARBalances {
    param([string]$Token)
    Write-Log "Migrando saldos abiertos Cuentas por Cobrar a $CutoffDate..."

    # Query de saldos pendientes en NAV 2016
    $query = @"
SELECT
    cle.[Customer No_] AS CustomerNo,
    cle.[Document Type] AS DocType,
    cle.[Document No_] AS DocNo,
    cle.[Posting Date] AS PostingDate,
    cle.[Due Date] AS DueDate,
    cle.[Description],
    cle.[Amount (LCY)] AS AmountLCY,
    cle.[Remaining Amount] AS RemainingAmount,
    cle.[Currency Code] AS CurrencyCode
FROM [dbo].[CRONUS\$Cust_ Ledger Entry] cle  -- [COMPLETAR: nombre real]
WHERE cle.[Open] = 1
  AND cle.[Posting Date] <= '$($CutoffDate.ToString("yyyy-MM-dd"))'
ORDER BY cle.[Customer No_], cle.[Document No_]
"@
    # [COMPLETAR: implementar carga via General Journal API de BC]
    Write-Log "Query CxC preparado. Modo: $Mode"
    # ...
}

function Migrate-InventoryBalances {
    param([string]$Token)
    Write-Log "Migrando saldos de inventario a $CutoffDate..."
    # [COMPLETAR: usar Item Journal API de BC para cargar inventario inicial]
}

Write-Log "=== Inicio migración de saldos. Fecha corte: $CutoffDate | Modo: $Mode ==="
# [COMPLETAR: obtener token y llamar a funciones]
Write-Log "=== Fin migración de saldos. Log: $LogFile ==="
