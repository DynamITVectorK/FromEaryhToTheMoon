# Registro de Riesgos del Proyecto

> **Versión:** 1.0 | **Última actualización:** [COMPLETAR] | **Propietario:** Gerente de Proyecto

---

## Metodología de Evaluación

| Probabilidad | Definición |
|-------------|-----------|
| **Alta** | > 70% de probabilidad de ocurrencia |
| **Media** | 30-70% de probabilidad |
| **Baja** | < 30% de probabilidad |

| Impacto | Definición |
|---------|-----------|
| **Alto** | Afecta cronograma > 2 semanas, presupuesto > 15%, o compromete el go-live |
| **Medio** | Afecta cronograma 1-2 semanas, presupuesto 5-15% |
| **Bajo** | Impacto menor, manejable dentro del plan actual |

**Exposición = Probabilidad × Impacto** (A×A=Crítico, A×M o M×A=Alto, etc.)

---

## Registro de Riesgos

| ID | Riesgo | Categoría | Probabilidad | Impacto | Exposición | Mitigación | Responsable | Estado |
|----|--------|-----------|-------------|---------|-----------|-----------|-------------|--------|
| R001 | Complejidad de personalizaciones C/AL subestimada durante el assessment, generando un esfuerzo de conversión mayor al estimado | Técnico | Alta | Alto | **Crítico** | Realizar un análisis exhaustivo de todos los objetos en fase 1; incluir buffer del 30% en estimaciones; definir criterio de "MVP" para priorizar conversiones críticas | Líder Técnico | Activo |
| R002 | Funcionalidades críticas de NAV 2016 no disponibles en Business Central SaaS (ej: COM automation, DotNet interop, NAS) | Técnico | Alta | Alto | **Crítico** | Completar GAP analysis en semanas 1-2; identificar alternativas (Azure Functions, Power Automate, APIs); obtener aprobación temprana de soluciones alternativas | Arquitecto de Solución | Activo |
| R003 | Calidad de datos en NAV 2016 insuficiente (duplicados, datos huérfanos, campos obligatorios vacíos) impide migración limpia | Datos | Alta | Alto | **Crítico** | Iniciar análisis de calidad de datos en paralelo con assessment; ejecutar data cleansing 4-6 semanas antes del cutover; múltiples simulacros de migración | Especialista de Datos | Activo |
| R004 | Resistencia al cambio por parte de usuarios finales, bajo adoption de la nueva plataforma | Organizacional | Media | Alto | **Alto** | Plan de gestión del cambio desde semana 1; involucramiento de super usuarios desde fases tempranas; comunicación regular del progreso y beneficios | Gerente de Proyecto | Activo |
| R005 | Dependencia de proveedor externo (socio de implementación) con escasez de recursos AL qualificados o rotación de personal clave | Recursos | Media | Alto | **Alto** | Identificar recursos de respaldo; contratos con cláusulas de continuidad; knowledge transfer continuo al equipo interno; documentación de código rigurosa | Gerente de Proyecto | Activo |
| R006 | Integraciones con sistemas externos incompatibles con modelo SaaS; APIs de terceros no disponibles o deprecadas | Técnico/Integración | Media | Alto | **Alto** | Inventariar todas las integraciones en semana 1; evaluar disponibilidad de APIs modernas; definir estrategia de integración (Azure Integration Services) en fase 2 | Arquitecto de Integración | Activo |
| R007 | El cronograma de cutover coincide con período crítico de negocio (cierre fiscal, temporada alta) aumentando el riesgo operacional | Negocio | Media | Alto | **Alto** | Coordinar fecha de go-live con dirección financiera y operaciones; evitar cierres fiscales y temporadas de alta actividad; definir ventana ideal de cutover | Gerente de Proyecto | Activo |
| R008 | Tiempo de inactividad durante la ventana de cutover excede lo planificado, afectando la operación del negocio | Operacional | Media | Alto | **Alto** | Plan de cutover detallado con rehearsal completo; rollback plan probado; comunicación anticipada a clientes y proveedores; equipo de soporte disponible 24/7 | Gerente de Proyecto | Activo |
| R009 | Versión de Business Central SaaS actualizada automáticamente por Microsoft durante el proyecto, generando incompatibilidades | Técnico | Media | Medio | **Medio** | Desarrollo en tenant sandbox de BC; pruebas de compatibilidad con cada minor update; seguir guías de upgrade compatibility de Microsoft; uso de API v2.0 estable | Líder Técnico | Activo |
| R010 | Rendimiento de Business Central SaaS inferior al esperado para volúmenes de datos específicos del cliente | Rendimiento | Baja | Alto | **Medio** | Pruebas de carga en entorno sandbox con volúmenes reales; optimización de código AL (SetLoadFields, filtros eficientes); seguir AL performance guidelines | Líder Técnico | Activo |
| R011 | Falta de disponibilidad de usuarios clave para participar en UAT según el cronograma del proyecto | Recursos | Media | Medio | **Medio** | Acordar disponibilidad en Project Charter; incluir UAT en plan de capacidad de usuarios; identificar usuarios alternativos de respaldo; ajustar UAT schedule con anticipación | Gerente de Proyecto | Activo |
| R012 | Pérdida de datos durante el proceso de migración por error en scripts de transformación o carga | Datos | Baja | Alto | **Medio** | Múltiples validaciones pre y post-migración; backup completo de NAV2016 antes de cutover; simulacros de migración completos; scripts de reconciliación automática | Especialista de Datos | Activo |
| R013 | Configuración de permisos y seguridad en BC SaaS más restrictiva que NAV 2016, bloqueando flujos de trabajo existentes | Seguridad | Media | Medio | **Medio** | Mapeo detallado de roles NAV2016 a permission sets BC; pruebas de acceso con cada perfil de usuario en UAT; documentar modelo de seguridad completo | Consultor Funcional | Activo |

---

## Resumen por Categoría

| Categoría | Crítico | Alto | Medio | Bajo | Total |
|-----------|---------|------|-------|------|-------|
| Técnico | 2 | 2 | 1 | 0 | 5 |
| Datos | 1 | 0 | 1 | 0 | 2 |
| Organizacional | 0 | 1 | 0 | 0 | 1 |
| Recursos | 0 | 1 | 1 | 0 | 2 |
| Negocio | 0 | 1 | 0 | 0 | 1 |
| Seguridad | 0 | 0 | 1 | 0 | 1 |
| **Total** | **3** | **5** | **4** | **0** | **13** |

---

*Revisar y actualizar en reunión quincenal de riesgos. Referencia: [Microsoft BC Known Issues](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/known-issues)*
