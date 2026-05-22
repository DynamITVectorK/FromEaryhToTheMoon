# Checklist de Cutover

## Propósito
Lista de verificación completa para el proceso de cutover de NAV 2016 a Business Central SaaS.

---

## T-4 Semanas

- [ ] Cutover dry-run completado en entorno pre-producción
- [ ] Scripts de migración validados en pre-producción
- [ ] Plan de rollback revisado y aprobado
- [ ] Equipo de cutover confirmado y disponible
- [ ] Ventana de mantenimiento acordada con negocio
- [ ] Licencias BC SaaS asignadas a todos los usuarios
- [ ] Permisos de usuario configurados en BC SaaS producción

## T-2 Semanas

- [ ] Comunicación de mantenimiento redactada y aprobada
- [ ] UAT completado y aprobado (sign-off)
- [ ] Todos los defectos críticos y altos resueltos
- [ ] Entorno BC SaaS producción aprovisionado y configurado
- [ ] Extensiones desplegadas en producción BC
- [ ] Datos de configuración cargados en producción BC
- [ ] Integraciones configuradas para apuntar a producción

## T-1 Semana

- [ ] Notificación de mantenimiento enviada a todos los usuarios
- [ ] Accesos del equipo de cutover verificados (NAV 2016 + BC SaaS + SQL Server)
- [ ] Herramientas de migración listas (scripts PS1 probados)
- [ ] Canales de comunicación del equipo preparados (Teams/Slack/WhatsApp)
- [ ] Runbook de cutover distribuido al equipo
- [ ] Backup programado de NAV 2016 confirmado

## T-48 Horas

- [ ] Reunión de pre-cutover con todo el equipo
- [ ] Confirmación de go/no-go preliminar
- [ ] Estado de datos en NAV 2016 revisado (transacciones pendientes)
- [ ] Soporte Microsoft/Partner notificado de la fecha

## T-24 Horas

- [ ] Recordatorio enviado a usuarios (NAV no disponible desde mañana Xh)
- [ ] Equipo de cutover en alerta
- [ ] Acceso al entorno BC SaaS producción verificado
- [ ] Scripts de migración en versión final y disponibles

## T-0: Viernes — Inicio Cutover

- [ ] Reunión de kick-off del cutover celebrada
- [ ] Transacciones en NAV 2016 congeladas
- [ ] Backup completo de NAV 2016 ejecutado
- [ ] Backup verificado (restauración de prueba)
- [ ] Integraciones en NAV 2016 desactivadas
- [ ] Extracción de datos iniciada (`extract-nav2016.ps1`)
- [ ] Log de extracción monitoreado

## T-0: Sábado — Migración

- [ ] Extracción de datos completada sin errores críticos
- [ ] Transformación de datos ejecutada (`transform-data.ps1`)
- [ ] Datos transformados validados (formato y conteos)
- [ ] Carga de maestros ejecutada (`load-bc-saas.ps1` — modo real)
- [ ] Carga de maestros validada (Clientes, Proveedores, Artículos)
- [ ] Carga de datos transaccionales completada
- [ ] Saldos iniciales cargados y conciliados
- [ ] Integraciones activadas en BC SaaS
- [ ] Integraciones probadas en producción

## T-0: Domingo — Validación y Apertura

- [ ] Smoke tests completados por super usuarios
- [ ] Finance: contabilización de asiento de prueba OK
- [ ] Ventas: creación de pedido de venta OK
- [ ] Compras: creación de pedido de compra OK
- [ ] Inventario: consulta de stock OK
- [ ] Decisión formal de Go-Live tomada y documentada
- [ ] Acceso de todos los usuarios habilitado en BC SaaS
- [ ] Comunicación de Go-Live enviada a usuarios

## T+24 Horas — Lunes (Primer Día)

- [ ] Reunión de apertura del día con equipo de hypercare
- [ ] Monitoreo activo durante horas de trabajo
- [ ] Incidencias del día 1 registradas y en resolución
- [ ] Reunión de cierre del día 1 celebrada

## T+48 Horas

- [ ] Revisión de incidencias acumuladas
- [ ] Resolución de bloqueos críticos
- [ ] Reporte de estado a sponsor

## T+1 Semana

- [ ] Primera reunión semanal de hypercare celebrada
- [ ] Métricas de adopción revisadas
- [ ] Incidencias pendientes priorizadas
- [ ] Reporte semanal enviado a sponsor

---

*Documento versión 1.0 — [COMPLETAR fecha]*
