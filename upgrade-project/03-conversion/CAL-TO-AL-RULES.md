# Reglas de Conversión C/AL → AL

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Responsable:** Líder Técnico AL

---

## 1. Propósito

Guía de referencia completa para la conversión del código C/AL de NAV 2016 al lenguaje AL moderno de Business Central. Incluye ejemplos lado a lado (before/after) para los patrones más comunes.

**Referencia oficial:** [Conversion from C/AL to AL](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-cal-to-al-migration)

---

## 2. Diferencias Fundamentales

| Concepto | C/AL (NAV 2016) | AL (BC SaaS) |
|---------|----------------|-------------|
| **Modificación de objetos** | Modificar objeto base directamente | Solo mediante extensiones (TableExtension, PageExtension, etc.) |
| **Triggers de tabla** | `OnInsert`, `OnModify` en la tabla | EventSubscribers en Publisher/Subscriber pattern |
| **Variables globales** | Variables globales en objeto | No hay variables globales entre objetos; usar SetupRecord o singleton |
| **Implicit WITH** | `WITH Rec DO` implícito en páginas | Prohibido; siempre usar `Rec.` como prefijo |
| **Enumeraciones** | `OPTION` fields | `Enum` objects con `ExtendableEnum` |
| **DotNet** | `DotNet` variables directas | Solo en on-premise; en SaaS usar Azure Functions |
| **FORM/PAGE** | `FORM` type | Solo `PAGE` type |

---

## 3. Patrones de Conversión con Ejemplos

### 3.1 Variables y Tipos de Datos

**C/AL (NAV 2016):**
```cal
VAR
  CustomerName : Text[50];
  Amount       : Decimal;
  PostingDate  : Date;
  CustRec      : Record 18;  // Customer by number
  TextConst    : TextConst ENU='Error message';
```

**AL (BC SaaS):**
```al
var
    CustomerName: Text[50];
    Amount: Decimal;
    PostingDate: Date;
    CustRec: Record Customer;  // By name
    ErrorLbl: Label 'Error message', MaxLength = 250;
```

---

### 3.2 Declaración de Tabla

**C/AL (NAV 2016):**
```cal
OBJECT Table 50100 Customer Category
{
  FIELDS
  {
    { 1; ;Code;Code[10]; }
    { 2; ;Description;Text[50]; }
  }
  KEYS
  {
    { ;Code; Clustered=Yes; }
  }
}
```

**AL (BC SaaS):**
```al
table 50100 "[PREFIX] Customer Category"
{
    Caption = 'Customer Category';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; Code) { Clustered = true; }
    }
}
```

---

### 3.3 Extensión de Tabla Estándar (en lugar de modificar)

**C/AL (NAV 2016) - MODIFICACIÓN DIRECTA:**
```cal
OBJECT Table 18 Customer
{
  FIELDS
  {
    // ... campos estándar ...
    { 50100; ;[PREFIX] Category;Code[10]; TableRelation=Table 50100; }
  }
}
```

**AL (BC SaaS) - TABLE EXTENSION:**
```al
tableextension 50100 "[PREFIX] Customer Ext" extends Customer
{
    fields
    {
        field(50100; "[PREFIX] Category"; Code[10])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
            TableRelation = "[PREFIX] Customer Category";
        }
    }
}
```

---

### 3.4 PageExtension en lugar de modificar página

**C/AL (NAV 2016) - MODIFICACIÓN DIRECTA:**
```cal
OBJECT Page 21 Customer Card
{
  // ... controles estándar más controles custom ...
  CONTROLS
  {
    { 50100;;Field;SourceExpr="[PREFIX] Category"; }
  }
}
```

**AL (BC SaaS) - PAGE EXTENSION:**
```al
pageextension 50100 "[PREFIX] Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addafter(Name)
        {
            field("[PREFIX] Category"; Rec."[PREFIX] Category")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the customer category.';
            }
        }
    }
    actions
    {
        addafter(NewSalesQuote)
        {
            action("[PREFIX] CategoryAction")
            {
                Caption = 'Category Details';
                ApplicationArea = All;
                Image = Category;
                trigger OnAction()
                begin
                    // Lógica de acción
                end;
            }
        }
    }
}
```

---

### 3.5 EventSubscribers (en lugar de modificar triggers)

**C/AL (NAV 2016) - MODIFICAR TRIGGER DIRECTO:**
```cal
OBJECT Codeunit 80 Sales-Post
{
  OnRun()
  BEGIN
    // ... código estándar ...
    // Código custom mezclado:
    ValidateCustomerCategory(SalesHeader);
    // ... más código estándar ...
  END;
}
```

**AL (BC SaaS) - EVENT SUBSCRIBER:**
```al
codeunit 50300 "[PREFIX] Sales Subscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 
                     'OnBeforePostSalesDoc', '', false, false)]
    local procedure ValidateCategoryOnBeforePost(
        var SalesHeader: Record "Sales Header"; 
        CommitIsSuppressed: Boolean)
    begin
        ValidateCustomerCategory(SalesHeader);
    end;

    local procedure ValidateCustomerCategory(var SalesHeader: Record "Sales Header")
    begin
        // Lógica de validación
        if SalesHeader."[PREFIX] Category" = '' then
            Error('El cliente %1 debe tener una categoría asignada.', SalesHeader."Sell-to Customer No.");
    end;
}
```

---

### 3.6 OPTION Fields → Enum

