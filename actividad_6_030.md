
# ✅ Actividad 6.30 – Mejores prácticas con GitHub Copilot

> Copilot es potente, pero solo es realmente útil si lo usas con buenas prácticas: buenos prompts, revisión crítica y un rol claro en tu aprendizaje o en el equipo.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Formular **buenos prompts** para Copilot (específicos, con contexto y ejemplos).
- Revisar y adaptar las sugerencias de Copilot en vez de aceptarlas ciegamente.
- Definir normas de uso responsable de Copilot en un entorno educativo o de equipo.

---

## 🧩 Parte 1 – Malos vs buenos prompts

### Reto 1.1 – Comparar resultados según el prompt

1. Crea un archivo `prompts-copilot.md` en un proyecto sencillo (por ejemplo, JS o Python).

2. En tu editor con Copilot activo, prueba a pedir ayuda para la misma tarea de dos maneras:

   - Prompt pobre (en un comentario o en Copilot Chat):
     > “haz una función que haga cosas con una lista”

   - Prompt mejorado siguiendo buenas prácticas:
     > “Escribe una función en JavaScript llamada `groupBy` que reciba un array de objetos con una propiedad `category` y devuelva un objeto que agrupe los elementos por `category`. Devuelve un objeto donde cada clave es la categoría y el valor es un array de objetos. Incluye un ejemplo de uso.”

3. Observa y compara el código sugerido en cada caso.

### Checkpoint 1 – Evidencia

- Rellena en `prompts-copilot.md`:
  - Los dos prompts que usaste.
  - Un breve comentario de por qué el segundo produce una respuesta más útil (más contexto, requisitos claros, ejemplo).

---

## 🧩 Parte 2 – Revisar y mejorar sugerencias de Copilot

### Reto 2.1 – No aceptar todo “tal cual”

1. A partir de una sugerencia de Copilot (por ejemplo, tu `groupBy`), revisa:

   - ¿Cumple bien el contrato de la función?
   - ¿Qué pasa con arrays vacíos, valores inesperados o propiedades ausentes?
   - ¿Es legible, sigue tu estilo y convenciones?

2. Haz al menos 2 mejoras manuales al código sugerido:
   - Mejorar nombres de variables.
   - Añadir manejo de errores o valores borde.
   - Añadir comentarios claros, etc.

3. Guarda la versión original de Copilot y tu versión retocada en el código o en un archivo de comparación.

### Checkpoint 2 – Evidencia

- Crea `cp2-revision-sugerencias.txt` con:
  - Lista de las mejoras que tú has añadido sobre la propuesta original.
  - Motivo de cada mejora (legibilidad, robustez, estilo, rendimiento, etc.).

---

## 🧩 Parte 3 – Copilot como tutor, no como máquina de copiar

### Reto 3.1 – Configurar un rol “tutor”

1. En Copilot Chat, lanza un mensaje que le marque el rol, inspirado en las guías de aprendizaje:

   > “Estoy aprendiendo programación. Actúa como tutor: explícame conceptos y enfoques, pero no me des directamente la solución completa. Ayúdame a razonar los pasos.”

2. Plantéale un problema sencillo (por ejemplo, “quiero validar un formulario con 3 campos obligatorios y mostrar errores”) y pídele:
   - Que explique la estrategia.
   - Que te ayude a pensar los pasos y casos límite.
   - Que no te dé toda la implementación de golpe.

3. Implementa tú el código a partir de sus explicaciones (sin aceptar un bloque de código completo generado por Copilot).

### Checkpoint 3 – Evidencia

- Crea `cp3-modo-tutor.txt` con:
  - El prompt de configuración de rol que usaste.
  - 1–2 ideas o pasos clave que te dio Copilot que te ayudaron a diseñar la solución sin “copiar y pegar”.

---

## 🧩 Parte 4 – Riesgos y uso responsable

### Reto 4.1 – Identificar riesgos y mitigaciones

Revisa las recomendaciones de uso responsable (revisión humana, seguridad, propiedad intelectual, datos sensibles).

1. Haz una lista de riesgos relevantes en tu contexto:

   - Aceptar código inseguro o incorrecto.
   - Copiar soluciones de ejercicios evaluables.
   - Filtrar datos confidenciales en prompts.

2. Para cada riesgo, define al menos una **acción de mitigación**, por ejemplo:
   - “Siempre ejecutar tests y revisar lógica antes de usar en producción.”
   - “En prácticas evaluables, usar Copilot solo como guía conceptual.”
   - “Nunca pegar tokens, contraseñas o datos reales en el chat.”

### Checkpoint 4 – Evidencia

- Crea `cp4-riesgos-y-mitigaciones.txt` con una tabla de 2 columnas:
  - Riesgo.
  - Medida de mitigación.

---

## 🧩 Parte 5 – Diseñar “normas de aula” o de equipo para Copilot

### Reto 5.1 – Código de conducta para Copilot

1. Piensa en tu contexto (aula, equipo de desarrollo, proyecto colaborativo) y redacta unas **“Normas de uso de Copilot”** inspiradas en buenas prácticas:

   Incluye al menos:

   - Cuándo se puede usar (p.ej. permitido en prácticas, limitado en exámenes).
   - Qué se espera siempre del usuario (leer, entender y comentar el código sugerido).
   - Cómo citar o documentar el uso de IA en el proyecto si aplica.
   - Qué está prohibido (pegar en prompts datos sensibles, usarlo para saltarse la autoría de trabajos, etc.).

2. Crea `normas-copilot.md` con tus reglas.

---

## 🧩 Parte 6 – Reflexión final: tu “contrato personal” con Copilot

Crea `reflexion-6-30.md` y responde:

1. ¿Qué tres hábitos concretos te comprometes a seguir siempre que uses Copilot (por ejemplo: escribir buenos prompts, revisar todo, añadir tests para código generado)?
2. ¿En qué tipo de tareas decides conscientemente **no** usar Copilot, para forzarte a practicar y aprender?
3. ¿Cómo explicarías a alguien que empieza que Copilot es una herramienta para pensar mejor, no para dejar de pensar?

---

## 📦 Entrega esperada en el repositorio

En `actividad-6-30-copilot-buenas-practicas` (o repo que uses) deben aparecer:

- `prompts-copilot.md`
- `cp2-revision-sugerencias.txt`
- `cp3-modo-tutor.txt`
- `cp4-riesgos-y-mitigaciones.txt`
- `normas-copilot.md`
- `reflexion-6-30.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Aplicación práctica de buenas prácticas (prompts, revisión, uso como tutor).
- 3 pts – Identificación clara de riesgos y medidas de mitigación en `cp4-riesgos-y-mitigaciones.txt`.
- 3 pts – Calidad de `normas-copilot.md` y `reflexion-6-30.md` (visión madura y pedagógica del uso de Copilot).

**Puntuación máxima: 10 puntos.**

---