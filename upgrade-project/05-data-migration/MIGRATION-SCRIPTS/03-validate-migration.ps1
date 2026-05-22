#Requires -Version 7.0
<#
.SYNOPSIS
    Validación automática post-migración: recuentos y reconciliación financiera.
.DESCRIPTION
    Compara recuentos de registros y saldos entre NAV 2016 y BC SaaS.
    Genera reporte HTML de resultados.
#>

Set-StrictMode -Version Latest

$TenantId    = $env:BC_TENANT_ID
$ClientId    = $env:BC_CLIENT_ID
$ClientSecret= $env:BC_CLIENT_SECRET
$Environment = $env:BC_ENVIRONMENT
$CompanyId   = $env:BC_COMPANY_ID
$ReportFile  = "validation-report-$(Get-Date -Format 'yyyyMMdd-HHmmss').html"

$Results     = @()
$OverallPass = $true

function Add-ValidationResult {
    param([string]$Check, [object]$Expected, [object]$Actual, [bool]$Passed, [string]$Notes="")
    $script:Results += [PSCustomObject]@{
        Check    = $Check
        Expected = $Expected
        Actual   = $Actual
        Diff     = if ($Expected -is [decimal] -or $Expected -is [int]) { $Actual - $Expected } else { "N/A" }
        Status   = if ($Passed) { "✅ PASS" } else { "❌ FAIL" }
        Notes    = $Notes
    }
    if (-not $Passed) { $script:OverallPass = $false }
}

# ─── Validaciones ─────────────────────────────────────────────────────────────
# [COMPLETAR: implementar cada validación consultando NAV SQL y BC API]

# Ejemplo de estructura:
# $navCustomerCount = (Get-NAVData "SELECT COUNT(*) as Cnt FROM [Customer]").Rows[0].Cnt
# $bcCustomerCount  = (Invoke-BCApi -Token $token -Endpoint "customers?`$count=true").value.Count
# Add-ValidationResult "Recuento Clientes" $navCustomerCount $bcCustomerCount ($navCustomerCount -eq $bcCustomerCount)

# ─── Generar Reporte HTML ─────────────────────────────────────────────────────
$htmlBody = $Results | ConvertTo-Html -Title "Validación Post-Migración" -PreContent "<h2>Validación Migración NAV2016 → BC SaaS - $(Get-Date)</h2>"
Set-Content -Path $ReportFile -Value $htmlBody

$finalStatus = if ($OverallPass) { "✅ TODAS LAS VALIDACIONES PASARON - GO para apertura del sistema" } `
               else { "❌ VALIDACIONES FALLIDAS - NO ABRIR EL SISTEMA - Revisar el reporte" }

Write-Host "`n$finalStatus`n"
Write-Host "Reporte generado: $ReportFile"

exit $(if ($OverallPass) { 0 } else { 1 })
