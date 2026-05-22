# Migración de Reportes NAV 2016 → Business Central

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Responsable:** Líder Técnico

---

## Propósito

Documentar la estrategia y el proceso de migración de reportes NAV 2016 (RDLC/C/AL) a Business Central SaaS, incluyendo los cambios en el modelo de datos, los layouts disponibles y las herramientas de conversión.

**Referencia:** [BC Reports Overview](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-reports)

---

## 1. Tipos de Layout en BC SaaS

| Tipo de Layout | Herramienta de diseño | Mejor para | Disponible en |
|---------------|----------------------|-----------|--------------|
| **RDLC** | Visual Studio + Report Builder | Reportes complejos con múltiples secciones, logos, tablas | BC SaaS ✅ |
| **Word** | Microsoft Word | Documentos de texto: facturas, albaranes, cartas | BC SaaS ✅ |
| **Excel** | Microsoft Excel | Reportes de análisis de datos, exportaciones | BC SaaS ✅ |
| **External (PDF, etc.)** | Herramientas externas | Via Azure / Power BI | BC SaaS ✅ |

---

## 2. Cambios en el Modelo de Datos de Reportes

### Variables de Dataset

**C/AL (NAV 2016):**
```cal
REPORT 50100 "Sales Summary"
{
  DATASET
  {
    DATAITEM(Customer;18)
    {
      COLUMN(CustomerNo;No.) { }
      COLUMN(CustomerName;Name) { }
    }
  }
}
```

**AL (BC SaaS):**
```al
report 50100 "[PREFIX] Sales Summary"
{
    Caption = 'Sales Summary';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/report/Rep50100.SalesSummary.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(CustomerNo; "No.") { }
            column(CustomerName; Name) { }
            
            trigger OnAfterGetRecord()
            begin
                // Lógica de filtrado adicional si necesario
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(ShowDetails; ShowDetailsBool)
                    {
                        Caption = 'Show Details';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        ShowDetailsBool: Boolean;
}
```

---

## 3. Inventario de Reportes a Migrar

### Reportes Custom (>50000)

| ID | Nombre | Layout Actual | Módulo | Complejidad | Layout BC | Desarrollador | Estado |
|----|--------|--------------|--------|------------|----------|-------------|--------|
| [COMPLETAR] | [COMPLETAR] | RDLC | [COMPLETAR] | [Alta/Media/Baja] | RDLC | [COMPLETAR] | ⬜ |
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | ⬜ |

### Reportes Estándar Modificados

| ID | Nombre Estándar | Modificaciones | Estrategia BC | Desarrollador | Estado |
|----|----------------|---------------|--------------|-------------|--------|
| [COMPLETAR] | [COMPLETAR] | [Campos añadidos, nueva sección] | ReportExtension + Layout override | [COMPLETAR] | ⬜ |

---

## 4. Proceso de Conversión de Layouts RDLC

1. **Exportar layout RDLC** desde NAV 2016 (Reporte → Design → Export Layout)
2. **Adaptar dataset columns** para que coincidan con los nombres en AL
3. **Actualizar referencias** de campos: los nombres de columna del dataset cambian según AL
4. **Probar layout** en BC SaaS sandbox con datos reales
5. **Ajustar parámetros** de RequestPage si aplica
6. **Validar output** con usuario clave del módulo correspondiente

### Herramientas

- **Visual Studio 2019/2022** con SQL Server Reporting Services Tools (para RDLC)
- **Report Builder** (Microsoft, gratuito) - más ligero que VS
- **BC Sandbox** para pruebas de layout

---

## 5. Reportes de Documentos (Facturas, Albaranes, etc.)

Los reportes de documentos oficiales (facturas, albaranes, notas de crédito) se recomienda migrar a **Word Layout** para facilitar la personalización de marca:

| Documento | Reporte Estándar BC | Layout recomendado | Personalización cliente |
|-----------|--------------------|--------------------|------------------------|
| Factura de venta | 1306 Sales - Invoice | Word | Logo, datos fiscales, campos custom |
| Albarán de venta | 208 Sales - Shipment | Word | [COMPLETAR] |
| Factura de compra | 406 Purchase - Invoice | Word | [COMPLETAR] |
| Abono de venta | 1307 Sales - Credit Memo | Word | [COMPLETAR] |
| Pedido de compra | 405 Purchase - Order | Word | [COMPLETAR] |

---

## 6. ReportExtension (nueva funcionalidad BC)

Para modificar reportes estándar sin reemplazar el report completo:

```al
reportextension 50100 "[PREFIX] Sales Invoice Ext" extends "Standard Sales - Invoice"
{
    dataset
    {
        add(Header)
        {
            column(CustomField; Rec."[PREFIX] Custom Field") { }
        }
    }
    // Modificar el layout para incluir el nuevo campo
    RDLCLayout = 'src/report/Rep50100.SalesInvoiceExt.rdlc';
}
```

---

*Referencia: [Report Layout Overview](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-report-layout-overview)*
