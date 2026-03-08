
# 🤖 Actividad 6.29 – GitHub Copilot: ayudante de programación con IA

> GitHub Copilot sugiere código, explica funciones y genera tests directamente en tu editor.
> En esta actividad vas a configurarlo, usarlo en un ejercicio sencillo y reflexionar sobre un uso responsable.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Activar y usar GitHub Copilot y Copilot Chat en VS Code.
- Usar Copilot para autocompletar funciones, explicar código y generar tests.
- Aplicar buenas prácticas: entender el código sugerido, revisarlo y evitar dependencias ciegas.

---

## 🧩 Parte 1 – Activar GitHub Copilot en VS Code

### Reto 1.1 – Configuración inicial

1. Asegúrate de tener una cuenta con acceso a GitHub Copilot (Individual, Business, Education, etc.).

2. En VS Code:
   - Instala la extensión **GitHub Copilot**.
   - Opcional: instala también **GitHub Copilot Chat**.

3. Inicia sesión con tu cuenta de GitHub y confirma que Copilot está activado (icono de Copilot en la barra de estado).

4. Crea `cp1-configuracion-copilot.txt` con:
   - Editor que usas (VS Code / Codespaces).
   - Extensiones de Copilot instaladas.

---

## 🧩 Parte 2 – Probar autocompletado en un ejercicio sencillo

### Reto 2.1 – Usar Copilot como “pair programmer”

1. Crea un directorio `actividad-6-29-github-copilot` y un archivo, por ejemplo `arrays.js` (o en otro lenguaje que prefieras).

2. Escribe solo comentarios describiendo funciones, por ejemplo:

   ```js
   // Devuelve la media de una lista de números
   // function average(numbers) {

   // Devuelve un nuevo array con los elementos únicos
   // function unique(items) {

   // Devuelve un objeto con el recuento de cada elemento
   // function countByValue(items) {
   ```

3. Deja que Copilot sugiera las implementaciones (acepta con Tab/Enter cuando te convenzan).

4. Revisa que el código tenga sentido y, si no, edítalo a mano.

### Checkpoint 2 – Evidencia

- Crea `cp2-funciones-generadas.txt` con:
  - Las firmas de las funciones y un breve comentario sobre qué parte generó Copilot y qué parte modificaste tú.

---

## 🧩 Parte 3 – Usar Copilot Chat: explicar y mejorar código

### Reto 3.1 – Pedir explicaciones y refactors

1. Abre el archivo con las funciones generadas y abre **Copilot Chat** en VS Code.

2. Lanza preguntas como (en inglés o español):

   - “Explain this file.”
   - “How can I improve the performance of `unique`?”
   - “How can I add input validation to these functions?”

3. Aplica, al menos en una función, una mejora propuesta por Copilot (por ejemplo, mejor manejo de errores, nombres más claros o uso de métodos de array más apropiados).

### Checkpoint 3 – Evidencia

- Crea `cp3-chat-y-mejoras.txt` con:
  - 2–3 preguntas que hiciste a Copilot Chat.
  - Resumen de la mejora que aplicaste al código y por qué te parece razonable.

---

## 🧩 Parte 4 – Generar tests con ayuda de Copilot

### Reto 4.1 – Tests básicos guiados por la IA

1. Crea un archivo `arrays.test.js` (o equivalente en tu lenguaje) y escribe comentarios como:

   ```js
   // Tests para average: números positivos, mezcla, array vacío (debe lanzar error)
   // Tests para unique: array con repetidos, array vacío
   // Tests para countByValue: array con strings repetidos
   ```

2. Deja que Copilot proponga casos de prueba usando tu framework (Jest, Vitest, Mocha, etc.).

3. Revisa los tests:
   - ¿Cubren los casos que querías?
   - ¿Hay casos redundantes o poco claros?

4. Ejecuta los tests y corrige código/tests si algo falla.

### Checkpoint 4 – Evidencia

- Crea `cp4-tests-generados.txt` con:
  - Lista de los casos de prueba principales (solo en resumen, no hace falta pegar todo el código).
  - Comentario sobre si Copilot te ayudó a pensar en algún caso que no habías considerado.

---

## 🧩 Parte 5 – Uso responsable: límites y buenas prácticas

### Reto 5.1 – Analizar buenas prácticas de uso

1. Revisa un resumen de buenas prácticas de Copilot (entender el código, revisar seguridad, evitar copiar sin comprender, etc.).

2. Piensa en situaciones en las que **no** deberías aceptar sugerencias sin más, por ejemplo:
   - Código que maneja datos sensibles.
   - Ejercicios de examen/trabajo donde se evalúa tu autoría.
   - Código que toca seguridad o lógica crítica.

3. Crea `cp5-uso-responsable.txt` con:
   - 3 buenas prácticas que vas a seguir siempre al usar Copilot (por ejemplo, “leer todo lo que sugiere”, “añadir comentarios propios”, etc.).
   - 2 situaciones donde preferirías no usarlo o limitar su uso.

---

## 🧩 Parte 6 – Reflexión final: Copilot como herramienta de aprendizaje

Crea `reflexion-6-29.md` y responde:

1. ¿En qué partes del flujo de trabajo te ha sido más útil Copilot (esqueleto de funciones, tests, refactor, documentación)?
2. ¿Crees que Copilot te ayuda a aprender más rápido o puede hacer que te apoyes demasiado en él? ¿Cómo equilibrarías ambas cosas en clase?
3. Si lo usas con alumnado, ¿qué reglas pondrías para que Copilot sea una ayuda y no una “máquina de copiar”?

---

## 📦 Entrega esperada en el repositorio

En `actividad-6-29-github-copilot` (o repo que hayas usado) deben aparecer:

- Código fuente (`arrays.js` y `arrays.test.js` o equivalentes).
- `cp1-configuracion-copilot.txt`
- `cp2-funciones-generadas.txt`
- `cp3-chat-y-mejoras.txt`
- `cp4-tests-generados.txt`
- `cp5-uso-responsable.txt`
- `reflexion-6-29.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Uso efectivo de Copilot: generación de código, explicaciones y tests, con revisión manual.
- 3 pts – Evidencias claras de interacción con Copilot (chat, mejoras, tests).
- 3 pts – Calidad de la reflexión en `reflexion-6-29.md` y `cp5-uso-responsable.txt` (visión crítica y pedagógica del uso de IA).

**Puntuación máxima: 10 puntos.**

---