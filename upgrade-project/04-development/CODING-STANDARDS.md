# Estándares de Código AL

> **Versión:** 1.0 | **Responsable:** Líder Técnico

## Convenciones Generales
- Prefijo de objetos: `[PREFIX]` (acordar con cliente y registrar en Microsoft)
- Indentación: 4 espacios (no tabs)
- Codificación: UTF-8
- Feature `NoImplicitWith` activada en app.json

## Nombrado
| Elemento | Estilo | Ejemplo |
|----------|--------|---------|
| Variables locales | camelCase | `salesAmount` |
| Procedimientos | PascalCase | `CalculateSalesAmount()` |
| Campos de tabla | PascalCase con comillas | `"[PREFIX] Category"` |
| Labels | PascalCase + sufijo Lbl/Msg/Err/Qst | `ErrorCategoryLbl` |

## Reglas Obligatorias
- `DataClassification` en todos los campos custom
- `ApplicationArea` y `ToolTip` en todos los controles de página
- `Caption` en todos los objetos y campos
- Sin contraseñas, tokens ni secretos en código

## Gestión de Errores
```al
// ✅ CORRECTO
var ErrorMsg: Label 'No se puede procesar %1: %2';
begin
    if not IsValid then
        Error(ErrorMsg, RecordId, GetLastErrorText());
end;
```

**Referencia:** [AL Coding Guidelines](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-al-coding-guidelines)
