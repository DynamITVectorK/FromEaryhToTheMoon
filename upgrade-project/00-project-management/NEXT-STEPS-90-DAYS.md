# Roadmap de Ejecución (30-60-90 días)

Documento táctico para pasar de la fase documental al arranque real de ejecución del upgrade NAV 2016 → Business Central SaaS.

---

## Principios de ejecución

1. **Primero reducir riesgo**, después acelerar conversión.
2. **Trazabilidad completa** entre objeto NAV, decisión de diseño y resultado en AL.
3. **Entrega incremental**: cada bloque debe dejar evidencia verificable.

---

## Horizonte 0-30 días (Aterrizaje y baseline)

### Objetivos
- Cerrar pendientes críticos de assessment.
- Congelar alcance de MVP para go-live inicial.
- Dejar entorno técnico listo para desarrollo y pruebas.

### Acciones
- Completar campos `[COMPLETAR]` en:
  - `PROJECT_CHARTER.md`
  - `SCOPE.md`
  - `TIMELINE.md`
  - `STAKEHOLDERS.md`
- Finalizar inventario de objetos y clasificar por complejidad/criticidad.
- Definir lista cerrada de integraciones en alcance de fase 1.
- Validar estrategia de datos y reglas de cleansing.
- Definir criterio de “listo para convertir” por objeto.

### Entregables de salida
- Scope firmado y priorizado (Must/Should/Could).
- Backlog técnico inicial con owners y fechas.
- Entornos y pipeline CI/CD operativos.

---

## Horizonte 31-60 días (Conversión y pruebas tempranas)

### Objetivos
- Ejecutar primeras conversiones AL de valor.
- Probar extremo a extremo procesos críticos.
- Reducir incertidumbre técnica en integraciones.

### Acciones
- Convertir y revisar primer lote de objetos prioritarios.
- Ejecutar code reviews con checklist de AL standards.
- Preparar datos de prueba representativos.
- Correr pruebas funcionales internas sobre escenarios clave (finanzas, ventas, compras).
- Lanzar UAT piloto con super users.

### Entregables de salida
- Primer paquete AL funcional en sandbox.
- Matriz de incidencias (severidad, owner, ETA).
- Lecciones aprendidas para ajustar estándares y estimaciones.

---

## Horizonte 61-90 días (Estabilización y preparación de cutover)

### Objetivos
- Asegurar calidad para preproducción/go-live.
- Cerrar plan operativo de cutover y rollback.
- Formar usuarios clave y plan de soporte.

### Acciones
- Ejecutar plan de pruebas completo + regresión.
- Cerrar brechas críticas de migración de datos.
- Simular cutover (mock run) con checklist real.
- Ejecutar plan de formación y validar adopción mínima.
- Formalizar modelo de soporte post-go-live (hiper-cuidado).

### Entregables de salida
- Go/No-Go pack con riesgos residuales.
- Cutover checklist validado.
- Equipo de super users habilitado.

---

## KPIs de control sugeridos

- % objetos priorizados convertidos y aprobados.
- % escenarios UAT ejecutados / aprobados.
- Nº incidencias críticas abiertas por semana.
- % usuarios clave formados.
- Cumplimiento de hitos vs cronograma.

---

## Riesgos inmediatos a vigilar

1. Alcance cambiante sin control de cambios.
2. Dependencias externas no preparadas (integraciones, terceros).
3. Calidad de datos histórica insuficiente para migración limpia.
4. Baja disponibilidad de usuarios clave para UAT/formación.

---

## Siguiente hito recomendado

**En los próximos 7 días**: cerrar un workshop de priorización (negocio + IT) y publicar backlog v1 con fechas, responsables y criterios de aceptación por bloque.
