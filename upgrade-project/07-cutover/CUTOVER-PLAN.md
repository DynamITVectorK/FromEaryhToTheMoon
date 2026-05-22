# Plan de Cutover

## Propósito

Este documento detalla el plan de cutover para la migración de Microsoft Dynamics NAV 2016 a Business Central SaaS. Define el cronograma detallado, los pasos a seguir, los roles responsables y los criterios de decisión durante el fin de semana de go-live.

> **Referencia oficial:** [Dynamics 365 Business Central - Go Live](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/administration/tenant-admin-center)

---

## Información General

| Campo | Valor |
|---|---|
| Fecha prevista de Go-Live | [COMPLETAR] |
| Ventana de cutover (inicio) | [COMPLETAR] Viernes 18:00 h |
| Ventana de cutover (fin) | [COMPLETAR] Lunes 08:00 h |
| Responsable del cutover | [COMPLETAR] |
| Sponsor ejecutivo | [COMPLETAR] |
| Versión BC SaaS objetivo | [COMPLETAR] |
| Entorno de producción BC | [COMPLETAR] |

---

## Equipo de Cutover

| Rol | Nombre | Teléfono | Email | Disponibilidad |
|---|---|---|---|---|
| Líder de cutover | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | 24/7 durante cutover |
| Arquitecto BC | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | 24/7 durante cutover |
| DBA / SQL Server | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | Viernes noche + sábado |
| Consultor funcional Finance | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | Sábado - domingo |
| Consultor funcional Ventas | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | Sábado - domingo |
| Consultor funcional Compras | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | Sábado - domingo |
| Super usuario Finance | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | Domingo + lunes |
| Super usuario Ventas | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | Domingo + lunes |
| IT infraestructura | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | 24/7 durante cutover |
| Soporte Microsoft / Partner | [COMPLETAR] | [COMPLETAR] | [COMPLETAR] | Según SLA |

---

## Criterios Go / No-Go

### Go-Live puede proceder si:

- [ ] Todas las pruebas UAT han sido completadas y aprobadas
- [ ] Tasa de defectos críticos = 0, defectos altos = 0
- [ ] Migración de datos validada en entorno pre-producción
- [ ] Todos los usuarios configurados con permisos correctos en BC SaaS
- [ ] Integraciones probadas y validadas
- [ ] Plan de rollback aprobado y probado
- [ ] Backups de NAV 2016 confirmados
- [ ] Comunicación a usuarios enviada
- [ ] Sponsor ejecutivo ha dado aprobación formal

### No-Go si:

- [ ] Existen defectos críticos sin resolver
- [ ] La migración de datos no ha pasado validación
- [ ] El entorno de producción BC no está disponible
- [ ] Integraciones críticas no funcionan
- [ ] El equipo de cutover no está disponible

---

## Cronograma Detallado de Cutover

### T-4 Semanas (Preparación)

| Tarea | Responsable | Estado |
|---|---|---|
| Confirmar ventana de cutover con negocio | Líder de cutover | [COMPLETAR] |
| Realizar cutover de práctica (dry-run) en pre-prod | Arquitecto BC | [COMPLETAR] |
| Validar scripts de migración en pre-prod | DBA | [COMPLETAR] |
| Confirmar plan de rollback | Líder de cutover | [COMPLETAR] |
| Preparar comunicación a usuarios | [COMPLETAR] | [COMPLETAR] |

### T-1 Semana

| Tarea | Responsable | Estado |
|---|---|---|
| Enviar notificación de mantenimiento a usuarios | [COMPLETAR] | [COMPLETAR] |
| Confirmar disponibilidad del equipo de cutover | Líder de cutover | [COMPLETAR] |
| Revisar checklist de cutover | Líder de cutover | [COMPLETAR] |
| Confirmar acceso de todos los consultores a entorno de producción | IT | [COMPLETAR] |
| Validar estado de datos en NAV 2016 | DBA | [COMPLETAR] |

### T-0: Viernes (Inicio Cutover)

| Hora | Tarea | Responsable | Duración estimada | Estado |
|---|---|---|---|---|
| 17:00 | Reunión de inicio de cutover (kick-off call) | Líder de cutover | 30 min | [ ] |
| 17:30 | Congelar transacciones en NAV 2016 | [COMPLETAR] | 30 min | [ ] |
| 18:00 | Ejecutar backup completo de base de datos NAV 2016 | DBA | 1-2 h | [ ] |
| 19:00 | Confirmar estado del entorno BC SaaS producción | Arquitecto BC | 30 min | [ ] |
| 19:30 | Iniciar extracción de datos (`extract-nav2016.ps1`) | DBA | 2-4 h | [ ] |
| 20:00 | Desactivar integraciones en NAV 2016 | IT | 30 min | [ ] |
| 22:00 | Verificar extracción completa de datos | DBA | 30 min | [ ] |

### T-0: Sábado (Migración de Datos)

