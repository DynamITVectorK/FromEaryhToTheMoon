# Project Charter: Upgrade NAV 2016 → Business Central SaaS

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Estado:** [COMPLETAR - Borrador/Aprobado]

---

## 1. Propósito

El presente Project Charter establece el marco formal para la ejecución del proyecto de migración de Microsoft Dynamics NAV 2016 a Microsoft Dynamics 365 Business Central SaaS. Este documento autoriza al equipo de proyecto a utilizar los recursos organizacionales necesarios para alcanzar los objetivos definidos.

---

## 2. Descripción del Proyecto

| Campo | Detalle |
|-------|---------|
| **Nombre del proyecto** | Upgrade NAV 2016 → Business Central SaaS |
| **Organización** | [COMPLETAR] |
| **Fecha de inicio** | [COMPLETAR] |
| **Fecha estimada de finalización** | [COMPLETAR] |
| **Versión origen** | Microsoft Dynamics NAV 2016 (v9.0) |
| **Versión destino** | Microsoft Dynamics 365 Business Central SaaS (última versión estable) |
| **Tipo de proyecto** | Upgrade/Migración de ERP |

La migración implica la conversión del código C/AL personalizado a extensiones AL, la migración de datos históricos, la redefinición de integraciones con sistemas externos y la capacitación de todos los usuarios en la nueva plataforma en la nube.

---

## 3. Objetivos del Proyecto

### Objetivos de Negocio
1. Asegurar la continuidad del soporte técnico de Microsoft (NAV 2016 fuera de mainstream support desde 2022)
2. Aprovechar las actualizaciones automáticas de Business Central SaaS (2 major releases/año)
3. Reducir costos de infraestructura on-premise eliminando servidores dedicados
4. Habilitar el acceso remoto nativo desde cualquier dispositivo

### Objetivos Técnicos
1. Convertir [COMPLETAR] objetos C/AL a extensiones AL compatibles con SaaS
2. Migrar [COMPLETAR]% de los datos históricos con integridad validada
3. Rediseñar [COMPLETAR] integraciones usando APIs estándar o Azure Integration Services
4. Lograr tiempo de inactividad máximo de [COMPLETAR] horas durante el cutover

### Objetivos de Adopción
1. Capacitar al 100% de los usuarios antes del go-live
2. Alcanzar [COMPLETAR]% de satisfacción de usuarios en encuesta post go-live
3. Reducir tickets de soporte en un [COMPLETAR]% respecto a NAV 2016 a los 3 meses

---

## 4. Alcance del Proyecto

### En Alcance
- Módulos funcionales: [COMPLETAR - Finanzas, Ventas, Compras, Inventario, etc.]
- Conversión de [COMPLETAR] objetos C/AL personalizados
- Migración de datos maestros e históricos de [COMPLETAR] años
- [COMPLETAR] integraciones con sistemas externos
- Capacitación a [COMPLETAR] usuarios
- Documentación técnica y funcional

### Fuera de Alcance
- Implementación de nuevos módulos no existentes en NAV 2016
- Personalización adicional más allá de la paridad funcional con NAV 2016
- Migración de datos anteriores a [COMPLETAR - año límite]
- Integración con sistemas no contemplados en el catálogo de integraciones

---

## 5. Supuestos del Proyecto

1. La organización tiene licencias de Business Central SaaS válidas o las adquirirá antes del inicio
2. Existe acceso completo a la base de datos de NAV 2016 para extracción de datos y análisis
3. Los usuarios clave estarán disponibles para UAT según el cronograma acordado
4. La infraestructura de red permite acceso a servicios cloud de Microsoft
5. Existe código fuente completo (objetos C/AL) del sistema NAV 2016 actual
6. [COMPLETAR - supuestos adicionales]

---

## 6. Restricciones del Proyecto

| Restricción | Descripción | Impacto |
|-------------|-------------|---------|
| **Presupuesto** | Presupuesto fijo de [COMPLETAR] | Priorización de funcionalidades |
| **Tiempo** | Fecha límite de go-live [COMPLETAR] | Gestión de alcance |
| **Recursos** | [COMPLETAR] desarrolladores AL disponibles | Velocidad de conversión |
| **Tecnología** | No se permiten DotNet Add-ins en SaaS | Rediseño de integraciones |
| **Ventana de mantenimiento** | Máximo [COMPLETAR] horas de downtime | Plan de cutover crítico |

