# Herramientas de assessment NAV 2016 (baseline diferencial)

Este directorio contiene utilidades PowerShell para generar un baseline técnico real de upgrade NAV 2016 → Business Central SaaS, comparando exportaciones TXT de objetos estándar vs cliente.

> **Importante:** estas herramientas **no convierten a AL**. Solo generan inventario diferencial para revisión por arquitecto NAV/BC.

## Propósito

Permitir una primera clasificación operativa para responder:

1. Qué objetos nuevos tiene el cliente.
2. Qué objetos estándar están modificados.
3. Qué cambios parecen sencillos.
4. Qué cambios son de alto riesgo.
5. Qué objetos deben ir a AL.
6. Qué objetos deben rediseñarse.
7. Qué objetos probablemente no deben migrarse.

## Estructura esperada de entrada

- Export TXT NAV estándar (ejemplo): `NAV2016_STD_AllObjects.txt`
- Export TXT NAV cliente (ejemplo): `NAV2016_CUSTOMER_AllObjects.txt`

Los scripts detectan como mínimo estos tipos de objeto:

- Table
- Report
- Codeunit
- XMLport
- MenuSuite
- Page
- Query

## Flujo recomendado paso a paso

Desde la raíz del repositorio:

```powershell
# 1) Separar objetos estándar
.\upgrade-project\01-assessment\tools\split-nav-objects.ps1 `
  -InputFile .\upgrade-project\01-assessment\tools\sample-input\NAV2016_STD_AllObjects.txt `
  -OutputRoot .\upgrade-project\01-assessment\tools\output `
  -Dataset standard

# 2) Separar objetos cliente
.\upgrade-project\01-assessment\tools\split-nav-objects.ps1 `
  -InputFile .\upgrade-project\01-assessment\tools\sample-input\NAV2016_CUSTOMER_AllObjects.txt `
  -OutputRoot .\upgrade-project\01-assessment\tools\output `
  -Dataset customer

# 3) Comparar objetos separados y generar baseline CSV+Markdown
.\upgrade-project\01-assessment\tools\compare-nav-objects.ps1 `
  -StandardPath .\upgrade-project\01-assessment\tools\output\standard `
  -CustomerPath .\upgrade-project\01-assessment\tools\output\customer `
  -OutputCsv .\upgrade-project\01-assessment\tools\output\differential-inventory.csv `
  -OutputMarkdown .\upgrade-project\01-assessment\tools\output\differential-inventory.md

# 4) Actualizar sección automática en NAV2016-OBJECT-INVENTORY.md
.\upgrade-project\01-assessment\tools\generate-object-inventory.ps1 `
  -InputCsv .\upgrade-project\01-assessment\tools\output\differential-inventory.csv `
  -InventoryFile .\upgrade-project\01-assessment\NAV2016-OBJECT-INVENTORY.md
```

## Modo seguro / simulación

- `split-nav-objects.ps1` y `generate-object-inventory.ps1` soportan `-WhatIf`.
- `compare-nav-objects.ps1` y `generate-object-inventory.ps1` soportan `-DryRun`.

## Archivos generados

- `output/standard/*.txt` y `output/customer/*.txt` (objetos separados)
- `output/differential-inventory.csv`
- `output/differential-inventory.md`
- Sección `## Inventario diferencial generado automáticamente` dentro de:
  - `upgrade-project/01-assessment/NAV2016-OBJECT-INVENTORY.md`

## Limitaciones conocidas

- El parser se basa en cabeceras `OBJECT <Type> <ID> <Name>` del TXT exportado.
- La comparación es textual por hash de archivo, no semántica por bloques C/AL.
- La detección de `DotNet/Automation/COM` es por patrón textual.
- La estrategia y riesgo son una clasificación inicial; no reemplazan análisis funcional/técnico.

## Siguiente paso manual obligatorio

Revisar el baseline generado con arquitecto NAV/BC (funcional + técnico) antes de estimar esfuerzo o iniciar conversión AL.

