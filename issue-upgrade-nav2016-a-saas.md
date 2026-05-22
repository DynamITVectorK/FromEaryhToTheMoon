# [Agent Task] Crear estructura completa del proyecto: Upgrade NAV 2016 → Business Central SaaS

@copilot Necesito que crees toda la estructura de carpetas, archivos y documentación del proyecto de upgrade de Microsoft Dynamics NAV 2016 a Business Central SaaS. A continuación el plan completo que debes implementar:

## 🎯 Objetivo
Crear en este repositorio la estructura completa de un proyecto de migración/upgrade de NAV 2016 (C/AL) a Business Central SaaS (AL Extension), incluyendo carpetas, archivos de configuración, plantillas, documentación y scripts de apoyo.

## 📁 Estructura de carpetas y archivos a crear

```text
upgrade-project/
├── 00-project-management/
│   ├── PROJECT_CHARTER.md
│   ├── SCOPE.md
│   ├── RISKS.md
│   ├── STAKEHOLDERS.md
│   ├── TIMELINE.md
│   └── MEETING_NOTES_TEMPLATE.md
├── 01-assessment/
│   ├── NAV2016-OBJECT-INVENTORY.md
│   ├── CUSTOMIZATIONS-CATALOG.md
│   ├── INTEGRATIONS-CATALOG.md
│   ├── DATA-VOLUME-ANALYSIS.md
│   ├── COMPLEXITY-MATRIX.md
│   └── GAP-ANALYSIS.md
├── 02-architecture/
│   ├── SOLUTION-DESIGN.md
│   ├── EXTENSION-ARCHITECTURE.md
│   ├── DATA-MIGRATION-STRATEGY.md
│   ├── INTEGRATION-ARCHITECTURE.md
│   ├── ENVIRONMENT-STRATEGY.md
│   └── SECURITY-MODEL.md
├── 03-conversion/
│   ├── CAL-TO-AL-RULES.md
│   ├── OBJECTS-MIGRATION-TRACKER.md
│   ├── DEPRECATED-FEATURES.md
│   ├── EVENTS-MAPPING.md
│   └── REPORTS-MIGRATION.md
├── 04-development/
│   ├── CODING-STANDARDS.md
│   ├── GIT-WORKFLOW.md
│   ├── AL-BEST-PRACTICES.md
│   ├── CODE-REVIEW-CHECKLIST.md
│   └── src/
├── 05-data-migration/
│   ├── DATA-MIGRATION-PLAN.md
│   ├── TABLE-MAPPING.md
│   ├── DATA-CLEANSING-RULES.md
│   ├── MIGRATION-SCRIPTS/
│   │   ├── README.md
│   │   ├── extract-nav2016.ps1
│   │   ├── transform-data.ps1
│   │   └── load-bc-saas.ps1
│   └── DATA-VALIDATION-CHECKLIST.md
├── 06-testing/
│   ├── TEST-STRATEGY.md
│   ├── TEST-PLAN.md
│   ├── UAT-SCENARIOS/
│   │   ├── README.md
│   │   ├── finance-scenarios.md
│   │   ├── sales-scenarios.md
│   │   ├── purchase-scenarios.md
│   │   ├── inventory-scenarios.md
│   │   └── integrations-scenarios.md
│   ├── TEST-RESULTS-TEMPLATE.md
│   └── BUG-REPORT-TEMPLATE.md
├── 07-cutover/
│   ├── CUTOVER-PLAN.md
│   ├── ROLLBACK-PLAN.md
│   ├── CUTOVER-CHECKLIST.md
│   ├── COMMUNICATION-PLAN.md
│   └── HYPERCARE-PLAN.md
├── 08-training/
│   ├── TRAINING-PLAN.md
│   ├── TRAINING-MATERIALS/
│   │   ├── README.md
│   │   ├── quick-reference-guide.md
│   │   └── admin-guide.md
│   └── SUPER-USER-GUIDE.md
└── README.md
```

## 📋 Contenido de cada archivo

Cada archivo debe incluir:
- Título y propósito del documento
- Secciones estructuradas con encabezados relevantes
- Tablas/listas/plantillas donde aplique
- Placeholders `[COMPLETAR]`
- Referencias a documentación oficial de Microsoft Business Central
- Redacción en español

## 🧩 Requerimientos especiales

- `00-project-management/TIMELINE.md` debe incluir fases con duración estimada:
  1. Assessment & Discovery (4 semanas)
  2. Architecture & Design (3 semanas)
  3. Development & Conversion (8-16 semanas según complejidad)
  4. Data Migration Preparation (4 semanas, paralela a Dev)
  5. Testing (UAT) (4-6 semanas)
  6. Cutover & Go-Live (1 semana)
  7. Hypercare (4-8 semanas)

- `01-assessment/NAV2016-OBJECT-INVENTORY.md` debe incluir tabla:
  `Tipo | ID | Nombre | Módulo | Estándar/Custom | Complejidad (Alta/Media/Baja) | Acción (Reescribir/Migrar/Reemplazar/Eliminar) | Responsable | Estado`

- `03-conversion/OBJECTS-MIGRATION-TRACKER.md` debe incluir tabla:
  `Tipo | Objeto NAV2016 | Objeto BC SaaS | Estado | Desarrollador | Fecha inicio | Fecha fin | Notas`

- `05-data-migration/TABLE-MAPPING.md` debe incluir tabla:
  `Tabla NAV2016 | Tabla BC SaaS | Campos mapeados | Transformaciones | Validaciones | Estado`

- `06-testing/UAT-SCENARIOS/*.md` debe incluir escenarios con:
  `ID | Descripción | Precondiciones | Pasos | Resultado esperado | Resultado actual | Estado | Responsable`

- `05-data-migration/MIGRATION-SCRIPTS/extract-nav2016.ps1` debe ser funcional y:
  - Conectarse a SQL Server (base NAV 2016)
  - Extraer tablas clave (Customer, Vendor, Item, G/L Entry, etc.)
  - Exportar a CSV o JSON
  - Incluir logging y manejo de errores

- `05-data-migration/MIGRATION-SCRIPTS/load-bc-saas.ps1` debe ser funcional y:
  - Usar API REST v2 de Business Central
  - Cargar customers, vendors, items
  - Soportar OAuth2 service-to-service
  - Incluir logging, manejo de errores y modo dry-run

- `upgrade-project/README.md` debe incluir:
  - Descripción del proyecto
  - Resumen ejecutivo del upgrade
  - Cómo navegar la estructura
  - Quick start técnico
  - Quick start funcional
  - Links a documentos clave

## ✅ Criterios de aceptación

- [ ] Todas las carpetas y archivos listados existen bajo `upgrade-project/`
- [ ] Cada `.md` tiene contenido real y estructurado
- [ ] Los scripts PowerShell son funcionales y con comentarios explicativos
- [ ] Todos los archivos están en español
- [ ] El `README.md` raíz del upgrade está completo y navegable
- [ ] Los archivos de tracking incluyen tablas Markdown correctas

