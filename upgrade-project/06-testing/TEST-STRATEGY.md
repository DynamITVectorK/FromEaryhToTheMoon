# Estrategia de Testing

> **Versión:** 1.0 | **Responsable:** Especialista QA

## Niveles de Testing

| Nivel | Responsable | Herramienta | Cuándo |
|-------|-------------|-------------|--------|
| Unit Tests | Desarrollador AL | AL Test Framework | Durante desarrollo |
| Integration Testing | Equipo técnico | Manual + scripts | Post-desarrollo |
| System Testing | QA + Funcional | Manual en sandbox QA | Pre-UAT |
| UAT | Usuarios clave | Manual en sandbox UAT | Pre-Go-Live |
| Performance | Líder Técnico | Pruebas de carga | Pre-Go-Live |
| Regression | QA | Smoke tests | Post cada deploy |

## Criterios de Entrada/Salida UAT

**Entrada:**
- Extensiones AL desplegadas sin errores en UAT
- Datos de NAV 2016 migrados al entorno UAT
- Casos de prueba definidos y aprobados
- Usuarios capacitados para ejecutar UAT

**Salida (aprobación UAT):**
- ≥ 95% de casos de prueba pasados
- 0 defectos críticos abiertos
- ≤ 5 defectos altos (con plan de resolución < 3 días)
- Sign-off firmado por todos los super usuarios

## Clasificación de Defectos

| Severidad | Descripción | SLA de resolución |
|-----------|-------------|------------------|
| Crítico | Bloquea proceso core; pérdida de datos | 24 horas |
| Alto | Funcionalidad mayor no funciona; workaround difícil | 3 días hábiles |
| Medio | Funcionalidad menor afectada; workaround disponible | Sprint actual |
| Bajo | Cosmético, UX menor | Backlog |

**Referencia:** [BC Testing Overview](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-testing-framework)