| Hora | Tarea | Responsable | Duración estimada | Estado |
|---|---|---|---|---|
| 00:00 | Ejecutar transformación de datos (`transform-data.ps1`) | DBA | 2-3 h | [ ] |
| 03:00 | Validar datos transformados (formato, integridad) | DBA + Consultor | 1 h | [ ] |
| 04:00 | Iniciar carga en BC SaaS (`load-bc-saas.ps1`) — datos maestros | DBA | 3-5 h | [ ] |
| 08:00 | Verificar carga de maestros (Clientes, Proveedores, Artículos) | Consultor funcional | 2 h | [ ] |
| 10:00 | Cargar datos transaccionales (saldos iniciales, movimientos) | DBA | 3-5 h | [ ] |
| 14:00 | Validación de datos por módulo (Finance) | Consultor Finance | 2 h | [ ] |
| 14:00 | Validación de datos por módulo (Ventas/Compras) | Consultores | 2 h | [ ] |
| 16:00 | Configurar integraciones en BC SaaS | Arquitecto BC | 2 h | [ ] |
| 18:00 | Probar integraciones en producción | Arquitecto BC | 1 h | [ ] |

### T-0: Domingo (Validación y Apertura)

| Hora | Tarea | Responsable | Duración estimada | Estado |
|---|---|---|---|---|
| 08:00 | Revisión general del estado de migración | Líder de cutover | 1 h | [ ] |
| 09:00 | Pruebas de humo (smoke tests) por super usuarios | Super usuarios | 3 h | [ ] |
| 12:00 | Revisión de resultados de smoke tests | Todos | 1 h | [ ] |
| 13:00 | Decisión final Go / No-Go | Sponsor + Líder | 30 min | [ ] |
| 14:00 | Habilitar acceso de usuarios a BC SaaS | IT | 1 h | [ ] |
| 15:00 | Comunicación oficial de Go-Live a usuarios | [COMPLETAR] | 30 min | [ ] |
| 16:00 | Inicio de operaciones en Business Central SaaS | Todos | — | [ ] |

### T+1: Lunes (Primer Día de Operaciones)

| Hora | Tarea | Responsable | Estado |
|---|---|---|---|
| 07:30 | Reunión de apertura con equipo de hypercare | Líder de cutover | [ ] |
| 08:00 | Usuarios inician operaciones en BC SaaS | Usuarios | [ ] |
| Durante el día | Monitoreo activo y soporte presencial | Equipo completo | [ ] |
| 17:00 | Reunión de cierre del día 1 | Líder de cutover | [ ] |

---

## Dependencias

| Dependencia | Descripción | Responsable | Estado |
|---|---|---|---|
| Entorno BC SaaS producción activo | El entorno debe estar aprovisionado y configurado | [COMPLETAR] | [COMPLETAR] |
| Licencias BC SaaS asignadas | Todos los usuarios con licencia activa | [COMPLETAR] | [COMPLETAR] |
| Acceso a SQL Server NAV 2016 | Credenciales y conectividad confirmadas | DBA | [COMPLETAR] |
| Scripts de migración validados | Dry-run exitoso en pre-producción | DBA | [COMPLETAR] |
| Integraciones preparadas | Endpoints configurados para producción | Arquitecto BC | [COMPLETAR] |

---

## Plan de Comunicaciones Durante Cutover

| Momento | Mensaje | Audiencia | Canal | Responsable |
|---|---|---|---|---|
| T-1 semana | Aviso de mantenimiento programado | Todos los usuarios | Email | [COMPLETAR] |
| T-0 Viernes 17:00 | Inicio de ventana de mantenimiento, NAV no disponible | Todos los usuarios | Email + Teams | [COMPLETAR] |
| T-0 Domingo 15:00 | Go-Live exitoso, BC disponible | Todos los usuarios | Email + Teams | [COMPLETAR] |
| En caso de rollback | Comunicado de retraso | Todos los usuarios | Email | [COMPLETAR] |

---

## Puntos de Control (Checkpoints)

| Checkpoint | Hora prevista | Criterio de éxito | Acción si falla |
|---|---|---|---|
| CP1: Backup NAV completado | Viernes 20:00 | Backup verificado y restaurable | Repetir backup |
| CP2: Extracción de datos completa | Sábado 00:00 | 100% tablas extraídas sin errores | Investigar y corregir errores |
| CP3: Carga de maestros completa | Sábado 10:00 | Recuentos coinciden con NAV | Verificar logs, re-cargar si necesario |
| CP4: Validación de datos OK | Sábado 16:00 | Validaciones pasan > 99% | Decisión de continuar o rollback |
| CP5: Smoke tests OK | Domingo 12:00 | Super usuarios aprueban | Decisión final go/no-go |

---

## Contactos de Emergencia

| Servicio | Contacto | Teléfono |
|---|---|---|
| Microsoft Support BC SaaS | Partner support / Premier | [COMPLETAR] |
| Azure Support | Portal Azure | [COMPLETAR] |
| SQL Server DBA on-call | [COMPLETAR] | [COMPLETAR] |
| Gerencia de proyecto | [COMPLETAR] | [COMPLETAR] |

---

*Documento versión 1.0 — [COMPLETAR fecha]*
