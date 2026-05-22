# Documento de Alcance del Proyecto

> **Versión:** 1.0 | **Fecha:** [COMPLETAR] | **Aprobado por:** [COMPLETAR]

---

## 1. Propósito

Este documento define de manera exhaustiva el alcance del proyecto de migración de Microsoft Dynamics NAV 2016 a Business Central SaaS, estableciendo límites claros entre lo que está incluido y excluido del proyecto, los criterios de aceptación y el proceso de gestión de cambios.

---

## 2. En Alcance

### 2.1 Módulos Funcionales

| Módulo | Subcomponentes | Prioridad |
|--------|---------------|-----------|
| **Finanzas (Finance)** | Plan de cuentas, Contabilidad general, Cuentas por pagar, Cuentas por cobrar, Activos fijos, Tesorería | Alta |
| **Ventas (Sales & Marketing)** | Clientes, Cotizaciones, Pedidos, Albaranes, Facturas, Abonos, Devoluciones | Alta |
| **Compras (Purchase)** | Proveedores, Solicitudes, Pedidos, Recepciones, Facturas, Devoluciones | Alta |
| **Inventario (Inventory)** | Artículos, Almacenes, Ajustes, Traspasos, Valoración de inventario | Alta |
| **[COMPLETAR]** | [COMPLETAR] | [COMPLETAR] |

### 2.2 Personalizaciones

- Conversión de todos los objetos C/AL con clasificación **Alta** y **Media** prioridad del inventario
- Los objetos de prioridad **Baja** serán evaluados individualmente
- Reescritura completa de tablas, páginas, codeunits y reportes personalizados documentados en el catálogo de personalizaciones
- **Referencia:** [Catálogo de Personalizaciones](../01-assessment/CUSTOMIZATIONS-CATALOG.md)

### 2.3 Integraciones

Los siguientes sistemas de integración están en alcance para rediseño compatible con BC SaaS:

| Sistema Externo | Tipo Actual | Estrategia BC SaaS |
|----------------|-------------|-------------------|
| [COMPLETAR] | [COMPLETAR] | API REST / Power Automate |
| [COMPLETAR] | [COMPLETAR] | Azure Logic Apps |
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |

### 2.4 Migración de Datos

- **Datos maestros:** Clientes, Proveedores, Artículos, Plan de Cuentas, Dimensiones, Recursos
- **Datos transaccionales:** Saldos abiertos de CxC, CxP e Inventario a fecha de corte
- **Datos históricos:** [COMPLETAR - especificar años] de historial transaccional (según viabilidad)
- **Parámetros de configuración:** Configuración de la empresa, series de números, grupos de registro

### 2.5 Capacitación

- Capacitación a [COMPLETAR] usuarios finales organizados por rol/módulo
- Capacitación especializada a [COMPLETAR] super usuarios por módulo
- Capacitación técnica a [COMPLETAR] administradores del sistema
- Creación de materiales de capacitación adaptados al cliente

---

## 3. Fuera de Alcance

> ⚠️ **Las siguientes áreas están explícitamente excluidas del proyecto:**

| Ítem Fuera de Alcance | Razón | Posible Proyecto Futuro |
|----------------------|-------|------------------------|
| Implementación de módulos nuevos (ej: Manufacturing, Service, Warehouse avanzado) | No existentes en NAV 2016 actual | Sí, fase posterior |
| Personalización adicional más allá de paridad funcional | Fuera del presupuesto aprobado | A definir |
| Migración de datos anteriores al [COMPLETAR - año] | Volumen excesivo, bajo valor | Archivo histórico separado |
| Desarrollo de reportes nuevos | Fuera del alcance acordado | A evaluar |
| Integración con sistemas no documentados en el catálogo | Sin análisis disponible | A evaluar |
| Cambio de procesos de negocio (BPR) | Proyecto separado recomendado | Recomendado post go-live |
| Migración a On-Premise o Private Cloud | Decisión de SaaS ya tomada | N/A |

---

## 4. Criterios de Aceptación

### 4.1 Criterios Funcionales
- Todos los procesos de negocio documentados en el alcance funcionan correctamente en BC SaaS
- Escenarios UAT ejecutados con resultado ≥ [COMPLETAR]% de casos aprobados
- Cero defectos de severidad Crítica en el momento del go-live
- Máximo [COMPLETAR] defectos de severidad Alta en go-live (con plan de resolución < 5 días)

### 4.2 Criterios de Datos
- Reconciliación de saldos contables entre NAV 2016 y BC SaaS con diferencia cero
- Todos los datos maestros migrados y validados por usuarios clave
- Saldos pendientes de CxC y CxP reconciliados al 100%

### 4.3 Criterios Técnicos
- Todas las extensiones AL desplegadas sin errores en el entorno de producción BC SaaS
- Tiempo de respuesta de páginas principales ≤ [COMPLETAR] segundos
- Integraciones funcionando en entorno de producción

### 4.4 Criterios de Capacitación
- 100% de usuarios finales en alcance han completado la capacitación
- Evaluaciones de capacitación con puntaje promedio ≥ [COMPLETAR]%

---

## 5. Gestión de Cambios de Alcance

### 5.1 Proceso de Solicitud de Cambio

```
1. Identificación → 2. Documentación → 3. Análisis de Impacto → 4. Aprobación → 5. Implementación
```

| Paso | Responsable | Herramienta | SLA |
|------|-------------|-------------|-----|
| Identificar y documentar cambio | Cualquier miembro del equipo | Formulario de cambio | N/A |
| Analizar impacto (tiempo, costo, riesgo) | Gerente de Proyecto + Líder Técnico | Estimación formal | 3 días hábiles |
| Aprobar o rechazar | Patrocinador Ejecutivo | Email/reunión | 5 días hábiles |
| Comunicar decisión | Gerente de Proyecto | Email a equipo | 1 día hábil |
| Implementar si aprobado | Equipo técnico/funcional | Plan actualizado | Según impacto |

### 5.2 Niveles de Aprobación

| Impacto del Cambio | Nivel de Aprobación Requerido |
|-------------------|------------------------------|
| Menor (< [COMPLETAR] horas esfuerzo, sin impacto en fechas) | Gerente de Proyecto |
| Moderado ([COMPLETAR]-[COMPLETAR] horas, posible impacto en fechas) | Gerente de Proyecto + Patrocinador |
| Mayor (> [COMPLETAR] horas, impacto en fechas o presupuesto) | Comité de Dirección |

---

*Referencia: [Business Central Feature Availability](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/features-not-implemented-on-premises)*