---

## 7. Riesgos Principales

| Riesgo | Probabilidad | Impacto | Mitigación |
|--------|-------------|---------|-----------|
| Complejidad subestimada de personalizaciones | Alta | Alto | Assessment exhaustivo en fase 1 |
| Funcionalidades no disponibles en SaaS | Media | Alto | GAP analysis temprano, plan de alternativas |
| Resistencia al cambio de usuarios | Media | Medio | Plan de gestión del cambio robusto |
| Calidad de datos insuficiente para migración | Alta | Alto | Cleansing de datos anticipado |
| Integraciones incompatibles con SaaS | Media | Alto | Arquitectura de integración rediseñada |

Ver registro completo en: [RISKS.md](RISKS.md)

---

## 8. Partes Interesadas

| Nombre | Rol | Organización | Contacto |
|--------|-----|-------------|---------|
| [COMPLETAR] | Patrocinador ejecutivo | [COMPLETAR] | [COMPLETAR] |
| [COMPLETAR] | Gerente de proyecto | [COMPLETAR] | [COMPLETAR] |
| [COMPLETAR] | Líder técnico | [COMPLETAR] | [COMPLETAR] |
| [COMPLETAR] | Líder funcional | [COMPLETAR] | [COMPLETAR] |

Ver registro completo en: [STAKEHOLDERS.md](STAKEHOLDERS.md)

---

## 9. Presupuesto Estimado

| Categoría | Monto Estimado | Notas |
|-----------|----------------|-------|
| Licencias BC SaaS (1er año) | [COMPLETAR] | Incluye [COMPLETAR] usuarios |
| Servicios de implementación | [COMPLETAR] | Consultoría + desarrollo |
| Infraestructura temporal | [COMPLETAR] | Durante período de transición |
| Capacitación | [COMPLETAR] | |
| Contingencia (15%) | [COMPLETAR] | |
| **Total estimado** | **[COMPLETAR]** | |

---

## 10. Patrocinador y Gerente de Proyecto

| Rol | Nombre | Responsabilidades |
|-----|--------|------------------|
| **Patrocinador Ejecutivo** | [COMPLETAR] | Aprobación de recursos, resolución de escalaciones, comunicación C-level |
| **Gerente de Proyecto** | [COMPLETAR] | Gestión diaria, reportes de estado, gestión de riesgos e issues |
| **Líder Técnico** | [COMPLETAR] | Decisiones de arquitectura, revisión de código, resolución de bloqueos técnicos |
| **Líder Funcional** | [COMPLETAR] | Validación funcional, coordinación UAT, gestión de usuarios clave |

---

## 11. Criterios de Éxito

- [ ] 100% de módulos en alcance funcionando en BC SaaS en fecha de go-live
- [ ] Migración de datos con tasa de error < [COMPLETAR]%
- [ ] Tiempo de inactividad durante cutover ≤ [COMPLETAR] horas
- [ ] 100% de usuarios capacitados antes del go-live
- [ ] 0 defectos críticos abiertos en el momento del go-live
- [ ] Satisfacción de usuarios ≥ [COMPLETAR]% en encuesta post go-live (30 días)
- [ ] Cierre financiero exitoso del primer mes en BC SaaS

---

## 12. Firmas de Aprobación

| Nombre | Rol | Firma | Fecha |
|--------|-----|-------|-------|
| [COMPLETAR] | Patrocinador Ejecutivo | _________________ | [COMPLETAR] |
| [COMPLETAR] | Gerente de Proyecto | _________________ | [COMPLETAR] |
| [COMPLETAR] | Director de TI | _________________ | [COMPLETAR] |
| [COMPLETAR] | Director Financiero | _________________ | [COMPLETAR] |

---

*Referencia oficial: [Business Central upgrade documentation](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/upgrade/upgrade-overview-v21)*
