# Arquitectura de Extensiones AL

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Responsable:** Líder Técnico AL

---

## 1. Propósito

Definir la estructura de extensiones AL para la Per-Tenant Extension (PTE) del proyecto, incluyendo la organización de carpetas, namespaces, convenciones de nomenclatura y patrones de diseño que garanticen mantenibilidad y compatibilidad con las actualizaciones automáticas de BC SaaS.

**Referencia:** [AL Extension Architecture](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-extension-architecture)

---

## 2. Estructura de la Extensión AL

```
[COMPLETAR-NombreExtension]/
├── app.json                    # Manifiesto de la extensión
├── .alpackages/                # Dependencias descargadas (BC symbols)
├── .vscode/
│   └── launch.json             # Configuración de publicación
├── src/
│   ├── table/                  # Nuevas tablas y extensiones de tabla
│   │   ├── Tab50100.[COMPLETAR].al
│   │   └── TabExt[COMPLETAR].CustomerExt.al
│   ├── page/                   # Nuevas páginas y extensiones de página
│   │   ├── Pag50100.[COMPLETAR].al
│   │   └── PagExt[COMPLETAR].CustomerCardExt.al
│   ├── codeunit/               # Codeunits de lógica de negocio
│   │   ├── Cod50100.[COMPLETAR].al
│   │   └── Cod50101.[COMPLETAR]Mgt.al
│   ├── report/                 # Reportes y layouts
│   │   ├── Rep50100.[COMPLETAR].al
│   │   └── Rep50100.[COMPLETAR].rdlc
│   ├── enum/                   # Enumeraciones
│   │   └── Enu50100.[COMPLETAR].al
│   ├── interface/              # Interfaces (si aplica)
│   ├── xmlport/                # XMLPorts y APIs
│   │   ├── Xml50100.[COMPLETAR].al
│   │   └── Pag50200.[COMPLETAR]API.al
│   ├── query/                  # Queries para reporting
│   │   └── Que50100.[COMPLETAR].al
│   ├── permissionset/          # Permission sets
│   │   └── Per50100.[COMPLETAR]PermSet.al
│   └── translation/            # Archivos de traducción (si aplica)
│       └── [COMPLETAR].es-ES.xlf
├── test/                       # Tests automatizados
│   └── Cod[COMPLETAR].Tests.al
└── README.md
```

---

## 3. Fichero app.json

```json
{
  "id": "[COMPLETAR - GUID único generado para la extensión]",
  "name": "[COMPLETAR - Nombre comercial de la extensión]",
  "publisher": "[COMPLETAR - Nombre de la empresa partner]",
  "version": "1.0.0.0",
  "brief": "[COMPLETAR - Descripción breve]",
  "description": "Per-Tenant Extension para [COMPLETAR - nombre cliente] - Upgrade desde NAV 2016",
  "privacyStatement": "",
  "EULA": "",
  "help": "",
  "url": "",
  "logo": "logo.png",
  "dependencies": [
    {
      "id": "63ca2fa4-4f03-4f2b-a480-172fef340d3f",
      "publisher": "Microsoft",
      "name": "System Application",
      "version": "22.0.0.0"
    },
    {
      "id": "437dbf0e-84ff-417a-965d-ed2bb9650972",
      "publisher": "Microsoft",
      "name": "Base Application",
      "version": "22.0.0.0"
    }
  ],
  "screenshots": [],
  "platform": "22.0.0.0",
  "application": "22.0.0.0",
  "idRanges": [
    {
      "from": 50100,
      "to": 50999
    }
  ],
  "resourceExposurePolicy": {
    "allowDebugging": true,
    "allowDownloadingSource": false,
    "includeSourceInSymbolFile": false
  },
  "runtime": "12.0",
  "target": "Cloud",
  "features": ["TranslationFile", "NoImplicitWith"]
}
```

---

## 4. Convenciones de Nomenclatura

