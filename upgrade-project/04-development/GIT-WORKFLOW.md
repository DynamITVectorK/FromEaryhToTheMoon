# Git Workflow del Proyecto

> **Versión:** 1.0 | **Responsable:** Líder Técnico

## Estrategia de Ramas
```
main          ← producción (protegida)
develop       ← integración continua
feature/XXXX  ← desarrollo de objeto/funcionalidad
fix/XXXX      ← corrección de defecto
release/vX.X  ← preparación de release para UAT/Prod
```

## Flujo de Trabajo
1. Crear rama desde `develop`: `git checkout -b feature/T001-customer-ext`
2. Desarrollar y probar en sandbox DEV
3. Commit con mensaje descriptivo: `feat: Add [PREFIX] Category field to Customer`
4. Pull Request a `develop` → Code Review obligatorio
5. Aprobación → Merge a `develop` → Deploy automático a QA
6. Release candidate → rama `release/vX.X` → Deploy a UAT
7. UAT aprobado → Merge a `main` → Deploy a Producción

## Convenciones de Commit
```
feat: nueva funcionalidad
fix: corrección de bug
refactor: refactorización sin cambio funcional
docs: documentación
test: tests
chore: tareas de mantenimiento
```

## Ramas Protegidas
- `main`: requiere PR + 2 aprobaciones + CI green
- `develop`: requiere PR + 1 aprobación

**Referencia:** [AL Dev in VS Code](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/devenv-dev-overview)
