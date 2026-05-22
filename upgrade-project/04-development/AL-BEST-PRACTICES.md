# Best Practices AL para BC SaaS

> **Versión:** 1.0 | **Responsable:** Líder Técnico

## Performance

### SetLoadFields - Solo cargar campos necesarios
```al
// ✅ CORRECTO
Customer.SetLoadFields(Name, "Credit Limit (LCY)", "[PREFIX] Category");
if Customer.Get(CustomerNo) then
    ProcessCustomer(Customer);
```

### Evitar SELECT * implícito en loops
```al
// ✅ CORRECTO
SalesLine.SetLoadFields("No.", Quantity, "Unit Price");
if SalesLine.FindSet() then
    repeat
        // procesar
    until SalesLine.Next() = 0;
```

### Usar ISLOCKED() antes de modificar
```al
if not Rec.IsLocked() then
    Rec.Modify(true);
```

## Seguridad
- Nunca concatenar SQL strings (no aplica en AL, pero evitar EXECUTE en queries)
- Validar todos los inputs externos (de APIs, XMLPorts)
- Usar `DataClassification` correcta en todos los campos

## Compatibilidad con Actualizaciones
- No acceder a propiedades `ObsoleteState = Removed`
- Monitorear BC Release Notes antes de cada major update
- Tests automatizados para detectar breaking changes

## Integraciones
```al
// ✅ CORRECTO: HttpClient con manejo de errores
var
    Client: HttpClient;
    Response: HttpResponseMessage;
    RequestBody: HttpContent;
begin
    RequestBody.WriteFrom(JsonPayload);
    if Client.Post(EndpointUrl, RequestBody, Response) then begin
        if not Response.IsSuccessStatusCode() then
            Error('API error: %1', Response.HttpStatusCode());
    end;
end;
```

**Referencia:** [AL Performance Guide](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-writing-efficient-al)
