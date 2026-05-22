# Checklist de Validación Post-Migración

> **Versión:** 1.0 | **Responsable:** Especialista de Datos + Usuarios Clave

## Validaciones Automáticas (scripts)

### Recuentos de Registros
| Tabla | Registros NAV 2016 | Registros BC | Diferencia | Estado |
|-------|------------------|-------------|-----------|--------|
| Customer | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | ⬜ |
| Vendor | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | ⬜ |
| Item | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | ⬜ |
| G/L Account | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | ⬜ |

### Reconciliación Financiera
| Validación | Valor NAV 2016 | Valor BC | Diferencia | Estado |
|-----------|--------------|---------|-----------|--------|
| Total saldos CxC (moneda local) | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | ⬜ |
| Total saldos CxP (moneda local) | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | ⬜ |
| Valor total de inventario | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | ⬜ |
| Balance general (Activo Total) | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | ⬜ |

## Validaciones Manuales (usuarios clave)

### Finanzas
- [ ] Balance de sumas y saldos cuadrado a fecha de corte
- [ ] 3 clientes spot-check: saldo y movimientos abiertos correctos
- [ ] 3 proveedores spot-check: saldo y facturas pendientes correctas
- [ ] Tipos de cambio de monedas extranjeras correctos (si aplica)

### Ventas
- [ ] 5 clientes muestra: datos maestros completos y correctos
- [ ] Pedidos abiertos a fecha de corte presentes en BC
- [ ] Límites de crédito migrados

### Compras
- [ ] 5 proveedores muestra: datos completos
- [ ] Pedidos de compra pendientes de recibir presentes

### Inventario
- [ ] Nivel de stock de 10 artículos muestra coincide con NAV 2016
- [ ] Valoración de inventario cuadra con balance
- [ ] Números de serie/lote críticos presentes

## Resultado Final
| Área | Responsable validación | Resultado | Firma | Fecha |
|------|----------------------|-----------|-------|-------|
| Finanzas | [COMPLETAR] | ✅/❌ | _______ | [COMPLETAR] |
| Ventas | [COMPLETAR] | ✅/❌ | _______ | [COMPLETAR] |
| Compras | [COMPLETAR] | ✅/❌ | _______ | [COMPLETAR] |
| Inventario | [COMPLETAR] | ✅/❌ | _______ | [COMPLETAR] |
| Técnico | [COMPLETAR] | ✅/❌ | _______ | [COMPLETAR] |

**GO/NO-GO:** _________________ | Autorizado por: _________________ | Fecha: _________________
