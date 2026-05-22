#Requires -Version 7.0
<#
.SYNOPSIS
    Script de migración de datos maestros NAV 2016 → Business Central SaaS
.DESCRIPTION
    Migra Clientes, Proveedores y Artículos desde NAV 2016 a Business Central
    usando la BC API v2.0.
.PARAMETER Mode
    DryRun: Valida sin insertar datos. Execute: Ejecuta la migración real.
.EXAMPLE
    .\01-migrate-masters.ps1 -Mode DryRun
    .\01-migrate-masters.ps1 -Mode Execute
#>
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('DryRun','Execute')]
    [string]$Mode
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ─── Configuración ───────────────────────────────────────────────────────────
$TenantId     = $env:BC_TENANT_ID
$ClientId     = $env:BC_CLIENT_ID
$ClientSecret = $env:BC_CLIENT_SECRET
$Environment  = $env:BC_ENVIRONMENT
$CompanyId    = $env:BC_COMPANY_ID
$SqlServer    = $env:NAV_SQL_SERVER
$Database     = $env:NAV_DATABASE

$BaseUrl      = "https://api.businesscentral.dynamics.com/v2.0/$TenantId/$Environment/api/v2.0"
$LogFile      = "migration-masters-$(Get-Date -Format 'yyyyMMdd-HHmmss').log"

# ─── Funciones ───────────────────────────────────────────────────────────────
function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $entry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') [$Level] $Message"
    Write-Host $entry
    Add-Content -Path $LogFile -Value $entry
}

function Get-BCAccessToken {
    $tokenUrl = "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token"
    $body = @{
        grant_type    = "client_credentials"
        client_id     = $ClientId
        client_secret = $ClientSecret
        scope         = "https://api.businesscentral.dynamics.com/.default"
    }
    $response = Invoke-RestMethod -Uri $tokenUrl -Method Post -Body $body
    return $response.access_token
}

function Get-NAVData {
    param([string]$Query)
    $conn = New-Object System.Data.SqlClient.SqlConnection
    $conn.ConnectionString = "Server=$SqlServer;Database=$Database;Integrated Security=True;"
    $conn.Open()
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = $Query
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter $cmd
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null
    $conn.Close()
    return $dataset.Tables[0]
}

function Invoke-BCApi {
    param([string]$Token, [string]$Endpoint, [string]$Method = "GET", [object]$Body = $null)
    $headers = @{ Authorization = "Bearer $Token"; "Content-Type" = "application/json" }
    $uri = "$BaseUrl/companies($CompanyId)/$Endpoint"
    if ($Body) {
        return Invoke-RestMethod -Uri $uri -Method $Method -Headers $headers `
               -Body ($Body | ConvertTo-Json -Depth 10)
    }
    return Invoke-RestMethod -Uri $uri -Method $Method -Headers $headers
}

# ─── Migración de Clientes ────────────────────────────────────────────────────
function Migrate-Customers {
    param([string]$Token)
    Write-Log "Iniciando migración de Clientes..."

    $query = @"
SELECT
    [No_] AS No,
    [Name],
    [Address],
    [City],
    [Post Code] AS PostCode,
    [Country_Region Code] AS CountryCode,
    [VAT Registration No_] AS VATNo,
    [Phone No_] AS Phone,
    [E-Mail] AS Email,
    [Credit Limit (LCY)] AS CreditLimit,
    [Payment Terms Code] AS PaymentTermsCode,
    [Blocked]
    -- [COMPLETAR: añadir campos custom]
FROM [dbo].[CRONUS$Customer]  -- [COMPLETAR: nombre real de la tabla]
WHERE [Blocked] = 0
ORDER BY [No_]
"@

    $customers = Get-NAVData -Query $query
    Write-Log "Clientes encontrados en NAV 2016: $($customers.Rows.Count)"

    $success = 0; $errors = 0
    foreach ($row in $customers.Rows) {
        try {
            $payload = @{
                number          = $row.No.Trim()
                displayName     = $row.Name.Trim()
                addressLine1    = $row.Address.Trim()
                city            = $row.City.Trim()
                postalCode      = $row.PostCode.Trim()
                country         = $row.CountryCode.Trim()
                phoneNumber     = $row.Phone.Trim()
                email           = $row.Email.Trim()
            }

            if ($Mode -eq 'Execute') {
                Invoke-BCApi -Token $Token -Endpoint "customers" -Method "POST" -Body $payload | Out-Null
            }
            $success++
        } catch {
            $errors++
            Write-Log "ERROR cliente $($row.No): $($_.Exception.Message)" "ERROR"
        }
    }
    Write-Log "Clientes - Éxito: $success | Errores: $errors"
    return @{ Success = $success; Errors = $errors }
}

# ─── Main ─────────────────────────────────────────────────────────────────────
Write-Log "=== Inicio migración de maestros - Modo: $Mode ==="

if (-not $TenantId -or -not $ClientId -or -not $ClientSecret) {
    Write-Log "Variables de entorno BC no configuradas. Abortando." "ERROR"
    exit 1
}

$token = Get-BCAccessToken
Write-Log "Token de acceso BC obtenido correctamente."

$results = @{}
$results.Customers = Migrate-Customers -Token $token
# [COMPLETAR: Migrate-Vendors, Migrate-Items siguiendo el mismo patrón]

Write-Log "=== Fin migración de maestros. Log: $LogFile ==="
Write-Log "Resumen: Clientes OK=$($results.Customers.Success) ERR=$($results.Customers.Errors)"
