# Inventario de Objetos NAV 2016

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Responsable:** [COMPLETAR]

---

## Propósito

Este documento cataloga todos los objetos existentes en la base de datos de Microsoft Dynamics NAV 2016, diferenciando entre objetos estándar de Microsoft y objetos personalizados. Es la base para estimar el esfuerzo de conversión a AL y planificar las fases de desarrollo.

**Referencia oficial:** [AL Object Types](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-al-object-types)

---

## Query SQL para Extracción del Inventario

Ejecutar la siguiente consulta en la base de datos NAV 2016 para obtener el inventario completo:

```sql
-- Inventario completo de objetos NAV 2016 con clasificación
SELECT 
    o.[Type]                         AS TipoObjeto,
    o.[ID]                           AS NumeroObjeto,
    o.[Name]                         AS NombreObjeto,
    o.[Modified]                     AS ModificadoPorCliente,
    o.[Date]                         AS FechaUltimaModificacion,
    o.[Time]                         AS HoraUltimaModificacion,
    o.[Version List]                 AS ListaVersiones,
    o.[No. of Lines]                 AS NumeroLineas,
    CASE 
        WHEN o.[Modified] = 1 THEN 'PERSONALIZADO'
        WHEN o.[ID] >= 50000 AND o.[ID] < 100000 THEN 'CUSTOM (50000-99999)'
        WHEN o.[ID] >= 100000 THEN 'PARTNER/ISV'
        ELSE 'ESTANDAR'
    END                              AS Clasificacion
FROM 
    [dbo].[Object] o
WHERE 
    o.[Type] IN (1,2,3,4,5,6,7,8,9,11)  -- Table, Report, Codeunit, XMLPort, MenuSuite, Page, Query, System, FieldGroups, TableExtension
ORDER BY 
    o.[Type], o.[ID];

-- Resumen por tipo
SELECT 
    o.[Type] AS TipoObjeto,
    COUNT(*) AS Total,
    SUM(CASE WHEN o.[Modified] = 1 THEN 1 ELSE 0 END) AS Modificados,
    SUM(CASE WHEN o.[ID] >= 50000 THEN 1 ELSE 0 END) AS Customizados
FROM [dbo].[Object] o
GROUP BY o.[Type]
ORDER BY o.[Type];
```

---

## Resumen por Tipo de Objeto

| Tipo Objeto | Código NAV | Total Estándar | Total Custom | Total Modificados | Total General |
|------------|-----------|---------------|-------------|------------------|--------------|
| Table | 1 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| Report | 3 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| Codeunit | 5 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| XMLPort | 6 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| MenuSuite | 7 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| Page | 8 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| Query | 9 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| **TOTAL** | | **[COMPLETAR]** | **[COMPLETAR]** | **[COMPLETAR]** | **[COMPLETAR]** |

---

## Clasificación de Objetos para Migración

### Leyenda de Estrategia de Migración

| Código | Estrategia | Descripción |
|--------|-----------|-------------|
| 🔄 **CONV** | Convertir a AL | El objeto C/AL debe reescribirse como extensión AL |
| ✅ **STD** | Usar estándar BC | La funcionalidad existe de forma nativa en BC, no requiere conversión |
| ❌ **ELIM** | Eliminar | El objeto es obsoleto o no tiene uso actual; se descarta |
| 🔁 **REEM** | Reemplazar | Existe una alternativa mejor en BC (ej: reemplazar XMLPort por API) |
| 📦 **ISV** | ISV/AppSource | La funcionalidad viene de una app de AppSource disponible para BC |
| 🔗 **INTG** | Integración | Implementar como integración externa (Power Automate, Azure) |

---

## Detalle de Objetos Personalizados (Custom Objects 50000-99999)

### Tablas (Table)

| ID | Nombre | Descripción Funcional | Módulo | Estrategia | Prioridad | Complejidad | Notas |
|----|--------|----------------------|--------|-----------|-----------|-------------|-------|
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | CONV | Alta | Media | [COMPLETAR] |
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | CONV | Alta | Alta | [COMPLETAR] |

### Páginas (Page)

| ID | Nombre | Descripción Funcional | Módulo | Estrategia | Prioridad | Complejidad | Notas |
|----|--------|----------------------|--------|-----------|-----------|-------------|-------|
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | CONV | Alta | Baja | [COMPLETAR] |

### Codeunits

| ID | Nombre | Descripción Funcional | Módulo | Estrategia | Prioridad | Complejidad | Notas |
|----|--------|----------------------|--------|-----------|-----------|-------------|-------|
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | CONV | Alta | Alta | [COMPLETAR] |

### Reportes (Report)

| ID | Nombre | Descripción Funcional | Módulo | Estrategia | Prioridad | Complejidad | Notas |
|----|--------|----------------------|--------|-----------|-----------|-------------|-------|
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | CONV | Media | Media | [COMPLETAR] |

---

## Objetos Estándar Modificados

Los siguientes objetos estándar de Microsoft han sido modificados en NAV 2016 mediante código C/AL y deben ser convertidos a extensiones AL (TableExtension, PageExtension, etc.):

| ID | Nombre | Tipo | Descripción de la Modificación | Estrategia AL | Prioridad |
|----|--------|------|-------------------------------|--------------|-----------|
| [COMPLETAR] | Customer | Table | [COMPLETAR - campos custom añadidos] | TableExtension | Alta |
| [COMPLETAR] | Item | Table | [COMPLETAR - campos custom añadidos] | TableExtension | Alta |
| [COMPLETAR] | Sales Header | Table | [COMPLETAR - campos custom añadidos] | TableExtension | Alta |
| [COMPLETAR] | Customer Card | Page | [COMPLETAR - controles añadidos] | PageExtension | Alta |
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |

---

## Resumen Ejecutivo del Esfuerzo de Conversión

| Categoría | Objetos | Horas estimadas | Semanas dev (1 dev) |
|-----------|---------|----------------|---------------------|
| Tablas custom + TableExtensions | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| Páginas custom + PageExtensions | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| Codeunits | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| Reportes | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| XMLPorts / APIs | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| **TOTAL** | **[COMPLETAR]** | **[COMPLETAR]** | **[COMPLETAR]** |

*Estimación con factor de complejidad incluido. Agregar 20-30% de buffer para imprevistos.*

---

## Inventario diferencial generado automáticamente

> Esta sección se alimenta desde `upgrade-project/01-assessment/tools/generate-object-inventory.ps1` usando el CSV generado por `compare-nav-objects.ps1`.
>
> Objetivo: baseline técnico inicial estándar NAV 2016 vs cliente NAV 2016.  
> No sustituye revisión funcional/arquitectónica.

| Campo | Valor |
|---|---|
| Fuente esperada | `upgrade-project/01-assessment/tools/output/differential-inventory.csv` |
| Estado | Pendiente de generación con datos reales del cliente |
| Revisión obligatoria | Arquitecto NAV/BC + consultor funcional |
