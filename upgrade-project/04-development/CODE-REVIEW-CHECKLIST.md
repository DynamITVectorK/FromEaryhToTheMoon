# Checklist de Code Review AL

> **Versión:** 1.0 | **Responsable:** Líder Técnico

## Checklist del Revisor

### Estructura y Nomenclatura
- [ ] Prefijo de empresa en todos los objetos custom
- [ ] PascalCase para procedimientos; camelCase para variables locales
- [ ] Sin objetos con nombres genéricos (evitar "Misc", "Temp", "Test" en producción)
- [ ] IDs de objetos en el rango asignado (50100-50999)

### Calidad de Código
- [ ] `NoImplicitWith`: todos los accesos a registro con prefijo explícito (`Rec.`)
- [ ] `DataClassification` declarado en todos los campos
- [ ] `ApplicationArea` y `ToolTip` en todos los controles de página
- [ ] Sin contraseñas, tokens, URLs hardcodeadas en código
- [ ] Labels para todos los textos visibles al usuario (para traducción futura)
- [ ] Gestión de errores con mensajes claros en español

### Performance
- [ ] `SetLoadFields` usado en loops con muchos registros
- [ ] Sin N+1 queries (evitar `Get()` dentro de `FindSet()` loops)
- [ ] Filtros aplicados antes de `FindSet()`/`FindFirst()`

### SaaS Compatibility
- [ ] Sin referencias a DotNet/COM
- [ ] Sin acceso a File System
- [ ] Sin SLEEP en código productivo
- [ ] HttpClient con manejo de errores y timeouts

### Extensibilidad
- [ ] Modificaciones a objetos base via extensiones (nunca modificar objetos Microsoft)
- [ ] EventSubscribers para lógica de negocio en procesos estándar
- [ ] Enums con `Extensible = true` donde corresponda

### Testing
- [ ] Código compilado sin errores ni warnings
- [ ] Publicado y probado en sandbox DEV
- [ ] Casos de prueba cubiertos por el desarrollador

**Referencia:** [AL Code Analysis](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-using-code-analysis-tool)
