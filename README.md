# FromEarthToTheMoon · NAV 2016 → Business Central SaaS

Repositorio para la migración de **Microsoft Dynamics NAV 2016** a **Dynamics 365 Business Central SaaS** y para el desarrollo de extensiones AL asociadas al proyecto.

## Objetivo del repositorio

Este repo combina dos ámbitos:

1. **Código AL de la extensión** (carpeta `src/`), actualmente con un ejemplo inicial.
2. **Gobierno y ejecución del upgrade** (carpeta `upgrade-project/`), con documentación de gestión, arquitectura, conversión, migración de datos, testing y cutover.

## Contenido principal

- `src/`: objetos AL de la extensión.
- `app.json`: metadatos de la app (`HolaMundoClientes`, publisher `FromEarthToTheMoon`).
- `upgrade-project/`: documentación del proyecto de migración NAV → BC SaaS.
- `issue-upgrade-nav2016-a-saas.md`: documento de contexto del issue/propuesta de upgrade.

## Estado actual de la documentación

✅ Existe documentación amplia para:
- Gestión del proyecto (`00-project-management`)
- Assessment (`01-assessment`)
- Arquitectura (`02-architecture`)
- Conversión C/AL → AL (`03-conversion`)
- Desarrollo (`04-development`)
- Migración de datos (`05-data-migration`)
- Testing/UAT (`06-testing`)
- Cutover (`07-cutover`)

⚠️ Se detectó que en `upgrade-project/README.md` se referencia la fase **08-training**, pero faltaba la carpeta y su documentación base. Ya se ha añadido una estructura inicial en este repositorio (ver sección siguiente).

## Documentación añadida en esta revisión

Se incorporó una base de documentación para capacitación:

- `upgrade-project/08-training/README.md`
- `upgrade-project/08-training/TRAINING-PLAN.md`
- `upgrade-project/08-training/SUPER-USER-GUIDE.md`

## Cómo empezar rápido

### Desarrollo AL

1. Instalar Visual Studio Code + extensión **AL Language**.
2. Revisar `app.json` para identificar versión/rangos.
3. Compilar/publicar en sandbox de Business Central según tu pipeline.

### Proyecto de migración

1. Leer `upgrade-project/README.md`.
2. Revisar alcance (`00-project-management/SCOPE.md`) y riesgos (`00-project-management/RISKS.md`).
3. Priorizar backlog técnico con `01-assessment` + `03-conversion`.

## Próximos pasos recomendados (30-60-90 días)

Para continuar con una ejecución pragmática del proyecto, se añadió una hoja de ruta operativa:

- `upgrade-project/00-project-management/NEXT-STEPS-90-DAYS.md`

## CI/CD (AL-Go)

El repositorio mantiene estructura compatible con AL-Go.  
Si desplegáis a un entorno `Sandbox` vía GitHub Actions:

- Crear Environment `Sandbox`.
- Configurar secreto de autenticación (`Sandbox-AuthContext`, `Sandbox_AuthContext` o `AuthContext`).
- Opcional: variable `ALGoEnvironmentSettings`.

Más información: https://aka.ms/AL-Go