**C/AL (NAV 2016):**
```cal
{ 50110; ;Customer Type;Option; OptionString=Standard,Premium,VIP; }
```

**AL (BC SaaS):**
```al
// Enum object separado
enum 50100 "[PREFIX] Customer Type"
{
    Extensible = true;
    value(0; Standard) { Caption = 'Standard'; }
    value(1; Premium)  { Caption = 'Premium'; }
    value(2; VIP)      { Caption = 'VIP'; }
}

// En la tabla:
field(50110; "[PREFIX] Customer Type"; Enum "[PREFIX] Customer Type")
{
    DataClassification = CustomerContent;
    Caption = 'Customer Type';
}
```

---

### 3.7 MessageBox / Dialog

**C/AL (NAV 2016):**
```cal
IF CONFIRM('Are you sure?', TRUE) THEN BEGIN
  MESSAGE('Done!');
END;
ERROR('Something went wrong: %1', ErrorText);
```

**AL (BC SaaS):**
```al
if Dialog.Confirm('Are you sure?', true) then begin
    Message('Done!');
end;
Error('Something went wrong: %1', ErrorText);

// O usando etiquetas (recomendado):
var
    ConfirmQst: Label 'Are you sure?';
    DoneMsg: Label 'Done!';
    ErrorMsg: Label 'Something went wrong: %1';
begin
    if Dialog.Confirm(ConfirmQst, true) then
        Message(DoneMsg);
end;
```

---

### 3.8 SETRANGE / SETFILTER

**C/AL y AL (sintaxis idéntica pero con Rec. prefix en AL):**
```al
// AL - siempre usar Rec. en contexto de página/tabla
Rec.SetRange("Document Type", Rec."Document Type"::Invoice);
Rec.SetFilter(Amount, '>%1', 0);
if Rec.FindFirst() then
    // ...

// En variables locales: igual que antes
CustRec.SetRange("No.", '10000', '20000');
CustRec.SetLoadFields(Name, "Credit Limit (LCY)");  // ✅ Performance: solo cargar campos necesarios
if CustRec.FindSet() then
    repeat
        // procesar
    until CustRec.Next() = 0;
```

---

### 3.9 Implicit WITH → Explícito

**C/AL (NAV 2016) - IMPLÍCITO (permitido):**
```cal
// En una página con SourceTable=Customer, WITH es implícito:
Name := 'Test';  // Asigna a campo Name de Customer
```

**AL (BC SaaS) - SIEMPRE EXPLÍCITO:**
```al
// Siempre usar Rec. (NoImplicitWith feature activada)
Rec.Name := 'Test';
Rec.Modify(true);

// En variables locales:
CustRec.Name := 'Test';
CustRec.Modify(true);
```

---

## 4. Patrones Prohibidos en BC SaaS

| Patrón C/AL | Razón prohibida | Alternativa AL |
|------------|----------------|----------------|
| `DotNet` interop en runtime | No permitido en SaaS | Azure Functions |
| `File.Open`, `File.Read` | Sin acceso a filesystem | Azure Blob, `DownloadFromStream` |
| `SHELL` | Sin acceso a SO | Azure Functions |
| `DLL` references en Codeunit | Sin acceso a disco | Azure Functions |
| Acceso a SQL directo | Sin acceso a BD | AL Queries, OData |
| `NAS` Background tasks | No existe en SaaS | Job Queue Entries |
| `HYPERLINK` con file:// | Sin acceso local | HTTPS links solo |
| `ActiveX`/`COM` controls | No permitido | JavaScript Control Add-ins |

---

## 5. Checklist de Conversión por Objeto

Para cada objeto a convertir, verificar:

- [ ] Variables renombradas con casing correcto (PascalCase)
- [ ] `WITH` implícito eliminado; reemplazado por `Rec.` o variable explícita
- [ ] `OPTION` fields convertidos a `Enum`
- [ ] Modificaciones directas a objetos base convertidas a extensiones
- [ ] Triggers de tabla convertidos a EventSubscribers donde aplique
- [ ] `TextConst` convertidos a `Label`
- [ ] DotNet/COM eliminados y reemplazados por alternativa cloud
- [ ] `DataClassification` declarado en todos los campos custom
- [ ] `ApplicationArea` declarado en todos los controles de página
- [ ] `ToolTip` declarado en todos los controles de página
- [ ] Código compilado sin errores ni warnings en VS Code + AL extension
- [ ] Código publicado y probado en sandbox BC

---

*Referencia: [AL Language Reference](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-al-language-reference)*

---

## Reglas de clasificación baseline (sin conversión AL)

Previo a convertir, usar el baseline diferencial para decidir estrategia:

| Caso detectado | Estrategia sugerida |
|---|---|
| Objeto ID >= 50000 y solo en cliente | Convertir/Revisar como objeto AL nuevo |
| Tabla estándar modificada | TableExtension / revisar triggers |
| Página estándar modificada | PageExtension |
| Codeunit estándar modificada | Rediseño mediante eventos |
| Report estándar modificado | ReportExtension o report nuevo |
| XMLport | Revisar si sigue como XMLport o se sustituye por API |
| MenuSuite | No migrar directamente; rediseñar navegación |
| DotNet / Automation detectado | Bloqueo SaaS; requiere rediseño |

> Estas reglas son iniciales para assessment. La decisión final se valida con análisis funcional y técnico.
