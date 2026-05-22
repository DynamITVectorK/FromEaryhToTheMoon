# Mapeo de Eventos C/AL → AL (Publisher/Subscriber)

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Responsable:** Líder Técnico

---

## Propósito

Documentar el mapeo de todos los triggers y modificaciones de código C/AL en objetos estándar de NAV 2016 hacia el patrón de eventos Publisher/Subscriber de AL en Business Central.

**Referencia:** [BC Events Overview](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-events-in-al)

---

## Tipos de Eventos en AL

| Tipo | Descripción | Cuándo usar |
|------|-------------|-------------|
| `BusinessEvent` | Eventos de proceso de negocio significativos | Nuevo pedido creado, factura registrada |
| `IntegrationEvent` | Para integraciones técnicas y extensibilidad | Llamadas a sistemas externos |
| `InternalEvent` | Dentro de la misma extensión | Lógica interna de la PTE |

---

## Catálogo de Eventos Estándar Más Usados

### Sales (Ventas)

| Evento Publisher | Codeunit | Cuándo se lanza | Uso típico |
|----------------|---------|----------------|-----------|
| `OnBeforePostSalesDoc` | Sales-Post (80) | Antes de registrar el documento | Validaciones previas al registro |
| `OnAfterPostSalesDoc` | Sales-Post (80) | Después de registrar | Notificaciones, actualizaciones |
| `OnBeforeReleaseSalesDoc` | Release Sales Document (414) | Antes de liberar pedido | Validaciones de aprobación |
| `OnAfterReleaseSalesDoc` | Release Sales Document (414) | Después de liberar | [COMPLETAR] |
| `OnBeforeInsertSalesLine` | Sales-Post (80) | Antes de insertar línea en historial | Enriquecer datos de línea |

### Purchase (Compras)

| Evento Publisher | Codeunit | Cuándo se lanza | Uso típico |
|----------------|---------|----------------|-----------|
| `OnBeforePostPurchDoc` | Purch.-Post (90) | Antes de registrar compra | Validaciones |
| `OnAfterPostPurchDoc` | Purch.-Post (90) | Después de registrar | Notificaciones |
| `OnBeforeReleasePurchaseDoc` | Release Purchase Document (415) | Antes de liberar | Aprobaciones |

### Inventory (Inventario)

| Evento Publisher | Codeunit | Cuándo se lanza | Uso típico |
|----------------|---------|----------------|-----------|
| `OnAfterPostItemJournalLine` | Item Jnl.-Post Line (22) | Después de posting de movimiento | Actualizar datos custom |
| `OnBeforeInsertItemLedgEntry` | Item Jnl.-Post Line (22) | Antes de insertar movimiento | Enriquecer movimiento |

### Finance (Finanzas)

| Evento Publisher | Codeunit | Cuándo se lanza | Uso típico |
|----------------|---------|----------------|-----------|
| `OnAfterPostGenJournalLine` | Gen. Jnl.-Post Line (12) | Después de posting contable | Actualizaciones post-posting |
| `OnBeforePostGenJournalLine` | Gen. Jnl.-Post Line (12) | Antes de posting | Validaciones contables |

---

## Mapeo del Proyecto: Modificaciones → EventSubscribers

### Modificaciones en Codeunit 80 (Sales-Post)

| # | Tipo de mod. NAV 2016 | Evento AL equivalente | Codeunit Subscriber | Desarrollador | Estado |
|---|----------------------|----------------------|--------------------|-----------:|--------|
| 1 | [COMPLETAR - descripción modificación] | OnBeforePostSalesDoc | [PREFIX] Sales Subscriber | [COMPLETAR] | ⬜ Pendiente |
| 2 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | ⬜ Pendiente |

### Modificaciones en Tabla 18 (Customer)

| # | Trigger NAV 2016 | Evento AL equivalente | Codeunit Subscriber | Desarrollador | Estado |
|---|----------------|----------------------|--------------------|-----------:|--------|
| 1 | OnAfterValidate([COMPLETAR campo]) | OnAfterValidateEvent en TableExtension | [PREFIX] Customer Ext | [COMPLETAR] | ⬜ Pendiente |
| 2 | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | ⬜ Pendiente |

### Modificaciones en Codeunit 90 (Purch.-Post)

| # | Tipo de mod. NAV 2016 | Evento AL equivalente | Codeunit Subscriber | Desarrollador | Estado |
|---|----------------------|----------------------|--------------------|-----------:|--------|
| 1 | [COMPLETAR] | OnBeforePostPurchDoc | [PREFIX] Purch Subscriber | [COMPLETAR] | ⬜ Pendiente |

---

## Ejemplo de Implementación de EventSubscriber

```al
codeunit 50301 "[PREFIX] Sales Event Subscriber"
{
    // ═══════════════════════════════════════════════════════════
    // Sustituto de código custom que estaba en Codeunit 80
    // Original C/AL: modificación directa en OnRun de Sales-Post
    // ═══════════════════════════════════════════════════════════
    
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 
                     'OnBeforePostSalesDoc', '', false, false)]
    local procedure ValidateOnBeforePost(
        var SalesHeader: Record "Sales Header";
        CommitIsSuppressed: Boolean)
    var
        MissingCategoryErr: Label 'El cliente %1 no tiene categoría asignada. No se puede registrar el pedido.';
    begin
        if SalesHeader."[PREFIX] Category" = '' then
            Error(MissingCategoryErr, SalesHeader."Sell-to Customer No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 
                     'OnAfterPostSalesDoc', '', false, false)]
    local procedure NotifyAfterPost(
        var SalesHeader: Record "Sales Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        SalesShptHdrNo: Code[20];
        RetRcptHdrNo: Code[20];
        SalesInvHdrNo: Code[20];
        SalesCrMemoHdrNo: Code[20];
        CommitIsSuppressed: Boolean;
        InvtPickPutaway: Boolean;
        var CustLedgEntry: Record "Cust. Ledger Entry";
        WhseShip: Boolean;
        WhseReceive: Boolean;
        PreviewMode: Boolean)
    begin
        if SalesInvHdrNo <> '' then
            SendInvoiceNotification(SalesInvHdrNo);
    end;

    local procedure SendInvoiceNotification(InvoiceNo: Code[20])
    begin
        // [COMPLETAR - lógica de notificación]
    end;
}
```

---

*Referencia: [Publishing Events](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-publishing-events)*
