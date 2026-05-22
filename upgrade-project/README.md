# Proyecto de Upgrade: Microsoft Dynamics NAV 2016 → Business Central SaaS

> **Versión:** 1.0.0 | **Estado:** En progreso | **Última actualización:** [COMPLETAR]

---

## Resumen Ejecutivo

Este repositorio contiene toda la documentación, scripts y artefactos del proyecto de migración de **Microsoft Dynamics NAV 2016** a **Microsoft Dynamics 365 Business Central SaaS**. El objetivo es transformar la implementación actual basada en C/AL (Classic AL) a una arquitectura moderna de extensiones AL sobre la plataforma SaaS de Business Central, aprovechando las ventajas de la nube: actualizaciones automáticas, escalabilidad, seguridad y continuidad de negocio.

La migración implica la reescritura de personalizaciones en AL siguiendo el modelo de extensiones, la migración de datos históricos, la redefinición de integraciones y la capacitación de usuarios en la nueva plataforma.

**Referencia oficial:** [Microsoft Docs - Upgrading to Business Central](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/upgrade/upgrade-overview-v21)

---

## Descripción del Alcance

| Dimensión | Detalle |
|-----------|---------|
| **Sistema origen** | Microsoft Dynamics NAV 2016 (versión 9.0) |
| **Sistema destino** | Microsoft Dynamics 365 Business Central SaaS (versión actual) |
| **Tipo de migración** | C/AL monolítico → Extensions AL (per-tenant o AppSource) |
| **Modelo de despliegue** | Cloud SaaS (Microsoft-managed) |
| **Módulos en alcance** | [COMPLETAR - Finanzas, Ventas, Compras, Inventario, etc.] |
| **Personalizaciones** | [COMPLETAR - número de objetos custom] |
| **Integraciones** | [COMPLETAR - lista de sistemas externos] |
| **Usuarios afectados** | [COMPLETAR] |

---

## Estructura de Carpetas

```
upgrade-project/
├── 00-project-management/   # Gestión del proyecto: charter, scope, riesgos, cronograma
├── 01-assessment/           # Análisis y evaluación del sistema NAV 2016 actual
├── 02-architecture/         # Diseño de la solución BC SaaS y arquitectura técnica
├── 03-conversion/           # Reglas y tracking de conversión C/AL → AL
├── 04-development/          # Estándares de desarrollo AL, Git workflow, best practices
├── 05-data-migration/       # Plan, scripts y validación de migración de datos
├── 06-testing/              # Estrategia de pruebas, UAT, reportes de bugs
├── 07-cutover/              # Plan de cutover, rollback, comunicaciones
└── 08-training/             # Plan de capacitación y materiales de formación
```

### Descripción de Carpetas

| Carpeta | Propósito | Documentos Clave |
|---------|-----------|------------------|
| `00-project-management` | Gobierno del proyecto, charter, stakeholders, cronograma, riesgos | PROJECT_CHARTER, TIMELINE, RISKS |
| `01-assessment` | Inventario de objetos NAV2016, análisis de gaps, catálogos | NAV2016-OBJECT-INVENTORY, GAP-ANALYSIS |
| `02-architecture` | Diseño técnico de la solución en BC SaaS | SOLUTION-DESIGN, EXTENSION-ARCHITECTURE |
| `03-conversion` | Guías de conversión C/AL→AL, tracker de objetos | CAL-TO-AL-RULES, OBJECTS-MIGRATION-TRACKER |
| `04-development` | Estándares de código AL, workflow de Git | CODING-STANDARDS, AL-BEST-PRACTICES |
| `05-data-migration` | Scripts PowerShell, mapeo de tablas, validación | DATA-MIGRATION-PLAN, TABLE-MAPPING |
| `06-testing` | Estrategia UAT, escenarios de prueba, reportes | TEST-STRATEGY, UAT-SCENARIOS/ |
| `07-cutover` | Procedimientos de go-live y rollback | CUTOVER-PLAN, ROLLBACK-PLAN |
| `08-training` | Materiales y plan de capacitación | TRAINING-PLAN, SUPER-USER-GUIDE |

---

## Quick Start Técnico (Para Desarrolladores)

