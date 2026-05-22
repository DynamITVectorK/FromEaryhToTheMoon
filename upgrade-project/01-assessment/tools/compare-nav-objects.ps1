[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$StandardPath,

    [Parameter(Mandatory = $true)]
    [string]$CustomerPath,

    [Parameter(Mandatory = $true)]
    [string]$OutputCsv,

    [Parameter(Mandatory = $true)]
    [string]$OutputMarkdown,

    [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Read-NavObjectFile {
    param([Parameter(Mandatory = $true)][System.IO.FileInfo]$File)

    $preview = Get-Content -LiteralPath $File.FullName -TotalCount 40
    $headerLine = $preview | Where-Object { $_ -match '^\s*OBJECT\s+(Table|Report|Codeunit|XMLport|MenuSuite|Page|Query)\s+(\d+)\s+(.+?)\s*$' } | Select-Object -First 1

    if (-not $headerLine) {
        return $null
    }

    $null = $headerLine -match '^\s*OBJECT\s+(Table|Report|Codeunit|XMLport|MenuSuite|Page|Query)\s+(\d+)\s+(.+?)\s*$'
    $raw = Get-Content -LiteralPath $File.FullName -Raw

    return [PSCustomObject]@{
        ObjectType       = $matches[1]
        ObjectID         = [int]$matches[2]
        ObjectName       = $matches[3].Trim()
        FilePath         = $File.FullName
        Hash             = (Get-FileHash -LiteralPath $File.FullName -Algorithm SHA256).Hash
        HasDotNetOrCom   = ($raw -match '(?i)\bDotNet\b|\bAutomation\b|\bCOM\b')
    }
}

function Get-SuggestedStrategy {
    param(
        [string]$Status,
        [string]$ObjectType,
        [int]$ObjectID,
        [bool]$HasDotNetOrCom
    )

    if ($HasDotNetOrCom) {
        return 'Bloqueo SaaS; requiere rediseño'
    }

    if ($Status -eq 'New Customer Object' -and $ObjectID -ge 50000) {
        return 'Convertir/Revisar como objeto AL nuevo'
    }

    if ($Status -eq 'Modified Standard Object') {
        switch ($ObjectType) {
            'Table'     { return 'TableExtension / revisar triggers' }
            'Page'      { return 'PageExtension' }
            'Codeunit'  { return 'Rediseño mediante eventos' }
            'Report'    { return 'ReportExtension o report nuevo' }
            'XMLport'   { return 'Revisar si sigue como XMLport o se sustituye por API' }
            'MenuSuite' { return 'No migrar directamente; rediseñar navegación' }
            'Query'     { return 'Revisar Query AL o API Query' }
            default     { return 'Revisión manual requerida' }
        }
    }

    if ($Status -eq 'Deleted/Missing') {
        return 'Evaluar si se elimina, sustituye por estándar o AppSource'
    }

    return 'Sin acción inicial (baseline)'
}

function Get-RiskLevel {
    param(
        [string]$Status,
        [string]$ObjectType,
        [bool]$HasDotNetOrCom
    )

    if ($HasDotNetOrCom) {
        return 'High'
    }

    if ($Status -eq 'Modified Standard Object' -and $ObjectType -in @('Codeunit', 'Table', 'MenuSuite')) {
        return 'High'
    }

    if ($Status -eq 'Modified Standard Object' -or $Status -eq 'New Customer Object') {
        return 'Medium'
    }

    return 'Low'
}

function ConvertTo-MarkdownTable {
    param([Parameter(Mandatory = $true)][object[]]$Rows)

    $header = @(
        '| Object Type | Object ID | Object Name | Status | Standard File | Customer File | Has Differences | Suggested Migration Strategy | Risk Level | Notes |'
        '|---|---:|---|---|---|---|---|---|---|---|'
    )

    $body = foreach ($row in $Rows) {
        $cells = @(
            $row.'Object Type'
            $row.'Object ID'
            ($row.'Object Name' -replace '\|', '\|')
            $row.Status
            ($row.'Standard File' -replace '\|', '\|')
            ($row.'Customer File' -replace '\|', '\|')
            [string]$row.'Has Differences'
            ($row.'Suggested Migration Strategy' -replace '\|', '\|')
            $row.'Risk Level'
            ($row.Notes -replace '\|', '\|')
        )

        '| ' + ($cells -join ' | ') + ' |'
    }

    return @($header + $body)
}

if (-not (Test-Path -LiteralPath $StandardPath -PathType Container)) {
    throw "No existe la carpeta standard: $StandardPath"
}
if (-not (Test-Path -LiteralPath $CustomerPath -PathType Container)) {
    throw "No existe la carpeta customer: $CustomerPath"
}

$stdFiles = Get-ChildItem -LiteralPath $StandardPath -Filter '*.txt' -File
$custFiles = Get-ChildItem -LiteralPath $CustomerPath -Filter '*.txt' -File

Write-Host "Archivos standard: $($stdFiles.Count)"
Write-Host "Archivos customer: $($custFiles.Count)"

$stdMap = @{}
foreach ($file in $stdFiles) {
    $obj = Read-NavObjectFile -File $file
    if ($null -ne $obj) {
        $key = '{0}|{1}' -f $obj.ObjectType, $obj.ObjectID
        $stdMap[$key] = $obj
    }
}

$custMap = @{}
foreach ($file in $custFiles) {
    $obj = Read-NavObjectFile -File $file
    if ($null -ne $obj) {
        $key = '{0}|{1}' -f $obj.ObjectType, $obj.ObjectID
        $custMap[$key] = $obj
    }
}

$allKeys = ($stdMap.Keys + $custMap.Keys) | Sort-Object -Unique
$rows = New-Object System.Collections.Generic.List[object]

foreach ($key in $allKeys) {
    $std = if ($stdMap.ContainsKey($key)) { $stdMap[$key] } else { $null }
    $cust = if ($custMap.ContainsKey($key)) { $custMap[$key] } else { $null }

    $status = ''
    $hasDifferences = $false

    if ($null -ne $std -and $null -ne $cust) {
        if ($std.Hash -eq $cust.Hash) {
            $status = 'Unchanged'
            $hasDifferences = $false
        }
        else {
            $status = 'Modified Standard Object'
            $hasDifferences = $true
        }
    }
    elseif ($null -eq $std -and $null -ne $cust) {
        $status = 'New Customer Object'
        $hasDifferences = $true
    }
    else {
        $status = 'Deleted/Missing'
        $hasDifferences = $true
    }

    $objectType = if ($null -ne $cust) { $cust.ObjectType } else { $std.ObjectType }
    $objectID = if ($null -ne $cust) { $cust.ObjectID } else { $std.ObjectID }
    $objectName = if ($null -ne $cust) { $cust.ObjectName } else { $std.ObjectName }
    $hasDotNetOrCom = (($null -ne $std -and $std.HasDotNetOrCom) -or ($null -ne $cust -and $cust.HasDotNetOrCom))

    $notes = if ($hasDotNetOrCom) {
        'Detectado DotNet/Automation/COM. Bloqueo para BC SaaS; rediseño obligatorio.'
    }
    else {
        'Baseline automático. Validar con arquitecto NAV/BC.'
    }

    $rows.Add([PSCustomObject]@{
        'Object Type'                   = $objectType
        'Object ID'                     = $objectID
        'Object Name'                   = $objectName
        'Status'                        = $status
        'Standard File'                 = if ($null -ne $std) { $std.FilePath } else { '' }
        'Customer File'                 = if ($null -ne $cust) { $cust.FilePath } else { '' }
        'Has Differences'               = $hasDifferences
        'Suggested Migration Strategy'  = Get-SuggestedStrategy -Status $status -ObjectType $objectType -ObjectID $objectID -HasDotNetOrCom $hasDotNetOrCom
        'Risk Level'                    = Get-RiskLevel -Status $status -ObjectType $objectType -HasDotNetOrCom $hasDotNetOrCom
        'Notes'                         = $notes
    })
}

if ($DryRun) {
    Write-Host 'Modo DryRun activo. No se escriben archivos.'
    $rows | Select-Object -First 20 | Format-Table
    return
}

$outputCsvDir = Split-Path -Path $OutputCsv -Parent
if ($outputCsvDir -and -not (Test-Path -LiteralPath $outputCsvDir)) {
    New-Item -ItemType Directory -Path $outputCsvDir -Force | Out-Null
}

$outputMdDir = Split-Path -Path $OutputMarkdown -Parent
if ($outputMdDir -and -not (Test-Path -LiteralPath $outputMdDir)) {
    New-Item -ItemType Directory -Path $outputMdDir -Force | Out-Null
}

$rows | Sort-Object 'Object Type', 'Object ID' | Export-Csv -LiteralPath $OutputCsv -NoTypeInformation -Encoding UTF8

$mdLines = @(
    '# Inventario diferencial NAV 2016 estándar vs cliente'
    ''
    "> Generado: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    ''
) + (ConvertTo-MarkdownTable -Rows ($rows | Sort-Object 'Object Type', 'Object ID'))

Set-Content -LiteralPath $OutputMarkdown -Value $mdLines -Encoding UTF8

Write-Host "CSV generado: $OutputCsv"
Write-Host "Markdown generado: $OutputMarkdown"
Write-Host "Total de filas: $($rows.Count)"