### Nombres de Objetos AL

| Tipo de Objeto | Prefijo | Ejemplo |
|---------------|---------|---------|
| Table | `[COMPLETAR - Prefijo empresa]` | `[PREFIX] Customer Extra Data` |
| Table Extension | `[COMPLETAR]` | `[PREFIX] Customer Ext` |
| Page | `[COMPLETAR]` | `[PREFIX] Customer Extra Data` |
| Page Extension | `[COMPLETAR]` | `[PREFIX] Customer Card Ext` |
| Codeunit | `[COMPLETAR]` | `[PREFIX] Sales Management` |
| Report | `[COMPLETAR]` | `[PREFIX] Sales Summary` |
| Enum | `[COMPLETAR]` | `[PREFIX] Customer Type` |
| Interface | `[COMPLETAR]` | `I[PREFIX] Processor` |
| API Page | `[COMPLETAR]` | `[PREFIX] Customer API` |

> ⚠️ **Nunca** usar el prefijo `MS` (reservado para Microsoft). Acordar un prefijo de 2-4 letras con el cliente y registrarlo en Microsoft: [Prefix/Suffix Registration](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-prefix-suffix-app-name)

### Rangos de IDs

| Rango | Uso |
|-------|-----|
| 50100 - 50199 | Tablas nuevas |
| 50200 - 50299 | Páginas nuevas y APIs |
| 50300 - 50399 | Codeunits |
| 50400 - 50499 | Reportes |
| 50500 - 50599 | XMLPorts y Queries |
| 50600 - 50699 | Enums y otras extensiones |
| 50700 - 50799 | Permission Sets |
| 50800 - 50999 | Reservado para crecimiento |

---

## 5. Patrones de Diseño AL Recomendados

### 5.1 Event-Driven: Publisher/Subscriber

En lugar de modificar codeunits estándar, usar suscripción a eventos:

```al
// ✅ CORRECTO: Suscriptor de evento en extensión
codeunit 50300 "[PREFIX] Sales Subscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 
                     'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforeSalesPost(var SalesHeader: Record "Sales Header"; 
                                       CommitIsSuppressed: Boolean)
    begin
        // Lógica de negocio del cliente aquí
        ValidateCustomerCategory(SalesHeader);
    end;
}
```

### 5.2 TableExtension para Campos Adicionales

```al
// ✅ CORRECTO: Añadir campos a tabla estándar
tableextension 50100 "[PREFIX] Customer Ext" extends Customer
{
    fields
    {
        field(50100; "[PREFIX] Customer Category"; Enum "[PREFIX] Customer Type")
        {
            Caption = 'Customer Category';
            DataClassification = CustomerContent;
        }
    }
}
```

### 5.3 API Pages para Integraciones

```al
page 50200 "[PREFIX] Customer API"
{
    PageType = API;
    APIPublisher = '[COMPLETAR]';
    APIGroup = 'customers';
    APIVersion = 'v1.0';
    EntityName = 'customCustomer';
    EntitySetName = 'customCustomers';
    SourceTable = Customer;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(Customers)
            {
                field(id; Rec.SystemId) { }
                field(number; Rec."No.") { }
                field(displayName; Rec.Name) { }
            }
        }
    }
}
```

---

## 6. Gestión de Compatibilidad con Actualizaciones BC

- Suscribirse a los [BC Release Plans](https://learn.microsoft.com/es-es/dynamics365/release-plans/) para anticipar breaking changes
- Nunca acceder a objetos internos de la Base Application no publicados como API
- Usar `ObsoleteState` y `ObsoleteReason` para marcar código en proceso de deprecación
- Mantener la extensión en sandbox actualizado para detectar incompatibilidades anticipadamente
- Revisar los [Upgrade Compatibility Guidelines](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-break-changes) antes de cada major release

---

*Referencia: [AL Development Best Practices](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-al-best-practices)*
