
# ⚠️ Actividad 6.31 – Limitaciones y riesgos de GitHub Copilot

> Copilot acelera el trabajo, pero no es infalible: puede alucinar, proponer código inseguro, no entender bien tu contexto o facilitar trampas en contexto educativo.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Describir las principales **limitaciones técnicas** de Copilot (contexto, precisión, “alucinaciones”).
- Reconocer riesgos de **seguridad, licencias y privacidad** en código sugerido por IA.
- Analizar riesgos en contexto educativo (posible “cheating”) y proponer medidas.

---

## 🧩 Parte 1 – Recoger ejemplos de problemas reales

### Reto 1.1 – Casos documentados de limitaciones

1. Investiga (puede ser con artículos, discusiones o documentación oficial) al menos **tres tipos de limitaciones** de Copilot, por ejemplo:
   - Limitaciones de contexto: solo ve ciertos archivos abiertos, no todo el sistema.
   - Alucinaciones: inventa APIs, funciones o explicaciones que no existen.
   - Sugerencias con vulnerabilidades de seguridad.

2. Crea `cp1-casos-limitaciones.txt` con:
   - 3–5 casos concretos que hayas encontrado, cada uno con 1–2 frases de explicación (no pegues artículos enteros).

---

## 🧩 Parte 2 – Experimento práctico: “alucinaciones” y contexto limitado

### Reto 2.1 – Forzar y detectar una alucinación

1. En un repositorio tuyo, escribe una pregunta o comentario para Copilot Chat del tipo:

   > “Explícame por qué falla esta función y dime en qué archivo está la definición de `X`.”

   cuando `X` **no existe** realmente en el repositorio, o está en un fichero que no has abierto.

2. Observa si Copilot:
   - Se inventa una ubicación.
   - Supone cómo podría ser la función.

3. Haz un segundo intento dándole más contexto (abre más archivos, copia el código relevante) y compara la respuesta.

### Checkpoint 2 – Evidencia

- Crea `cp2-alucinaciones-contexto.txt` con:
  - La pregunta inicial que usaste.
  - Descripción de la “alucinación” o error de Copilot (si ocurrió).
  - Qué mejoró al darle más contexto y qué sigue siendo limitado.

---

## 🧩 Parte 3 – Riesgos de seguridad y calidad del código

### Reto 3.1 – Analizar sugerencias potencialmente inseguras

1. Elige un problema típico (por ejemplo, construir una consulta a base de datos, manejar contraseñas, llamar a comandos del sistema).

2. Pide a Copilot que escriba la función correspondiente.

3. Revisa el código generado buscando riesgos conocidos, por ejemplo:
   - Concatenar parámetros de usuario en SQL sin sanitizar (inyección).
   - Usar comandos del sistema sin validar entrada (command injection).
   - Usar librerías obsoletas con CVEs conocidos.

4. Si puedes, pasa el snippet por un linter/analizador estático de seguridad (SAST) o revisa manualmente con una checklist.

### Checkpoint 3 – Evidencia

- Crea `cp3-riesgos-seguridad.txt` con:
  - Descripción del snippet generado (en qué contexto).
  - Riesgos de seguridad o calidad que has identificado, apoyándote en lo que dicen estudios/artículos (porcentaje de snippets inseguros, tipos de CWE frecuentes).

---

## 🧩 Parte 4 – Licencias, propiedad intelectual y privacidad

### Reto 4.1 – Analizar riesgos legales y de confidencialidad

1. Investiga qué preocupaciones se han planteado sobre:
   - Posibles fragmentos demasiado parecidos a código con licencia restrictiva.
   - Demandas o debates legales sobre Copilot y licencias de OSS.
   - Filtrado de secretos y datos sensibles en repos que usan Copilot (tokens, claves, etc.).

2. Crea `cp4-licencias-y-privacidad.txt` con:
   - 2–3 riesgos legales/éticos que hayas encontrado (licencias, “software piracy”, etc.).
   - 2–3 recomendaciones para mitigarlos (revisar snippets largos, políticas internas, escáner de secretos, etc.).

---

## 🧩 Parte 5 – Educación: ¿Copilot como “trampa” en programación?

### Reto 5.1 – Analizar el riesgo de “cheating”

1. Revisa opiniones de profesorado y artículos sobre el uso de Copilot en asignaturas de programación (p.ej. “Copilot may be perfect for cheating programming exercises”).

2. Identifica situaciones típicas de riesgo, por ejemplo:
   - Estudiantes que entregan código generado casi al 100% por Copilot sin entenderlo.
   - Tareas tradicionales que ya no distinguen entre comprensión y copia.

3. Crea `cp5-riesgos-educativos.txt` con:
   - 3 ejemplos concretos de cómo Copilot podría facilitar trampas o aprendizaje superficial.
   - 3 ideas para rediseñar actividades o evaluación para mitigarlo (defensas orales, ejercicios en vivo, foco en explicación, etc.).

---

## 🧩 Parte 6 – Síntesis: mapa de limitaciones y estrategias

### Reto 6.1 – Mapa de “limitaciones → estrategia”

1. Crea `mapa-limitaciones-copilot.md` con una tabla con columnas:

   - Tipo de limitación (técnica, seguridad, legal, educativa).
   - Descripción breve del problema.
   - Estrategia concreta para mitigarla (tests, revisión humana, políticas, rediseño de tareas, etc.).

2. Asegúrate de incluir al menos:
   - Alucinaciones y contexto limitado.
   - Código potencialmente inseguro o con librerías vulnerables.
   - Riesgos de licencias/propiedad intelectual.
   - Riesgos educativos/cheating.

---

## 🧩 Parte 7 – Reflexión final: cuándo NO usar Copilot

Crea `reflexion-6-31.md` y responde:

1. Enumera 3 situaciones en las que **decides no usar Copilot** o limitarlo al máximo (ejemplos: código de seguridad crítica, exámenes, partes del temario donde quieres practicar de cero).
2. ¿Qué señales te harían desconfiar de una sugerencia concreta (demasiado compleja, no encaja con tu stack, usa APIs inexistentes, etc.)?
3. Como docente o mentor, ¿cómo explicarías a tu alumnado que conocer las limitaciones de Copilot es tan importante como conocer sus ventajas?

---

## 📦 Entrega esperada en el repositorio

En `actividad-6-31-copilot-limitaciones` (o repo que uses) deben aparecer:

- `cp1-casos-limitaciones.txt`
- `cp2-alucinaciones-contexto.txt`
- `cp3-riesgos-seguridad.txt`
- `cp4-licencias-y-privacidad.txt`
- `cp5-riesgos-educativos.txt`
- `mapa-limitaciones-copilot.md`
- `reflexion-6-31.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Identificación clara y documentada de limitaciones técnicas, de seguridad, legales y educativas.
- 3 pts – Propuestas de mitigación realistas en `mapa-limitaciones-copilot.md`.
- 3 pts – Profundidad y sentido crítico en `reflexion-6-31.md`.

**Puntuación máxima: 10 puntos.**

---