
# 🛡️ Actividad 6.32 – Cómo mitigar vulnerabilidades de GitHub Copilot

> Copilot puede introducir código inseguro, filtrar secretos o generar dependencias vulnerables si lo usamos sin controles.
> En esta actividad diseñarás y probarás un “escudo” de buenas prácticas, herramientas y políticas para usar Copilot con seguridad.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Tratar las sugerencias de Copilot como código **no fiable** y someterlas a análisis de seguridad y calidad.
- Configurar el repositorio y el entorno (secret scanning, Dependabot, reglas de rama, etc.) para reducir riesgos.
- Definir reglas y “instrucciones de seguridad” para Copilot en tu equipo o aula.

---

## 🧩 Parte 1 – Punto de partida: identificar riesgos concretos

### Reto 1.1 – Seleccionar dos escenarios de riesgo

1. Elige **dos** tipos de riesgo a trabajar en tu repositorio de ejemplo (puede ser un proyecto web pequeño):

   - Riesgo A: **código inseguro** generado por Copilot (inyecciones, crypto insegura, auth, etc.).
   - Riesgo B: **secretos** (tokens, contraseñas) expuestos en el código o en prompts.

2. En `cp1-escenarios-riesgo.txt` describe:
   - El proyecto que usarás (tecnología, tipo de app).
   - Qué te preocupa exactamente en cada riesgo (ej.: SQL injection, JWT mal configurado, API keys en `.js`).

---

## 🧩 Parte 2 – Tratar código de Copilot como no confiable

### Reto 2.1 – Pipeline de revisión y escaneo

1. Toma una función generada por Copilot que toque algo sensible (input usuario, BD, red, autenticación).

2. Define un pequeño **pipeline local** para revisar cualquier snippet generado por Copilot:

   - Paso 1: Revisión manual con checklist (validación de entrada, uso de librerías estándar, nada de “desactivar seguridad”).
   - Paso 2: Análisis estático con una herramienta (por ejemplo, ESLint con plugins de seguridad, Semgrep, Bandit, etc.).
   - Paso 3: Tests unitarios incluyendo casos negativos (inputs maliciosos, datos inesperados).

3. Crea `cp2-pipeline-revision.txt` con:
   - La función elegida.
   - La checklist que aplicarás siempre.
   - Resultados de pasarla por tu herramienta de análisis (si puedes) y de los tests.

---

## 🧩 Parte 3 – Configurar el repositorio para reducir riesgos

### Reto 3.1 – Activar controles en GitHub

En tu repositorio, habilita (o documenta cómo lo harías) estos controles esenciales:

1. **Secret scanning** y **Push protection** (GitHub Advanced Security o equivalente).
2. **Dependabot alerts** y **Dependabot security updates** para dependencias.
3. **Branch protection rules** para exigir:
   - Revisiones de código antes de merge.
   - Checks de CI (tests, linters, SAST) obligatorios.

4. Documenta la configuración (aunque no tengas acceso a todas las funciones en tu cuenta).

En `cp3-controles-repo.txt` anota:

- Qué controles has activado o descrito.
- Cómo ayudan a mitigar los riesgos A y B de la Parte 1.

---

## 🧩 Parte 4 – Secretos y privacidad: higiene con Copilot

### Reto 4.1 – Proteger secretos en código y en prompts

1. Revisa tu proyecto y simula que aparece un secreto hardcodeado (ej.: una API key en un archivo).

2. Aplica un **plan de mitigación** siguiendo buenas prácticas:

   - Eliminar el secreto del código.
   - Rotar la credencial si era real.
   - Moverla a variables de entorno y usar un gestor de secretos.
   - Añadir secret scanning local con una herramienta tipo GitGuardian CLI, TruffleHog o similar.

3. Define reglas personales para prompts de Copilot:

   - No pegar nunca claves, tokens, datos de alumnos o clientes.
   - Usar ejemplos ficticios o anonimizar datos.

En `cp4-secretos-y-privacidad.txt` explica:

- Cómo gestionarías un secreto que ya ha llegado al repo.
- Tus reglas para evitar filtrar datos sensibles en Copilot Chat o en el contexto de la IA.

---

## 🧩 Parte 5 – Reglas de seguridad para Copilot (rules file / instrucciones)

### Reto 5.1 – Crear “instrucciones de seguridad” para la IA

Inspirándote en guías de seguridad para asistentes de código:

1. Crea un archivo `copilot-security-rules.md` que recoja instrucciones para la IA y para el desarrollador, por ejemplo:

   - “Nunca propongas desactivar validaciones de entrada o comprobaciones de seguridad.”
   - “Usa siempre librerías estándar y seguras para crypto, no reinventes algoritmos.”
   - “Genera tests adicionales para funciones críticas (auth, pagos, gestión de datos personales).”
   - “Evita sugerir logging de datos sensibles en texto plano.”

2. Estas reglas pueden convertirse en un “rules file” que pegues en Copilot Chat al iniciar trabajo en un repo, o en documentación para tu alumnado/equipo.

### Checkpoint 5 – Evidencia

- El propio `copilot-security-rules.md` será la evidencia.

---

## 🧩 Parte 6 – Integrar mitigaciones en el flujo CI/CD

### Reto 6.1 – Añadir escaneos de seguridad a GitHub Actions

1. Si tu proyecto ya tiene CI, añade pasos para:

   - Ejecutar linters / Semgrep / ESLint con reglas de seguridad.
   - Ejecutar un SCA (análisis de dependencias) para detectar CVEs.

2. Asegúrate de que el workflow **falla** si se encuentran vulnerabilidades graves.

3. En `cp6-ci-seguro.txt` describe:

   - Extracto relevante del YAML del workflow (no hace falta completo).
   - Qué herramientas se ejecutan y qué tipo de problemas pueden detectar.

---

## 🧩 Parte 7 – Reflexión final: modelo de “cinturón de seguridad” para Copilot

Crea `reflexion-6-32.md` y responde:

1. Resume tu “cinturón de seguridad Copilot” en 5 puntos: qué haces **antes**, **durante** y **después** de aceptar una sugerencia.
2. ¿Qué controles implementarías de forma obligatoria si fueras responsable de un departamento de desarrollo que usa Copilot (formación, configuración, herramientas, políticas)?
3. ¿Cómo adaptarías estas prácticas a un contexto educativo (FP / universidad) para que el alumnado aprenda seguridad desde el principio usando IA?

---

## 📦 Entrega esperada en el repositorio

En `actividad-6-32-mitigacion-vulnerabilidades-copilot` (o repo que uses) deben aparecer:

- `cp1-escenarios-riesgo.txt`
- `cp2-pipeline-revision.txt`
- `cp3-controles-repo.txt`
- `cp4-secretos-y-privacidad.txt`
- `copilot-security-rules.md`
- `cp6-ci-seguro.txt`
- `reflexion-6-32.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Diseño coherente de medidas técnicas y de proceso para mitigar riesgos de Copilot.
- 3 pts – Integración de controles en repositorio y CI (secret scanning, SAST/SCA, branch protection).
- 3 pts – Profundidad y aplicabilidad de la reflexión en `reflexion-6-32.md`.

**Puntuación máxima: 10 puntos.**

---