
# 🔍 Actividad 6.21 – Revisión de código en Pull Requests

> En la actividad 6.20 has practicado crear PRs.
> Ahora vas a ponerte el sombrero de **revisor**: revisarás cambios, usarás comentarios y aplicarás una checklist de revisión.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Revisar una Pull Request leyendo contexto, cambios y tests antes de decidir.
- Aplicar una checklist básica de revisión (funcionalidad, estilo, claridad, tests, impacto).
- Dar feedback claro, concreto y respetuoso (comentarios, sugerencias, “approve” vs “request changes”).

---

## 🧩 Parte 1 – Preparar PRs para revisar

### Reto 1.1 – Reusar o crear PRs de práctica

Puedes usar:

- Las PRs de la Actividad 6.20, o
- Nuevas PRs en un repo de prueba (por ejemplo, `actividad-6-21-revision-pr`).

Asegúrate de tener **al menos 2 PRs** activas para revisar:

1. Una PR “simple” (pocos cambios, sobre documentación o pequeños ajustes).
2. Una PR con algo más de código (funcionalidad nueva o refactor).

Crea `cp1-prs-a-revisar.txt` con:

- URLs de las PRs que vas a revisar.
- Breve descripción del tipo de cambio en cada una.

---

## 🧩 Parte 2 – Leer contexto antes de mirar código

### Reto 2.1 – Entender la PR antes de juzgar el diff

Para cada PR:

1. Lee el **título** y la **descripción** completos.
2. Comprueba:
   - Qué problema resuelve.
   - Qué cambios principales incluye.
   - Cómo se supone que debes probarlo (si lo indica).

3. Mira el estado de checks/CI (si el repo los tiene configurados).

En `cp2-contexto-pr.txt`, para cada PR, anota:

- Resumen del objetivo de la PR (1–2 frases).
- Preguntas abiertas que te surgen antes de ver el código (si las hay).

---

## 🧩 Parte 3 – Aplicar una checklist de revisión

### Reto 3.1 – Revisar con una checklist simple

Define una checklist basada en guías de buenas prácticas:

- Funcionalidad:
  - ¿Hace lo que dice la descripción?
  - ¿Considera casos límite/edge cases?
- Calidad del código:
  - ¿Es legible, con nombres claros y sin duplicación innecesaria?
  - ¿La complejidad es razonable?
- Estilo:
  - ¿Cumple con el estilo del proyecto (formato, convenciones)?
- Tests:
  - ¿Hay tests nuevos o actualizados cuando tiene sentido?
  - ¿Los tests existentes siguen pasando?
- Impacto:
  - ¿Puede romper algo existente?
  - ¿Hay consecuencias de rendimiento o seguridad a considerar?

1. En la pestaña **Files changed** de cada PR, recorre los cambios con esta checklist en mente.
2. Cuando detectes algo mejorable:
   - Deja un comentario en la línea concreta.
   - Propón una alternativa (“¿Qué te parece…?”) mejor que solo marcar el problema.

En `cp3-checklist-pr.txt`, para cada PR, rellena una tabla, por ejemplo:

```text
PR: <URL>

[Funcionalidad]
- Comentario/resumen:

[Calidad del código]
- Comentario/resumen:

[Estilo]
- Comentario/resumen:

[Tests]
- Comentario/resumen:

[Impacto]
- Comentario/resumen:
```

---

## 🧩 Parte 4 – Decidir: aprobar o pedir cambios

### Reto 4.1 – Usar “Approve / Request changes / Comment”

Para cada PR:

1. Tras revisar, decide uno de estos estados:

   - **Approve**: cambios correctos, solo detalles menores.
   - **Request changes**: hay problemas que deben solucionarse antes de fusionar.
   - **Comment**: feedback general sin bloquear (depende del repo).

2. En la interfaz de GitHub:
   - Usa el botón **Review changes**.
   - Escribe un resumen de la revisión (qué has mirado, nivel de confianza, puntos fuertes y débiles).

3. Si pides cambios, sé específico:
   - Indica qué hay que cambiar.
   - Justifica brevemente por qué (legibilidad, bug, falta de test, etc.).

En `cp4-decision-pr.txt`, para cada PR, anota:

- Acción tomada: Approve / Request changes / Comment.
- Texto (resumen) de tu review general.

---

## 🧩 Parte 5 – Revisar una segunda iteración de la PR

### Reto 5.1 – Volver a revisar después de cambios

1. Pide (o simula) que la persona autora de la PR aplique tus sugerencias (nuevos commits).
2. Cuando la PR se actualice:
   - Revisa solo los cambios nuevos (GitHub permite filtrar por commit si lo necesitas).
   - Comprueba que los comentarios marcados como “Resueltos” lo estén realmente.

3. Actualiza tu decisión si procede (por ejemplo, pasar de “Request changes” a “Approve”).

En `cp5-segunda-iteracion.txt`, para al menos una PR, indica:

- Qué cambios se hicieron tras tu primera revisión.
- Si ahora aprobarías la PR y por qué.

---

## 🧩 Parte 6 – Reflexión final: la “buena” revisión de código

Crea `reflexion-6-21.md` y responde:

1. ¿Qué diferencia hay entre revisar para “buscar fallos” y revisar para “ayudar a mejorar” el código?
2. ¿Qué cosas revisarías **siempre** aunque haya poco tiempo (por ejemplo: seguridad, cambios en lógica crítica, tests) y qué cosas dejarías a herramientas automáticas (lint, formato, etc.)?
3. ¿Cómo cuidarías el tono de tus comentarios para que la revisión no desmotive a la persona autora? Da 2–3 ejemplos de frases constructivas.

---

## 📦 Entrega esperada en el repositorio

En el repositorio donde documentes la actividad (puede ser `actividad-6-20-pull-requests` o `actividad-6-21-revision-pr`) deben aparecer:

- `cp1-prs-a-revisar.txt`
- `cp2-contexto-pr.txt`
- `cp3-checklist-pr.txt`
- `cp4-decision-pr.txt`
- `cp5-segunda-iteracion.txt`
- `reflexion-6-21.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Aplicación rigurosa de la checklist de revisión en al menos 2 PRs.
- 3 pts – Calidad y claridad de los comentarios y decisiones (approve/request changes).
- 3 pts – Profundidad de la reflexión en `reflexion-6-21.md` (visión madura de la revisión como colaboración, no solo control).

**Puntuación máxima: 10 puntos.**

---