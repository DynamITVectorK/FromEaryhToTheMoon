[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)]
    [string]$InputFile,

    [Parameter(Mandatory = $true)]
    [string]$OutputRoot,

    [Parameter(Mandatory = $true)]
    [ValidateSet('standard', 'customer')]
    [string]$Dataset
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-TypeCode {
    param([Parameter(Mandatory = $true)][string]$ObjectType)

    $map = @{
        'Table'     = 'TAB'
        'Report'    = 'REP'
        'Codeunit'  = 'COD'
        'XMLport'   = 'XML'
        'MenuSuite' = 'MEN'
        'Page'      = 'PAG'
        'Query'     = 'QUE'
    }

    if ($map.ContainsKey($ObjectType)) {
        return $map[$ObjectType]
    }

    return 'OBJ'
}

function Get-SafeFileNamePart {
    param([Parameter(Mandatory = $true)][string]$Name)

    $safe = $Name.Trim()
    $safe = $safe -replace '[\\/:*?"<>|]', '_'
    $safe = $safe -replace '\s+', '-'
    return $safe
}

if (-not (Test-Path -LiteralPath $InputFile -PathType Leaf)) {
    throw "No existe el archivo de entrada: $InputFile"
}

if (-not (Test-Path -LiteralPath $OutputRoot)) {
    if ($PSCmdlet.ShouldProcess($OutputRoot, 'Crear carpeta de salida raíz')) {
        New-Item -ItemType Directory -Path $OutputRoot -Force | Out-Null
    }
}

$datasetFolder = Join-Path -Path $OutputRoot -ChildPath $Dataset
if (-not (Test-Path -LiteralPath $datasetFolder)) {
    if ($PSCmdlet.ShouldProcess($datasetFolder, "Crear carpeta para dataset '$Dataset'")) {
        New-Item -ItemType Directory -Path $datasetFolder -Force | Out-Null
    }
}

Write-Host "Leyendo archivo NAV TXT: $InputFile"
$lines = Get-Content -LiteralPath $InputFile

$objects = New-Object System.Collections.Generic.List[object]
$currentObject = $null

foreach ($line in $lines) {
    if ($line -match '^\s*OBJECT\s+(Table|Report|Codeunit|XMLport|MenuSuite|Page|Query)\s+(\d+)\s+(.+?)\s*$') {
        if ($null -ne $currentObject) {
            $objects.Add($currentObject)
        }

        $currentObject = [PSCustomObject]@{
            Type  = $matches[1]
            Id    = [int]$matches[2]
            Name  = $matches[3].Trim()
            Lines = New-Object System.Collections.Generic.List[string]
        }
    }

    if ($null -ne $currentObject) {
        $currentObject.Lines.Add($line)
    }
}

if ($null -ne $currentObject) {
    $objects.Add($currentObject)
}

if ($objects.Count -eq 0) {
    Write-Warning "No se encontraron objetos reconocibles en el archivo: $InputFile"
    return
}

Write-Host "Objetos detectados: $($objects.Count)"

foreach ($obj in $objects) {
    $typeCode = Get-TypeCode -ObjectType $obj.Type
    $safeName = Get-SafeFileNamePart -Name $obj.Name
    $fileName = '{0}{1}_{2}.txt' -f $typeCode, $obj.Id, $safeName
    $targetPath = Join-Path -Path $datasetFolder -ChildPath $fileName

    if ($PSCmdlet.ShouldProcess($targetPath, "Escribir objeto $($obj.Type) $($obj.Id)")) {
        Set-Content -LiteralPath $targetPath -Value $obj.Lines -Encoding UTF8
    }
}

Write-Host "Separación completada. Salida: $datasetFolder"

