# Plan de Rollback

## Propósito
Define los criterios y procedimientos para revertir el go-live a NAV 2016 en caso de fallo crítico durante el cutover.

> **Referencia:** [BC Admin Center](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/administration/tenant-admin-center)

---

## Criterios de Activación del Rollback

El rollback se activa si se cumple alguno de los siguientes criterios antes del **punto de no retorno**:

| Criterio | Umbral | Responsable de decisión |
|---|---|---|
| Defectos críticos sin solución en < 2 horas | ≥ 1 defecto crítico | Sponsor + Líder de cutover |
| Migración de datos con errores > umbral aceptable | > 1% de registros con error | Líder de cutover |
| Integraciones críticas no operativas | ≥ 1 integración crítica caída | Arquitecto BC |
| Smoke tests fallidos por super usuarios | < 80% casos pasados | Consultor funcional |
| Entorno BC SaaS producción no disponible | Tiempo de inactividad > 2 h | IT |

---

## Punto de No Retorno

**El rollback deja de ser viable a partir de:** [COMPLETAR — ej. Domingo 12:00 h]

Después de este punto, se ha procesado suficiente volumen de transacciones en BC SaaS que hace inviable la reversión limpia. A partir de aquí, los incidentes se gestionan en modo hypercare.

---

## Procedimiento de Rollback

### Paso 1 — Decisión formal de rollback
- [ ] Sponsor ejecutivo y Líder de cutover confirman activación del rollback
- [ ] Registrar hora de decisión: ___________
- [ ] Notificar al equipo de cutover (llamada de emergencia)

### Paso 2 — Comunicación inmediata
- [ ] Enviar mensaje a usuarios: "Sistema BC temporalmente no disponible, NAV 2016 volverá a estar operativo en breve"
- [ ] Notificar a IT para preparar reactivación de NAV 2016

### Paso 3 — Reactivar NAV 2016
- [ ] Verificar integridad del backup tomado antes del cutover
- [ ] Restaurar base de datos NAV 2016 si se realizaron cambios
- [ ] Confirmar que el entorno NAV 2016 arranca correctamente
- [ ] Verificar conectividad de usuarios al servidor NAV 2016
- [ ] Reactivar integraciones en NAV 2016

### Paso 4 — Validación post-rollback
- [ ] Super usuarios confirman que NAV 2016 opera correctamente
- [ ] Verificar que no se perdieron transacciones previas al cutover
- [ ] Confirmar estado de integraciones

### Paso 5 — Comunicación de restablecimiento
- [ ] Informar a usuarios que NAV 2016 está operativo
- [ ] Comunicar nueva fecha estimada de go-live (a definir)

---

## Cronograma de Rollback Estimado

| Paso | Duración estimada | Acumulado |
|---|---|---|
| Decisión y comunicación | 30 min | 30 min |
| Reactivación de NAV 2016 | 1-2 h | 2.5 h |
| Validación | 1 h | 3.5 h |
| Comunicación de reapertura | 30 min | 4 h |

---

## Análisis Post-Rollback

Dentro de las 48 horas posteriores al rollback, el equipo deberá:

1. Documentar la causa raíz del fallo
2. Definir acciones correctivas
3. Proponer nueva fecha de go-live
4. Actualizar plan de cutover con lecciones aprendidas

---

## Responsables

| Rol | Nombre | Responsabilidad |
|---|---|---|
| Líder de cutover | [COMPLETAR] | Coordinación general del rollback |
| Sponsor | [COMPLETAR] | Autorización final |
| DBA | [COMPLETAR] | Restauración de base de datos |
| IT | [COMPLETAR] | Infraestructura y conectividad |
| Consultor funcional | [COMPLETAR] | Validación funcional post-rollback |

---

*Documento versión 1.0 — [COMPLETAR fecha]*