1. **Revisar el inventario de objetos**: [`01-assessment/NAV2016-OBJECT-INVENTORY.md`](01-assessment/NAV2016-OBJECT-INVENTORY.md)
2. **Estudiar las reglas de conversión**: [`03-conversion/CAL-TO-AL-RULES.md`](03-conversion/CAL-TO-AL-RULES.md)
3. **Configurar el entorno AL**: Instalar VS Code + AL Language extension + Docker con BC image
4. **Seguir los estándares**: [`04-development/CODING-STANDARDS.md`](04-development/CODING-STANDARDS.md)
5. **Workflow Git**: [`04-development/GIT-WORKFLOW.md`](04-development/GIT-WORKFLOW.md)
6. **Actualizar el tracker**: [`03-conversion/OBJECTS-MIGRATION-TRACKER.md`](03-conversion/OBJECTS-MIGRATION-TRACKER.md)

**Referencia:** [AL Development Environment](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-get-started)

---

## Quick Start Funcional (Para Consultores)

1. **Revisar el análisis de gaps**: [`01-assessment/GAP-ANALYSIS.md`](01-assessment/GAP-ANALYSIS.md)
2. **Validar el alcance del proyecto**: [`00-project-management/SCOPE.md`](00-project-management/SCOPE.md)
3. **Preparar escenarios UAT**: [`06-testing/UAT-SCENARIOS/`](06-testing/UAT-SCENARIOS/)
4. **Revisar el plan de migración de datos**: [`05-data-migration/DATA-MIGRATION-PLAN.md`](05-data-migration/DATA-MIGRATION-PLAN.md)
5. **Planificar capacitación**: [`08-training/TRAINING-PLAN.md`](08-training/TRAINING-PLAN.md)
6. **Revisar el plan de cutover**: [`07-cutover/CUTOVER-PLAN.md`](07-cutover/CUTOVER-PLAN.md)

---

## Links a Documentos Clave

| Documento | Ruta | Descripción |
|-----------|------|-------------|
| Project Charter | [00-project-management/PROJECT_CHARTER.md](00-project-management/PROJECT_CHARTER.md) | Documento fundacional del proyecto |
| Cronograma | [00-project-management/TIMELINE.md](00-project-management/TIMELINE.md) | Plan de fases y hitos |
| Inventario de Objetos | [01-assessment/NAV2016-OBJECT-INVENTORY.md](01-assessment/NAV2016-OBJECT-INVENTORY.md) | Todos los objetos NAV2016 |
| Análisis de Gaps | [01-assessment/GAP-ANALYSIS.md](01-assessment/GAP-ANALYSIS.md) | Brechas funcionales identificadas |
| Diseño de Solución | [02-architecture/SOLUTION-DESIGN.md](02-architecture/SOLUTION-DESIGN.md) | Arquitectura de la solución BC |
| Reglas C/AL → AL | [03-conversion/CAL-TO-AL-RULES.md](03-conversion/CAL-TO-AL-RULES.md) | Guía de conversión de código |
| Plan de Migración de Datos | [05-data-migration/DATA-MIGRATION-PLAN.md](05-data-migration/DATA-MIGRATION-PLAN.md) | Estrategia y plan de datos |
| Plan de Cutover | [07-cutover/CUTOVER-PLAN.md](07-cutover/CUTOVER-PLAN.md) | Procedimiento de go-live |
| Plan de Capacitación | [08-training/TRAINING-PLAN.md](08-training/TRAINING-PLAN.md) | Formación de usuarios |

---

## Estado del Proyecto

| Fase | Estado | % Completado | Fecha Objetivo |
|------|--------|-------------|----------------|
| 00 - Gestión del Proyecto | 🟡 En progreso | [COMPLETAR]% | [COMPLETAR] |
| 01 - Assessment | 🔴 Pendiente | 0% | [COMPLETAR] |
| 02 - Arquitectura | 🔴 Pendiente | 0% | [COMPLETAR] |
| 03 - Conversión | 🔴 Pendiente | 0% | [COMPLETAR] |
| 04 - Desarrollo | 🔴 Pendiente | 0% | [COMPLETAR] |
| 05 - Migración de Datos | 🔴 Pendiente | 0% | [COMPLETAR] |
| 06 - Testing | 🔴 Pendiente | 0% | [COMPLETAR] |
| 07 - Cutover | 🔴 Pendiente | 0% | [COMPLETAR] |
| 08 - Capacitación | 🔴 Pendiente | 0% | [COMPLETAR] |

---

*Proyecto gestionado por [COMPLETAR - Nombre empresa/equipo] | Contacto: [COMPLETAR]*
