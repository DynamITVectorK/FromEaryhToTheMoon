[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)]
    [string]$InputCsv,

    [Parameter(Mandatory = $true)]
    [string]$InventoryFile,

    [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $InputCsv -PathType Leaf)) {
    throw "No existe el CSV de entrada: $InputCsv"
}

$rows = Import-Csv -LiteralPath $InputCsv
if (-not $rows -or $rows.Count -eq 0) {
    throw "El CSV no contiene filas: $InputCsv"
}

function New-SummaryLines {
    param([Parameter(Mandatory = $true)][object[]]$Data)

    $statusSummary = $Data | Group-Object Status | Sort-Object Name
    $riskSummary = $Data | Group-Object 'Risk Level' | Sort-Object Name

    $lines = @(
        '## Inventario diferencial generado automáticamente'
        ''
        "> Fuente: $InputCsv"
        "> Fecha generación: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        '> Estado: baseline automático pendiente de revisión técnica NAV/BC.'
        ''
        '### Resumen por estado'
        ''
        '| Estado | Cantidad |'
        '|---|---:|'
    )

    foreach ($item in $statusSummary) {
        $lines += "| $($item.Name) | $($item.Count) |"
    }

    $lines += @(
        ''
        '### Resumen por riesgo'
        ''
        '| Riesgo | Cantidad |'
        '|---|---:|'
    )

    foreach ($item in $riskSummary) {
        $lines += "| $($item.Name) | $($item.Count) |"
    }

    $lines += @(
        ''
        '### Detalle del inventario diferencial'
        ''
        '| Object Type | Object ID | Object Name | Status | Suggested Migration Strategy | Risk Level | Notes |'
        '|---|---:|---|---|---|---|---|'
    )

    foreach ($row in ($Data | Sort-Object 'Object Type', 'Object ID')) {
        $name = [string]$row.'Object Name' -replace '\|', '\|'
        $strategy = [string]$row.'Suggested Migration Strategy' -replace '\|', '\|'
        $notes = [string]$row.'Notes' -replace '\|', '\|'
        $lines += "| $($row.'Object Type') | $($row.'Object ID') | $name | $($row.Status) | $strategy | $($row.'Risk Level') | $notes |"
    }

    return $lines
}

$newSectionLines = New-SummaryLines -Data $rows
$newSectionText = ($newSectionLines -join "`n") + "`n"

$existingContent = if (Test-Path -LiteralPath $InventoryFile -PathType Leaf) {
    Get-Content -LiteralPath $InventoryFile -Raw
}
else {
    "# Inventario de Objetos NAV 2016`n`n"
}

$sectionPattern = '(?ms)^## Inventario diferencial generado automáticamente.*?(?=^## |\z)'

if ($existingContent -match $sectionPattern) {
    $updatedContent = [regex]::Replace($existingContent, $sectionPattern, $newSectionText)
}
else {
    $separator = if ($existingContent.EndsWith("`n")) { '' } else { "`n" }
    $updatedContent = $existingContent + $separator + "`n" + $newSectionText
}

if ($DryRun) {
    Write-Host 'Modo DryRun activo. Vista previa de la sección generada:'
    $newSectionLines | Select-Object -First 40 | ForEach-Object { Write-Host $_ }
    return
}

if ($PSCmdlet.ShouldProcess($InventoryFile, 'Actualizar inventario diferencial en Markdown')) {
    Set-Content -LiteralPath $InventoryFile -Value $updatedContent -Encoding UTF8
}

Write-Host "Documento actualizado: $InventoryFile"
