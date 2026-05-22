# Matriz de Complejidad de Personalizaciones

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Responsable:** [COMPLETAR]

---

## Propósito

Evaluar la complejidad de conversión de cada personalización C/AL a AL mediante un scoring multi-criterio. La puntuación total determina la prioridad de asignación de recursos y la estimación de esfuerzo.

---

## Metodología de Scoring

Cada personalización se evalúa en 6 dimensiones, con puntuación de 1 a 3:

| Dimensión | 1 (Baja) | 2 (Media) | 3 (Alta) |
|-----------|---------|---------|---------|
| **Líneas de código (LOC)** | < 100 líneas | 100-500 líneas | > 500 líneas |
| **Dependencias** | 0-2 objetos dependientes | 3-5 objetos | > 5 objetos |
| **Restricciones SaaS** | Sin restricciones | Restricciones menores, alternativa clara | Restricciones mayores, rediseño necesario |
| **Lógica de negocio** | Simple (CRUD básico) | Media (cálculos, validaciones) | Compleja (flujos, integración, procesos) |
| **Riesgo de datos** | Sin impacto en datos | Modifica datos existentes | Reestructura tablas o migración de datos |
| **Impacto en usuarios** | 1 usuario/rol | 2-5 usuarios/roles | > 5 usuarios/roles críticos |

**Rango total: 6-18 puntos**

| Puntuación | Clasificación | Color | Estrategia |
|-----------|--------------|-------|-----------|
| 6-9 | Baja complejidad | 🟢 Verde | Conversión directa, 1-2 sprints |
| 10-13 | Media complejidad | 🟡 Amarillo | Requiere análisis y diseño previo, 2-3 sprints |
| 14-18 | Alta complejidad | 🔴 Rojo | Rediseño arquitectural, priorizar en cronograma |

---

## Matriz de Evaluación

| ID | Nombre Personalización | LOC | Depend. | SaaS | Negocio | Datos | Usuarios | **Total** | **Nivel** |
|----|----------------------|-----|---------|------|---------|-------|---------|-----------|---------|
| CUST-001 | [COMPLETAR] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | **[TOTAL]** | 🔴/🟡/🟢 |
| CUST-002 | [COMPLETAR] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | **[TOTAL]** | 🔴/🟡/🟢 |
| CUST-003 | [COMPLETAR] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | **[TOTAL]** | 🔴/🟡/🟢 |
| CUST-004 | [COMPLETAR] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | **[TOTAL]** | 🔴/🟡/🟢 |
| CUST-005 | [COMPLETAR] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | **[TOTAL]** | 🔴/🟡/🟢 |
| CUST-006 | [COMPLETAR] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | **[TOTAL]** | 🔴/🟡/🟢 |
| CUST-007 | [COMPLETAR] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | **[TOTAL]** | 🔴/🟡/🟢 |
| CUST-008 | [COMPLETAR] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | [1/2/3] | **[TOTAL]** | 🔴/🟡/🟢 |

---

## Resumen por Nivel de Complejidad

| Nivel | # Personalizaciones | % del total | Horas totales estimadas |
|-------|-------------------|-------------|------------------------|
| 🔴 Alta (14-18) | [COMPLETAR] | [COMPLETAR]% | [COMPLETAR] |
| 🟡 Media (10-13) | [COMPLETAR] | [COMPLETAR]% | [COMPLETAR] |
| 🟢 Baja (6-9) | [COMPLETAR] | [COMPLETAR]% | [COMPLETAR] |
| **Total** | **[COMPLETAR]** | **100%** | **[COMPLETAR]** |

---

## Personalizaciones de Alta Complejidad (Detalle)

Las siguientes personalizaciones requieren atención especial y deben incluirse en el sprint de arquitectura:

| ID | Personalización | Puntuación | Principal reto | Recomendación |
|----|----------------|-----------|---------------|--------------|
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR]/18 | [COMPLETAR] | [COMPLETAR] |
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR]/18 | [COMPLETAR] | [COMPLETAR] |

---

## Factores de Riesgo Adicionales

| Factor | Personalizaciones afectadas | Descripción del riesgo |
|--------|---------------------------|----------------------|
| DotNet interop / COM automation | [COMPLETAR] | Incompatible con SaaS; requiere Azure Functions u otra solución cloud |
| Acceso directo a SQL | [COMPLETAR] | No permitido en SaaS; usar AL queries o APIs |
| NAS / Scheduled Tasks | [COMPLETAR] | Reemplazar con Job Queue nativos de BC o Azure Functions |
| Report Builder custom controls | [COMPLETAR] | Revisar compatibilidad RDLC/Word layouts en BC |
| Add-ins de cliente | [COMPLETAR] | Control Add-ins deben ser JavaScript; revisar compatibilidad |

---

*Referencia: [AL Language Compatibility](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-al-compatibility)*

---

## Entrada inicial desde inventario diferencial

Para arrancar el scoring con datos reales, usar:

- `upgrade-project/01-assessment/tools/output/differential-inventory.csv`

Regla de arranque sugerida (baseline):

| Señal en baseline | Riesgo inicial |
|---|---|
| DotNet / Automation / COM detectado | 🔴 Alta |
| Modified Standard Object en Codeunit/Table/MenuSuite | 🔴 Alta |
| Modified Standard Object (resto) | 🟡 Media |
| New Customer Object (50000+) | 🟡 Media |
| Unchanged | 🟢 Baja |

> El riesgo inicial debe ajustarse con análisis funcional, dependencias y volumen de datos antes de estimación final.
