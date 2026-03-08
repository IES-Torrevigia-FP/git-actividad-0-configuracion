Aquí tienes la **Actividad 6.11** sobre `git blame`, centrada en entender quién cambió qué y cuándo, y en usarla de forma constructiva para depurar y aprender del historial. [atlassian](https://www.atlassian.com/git/tutorials/inspecting-a-repository/git-blame)

***

```markdown
# 🕵️ Actividad 6.11 – `git blame`: quién tocó cada línea

> A estas alturas ya sabes crear, deshacer y explorar commits.
> En esta actividad vas a aprender a usar **`git blame` para ver quién fue la última persona que modificó cada línea de un archivo, cuándo y en qué commit**, y cómo usar esa información de forma profesional.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Explicar qué hace `git blame` y qué información muestra por línea.
- Usar `git blame` sobre un archivo completo y sobre rangos de líneas (`-L`).
- Combinar `git blame` con `git show` / `git log` para investigar bugs.
- Entender buenas prácticas para que blame sea útil (no “caza de brujas”).

---

## 🧠 Conceptos clave: ¿qué es `git blame`?

`git blame` **anota cada línea de un archivo** con:

- El hash del **último commit** que modificó esa línea.
- El **autor** de ese commit.
- La **fecha** del cambio.
- El **número de línea** y el contenido.

Sirve para:

- Investigar **cuándo** se introdujo un cambio (o un bug).
- Saber **a quién preguntar** sobre un trozo de código concreto.
- Entender el contexto de decisiones de diseño.

No debería usarse para “culpar” sino para **entender y colaborar mejor**.

---

## 🧩 Parte 1 – Preparar un archivo con varios autores (simulados)

### Reto 1.1 – Crear el repositorio y varios “autores”

En este ejercicio, simularás varios autores cambiando contenido en distintas líneas.

1. Crea una carpeta para esta actividad:

   ```bash
   mkdir actividad-6-11-git-blame
   cd actividad-6-11-git-blame
   ```

2. Inicializa el repositorio:

   ```bash
   git init
   ```

3. Crea un archivo `calculadora.js` (o `.py`, `.ts`, etc.) con este contenido inicial:

   ```js
   // calculadora.js
   // Versión inicial

   function sumar(a, b) {
     return a + b;
   }

   function restar(a, b) {
     return a - b;
   }
   ```

4. Haz commit como “Autor 1” (puedes cambiar tu identidad de Git temporalmente si quieres simular nombres):

   ```bash
   git add calculadora.js
   git commit -m "Añade funciones sumar y restar"
   ```

5. Modifica el archivo añadiendo una función más:

   ```js
   function multiplicar(a, b) {
     return a * b;
   }
   ```

6. Haz commit con otro mensaje (puede ser el mismo autor real, pero actuará como “otra persona” para el ejercicio):

   ```bash
   git add calculadora.js
   git commit -m "Añade función multiplicar"
   ```

7. Introduce un cambio “problemático” en `restar`:

   ```js
   function restar(a, b) {
     return a - b - 1; // BUG intencionado
   }
   ```

8. Commit:

   ```bash
   git add calculadora.js
   git commit -m "Modifica restar (BUG intencionado)"
   ```

9. Añade un comentario o línea más:

   ```js
   // TODO: añadir función dividir
   ```

10. Commit final:

   ```bash
   git add calculadora.js
   git commit -m "Añade TODO para función dividir"
   ```

### Checkpoint 1 – Evidencia

- Crea `cp1-historial-blame.txt` con la salida de:

  ```bash
  git log --oneline
  ```

---

## 🧩 Parte 2 – Usar `git blame` en un archivo completo

### Reto 2.1 – Ver quién cambió qué en `calculadora.js`

1. Ejecuta:

   ```bash
   git blame calculadora.js
   ```

   Verás para cada línea: commit, autor, fecha y contenido.

2. Identifica visualmente:
   - El commit que añadió `multiplicar`.
   - El commit que introdujo el bug en `restar`.
   - El commit que añadió el `TODO`.

3. Opcional: prueba variantes de blame (si quieres explorar):

   ```bash
   git blame -n calculadora.js # muestra número de línea
   git blame -e calculadora.js # muestra email del autor
   ```



### Checkpoint 2 – Evidencia

- Crea `cp2-blame-completo.txt` con:
  - Algunas líneas relevantes copiadas de `git blame calculadora.js` (por ejemplo, las de `restar` y el comentario `TODO`).
  - Una breve explicación de qué información te está dando blame por cada línea.

---

## 🧩 Parte 3 – Investigar un bug con blame + show/log

### Reto 3.1 – Encontrar quién introdujo el bug en `restar`

1. Localiza con `git blame` la línea de `restar` con el bug:

   ```bash
   git blame calculadora.js
   ```

2. Anota el hash del commit que aparece en esa línea.

3. Usa `git show` para ver más contexto:

   ```bash
   git show <hash_del_bug>
   ```

   Observa qué cambió exactamente en ese commit (diff) y su mensaje.

4. Opcional: restringe el log a ese archivo:

   ```bash
   git log --oneline -- calculadora.js
   ```

### Checkpoint 3 – Evidencia

- Crea `cp3-investigacion-bug.txt` con:
  - La línea de `git blame` correspondiente a `restar` con el bug.
  - El comando `git show <hash>` utilizado.
  - Una frase explicando qué aprendiste sobre **cuándo** y **cómo** se introdujo el bug.

---

## 🧩 Parte 4 – Limitar blame a rangos de líneas (`-L`)

### Reto 4.1 – Usar `-L` para centrarte en un bloque

1. Usa `git blame` solo sobre la función `restar` (por ejemplo, si está en líneas 5–9):

   ```bash
   git blame -L 5,9 calculadora.js
   ```

   Esto mostrará blame solo para ese rango.

2. Si usas un lenguaje con funciones bien definidas, también podrías usar patrones (`-L '/function restar/,/^}/'`), aunque es opcional.

### Checkpoint 4 – Evidencia

- Crea `cp4-blame-rango.txt` con:
  - La salida de `git blame -L ... calculadora.js` para el rango de la función `restar`.
  - Una explicación de por qué puede ser útil limitar blame a un bloque concreto.

---

## 🧩 Parte 5 – Buenas prácticas: usar blame para aprender, no para culpar

### Reto 5.1 – Reflexionar sobre el uso responsable de blame

Lee los resultados de `git blame` y piensa en cómo se verían en un proyecto real con más personas.

Crea `reflexion-6-11.md` y responde:

1. Explica con tus palabras para qué usarías `git blame` en un equipo (menciona al menos: depurar bugs, entender código, saber a quién preguntar).
2. ¿Por qué es mala idea usar blame para “señalar culpables” y cómo se puede enfocar de forma constructiva?
3. Menciona **dos buenas prácticas** que ayudan a tener un blame útil y legible (por ejemplo, formateo consistente, commits pequeños y con buen mensaje, evitar commits masivos de re-formateo).

---

## 📦 Entrega esperada en el repositorio

Tu repositorio de la Actividad 6.11 debe incluir:

- `calculadora.js` (versión final con el bug intencionado).
- `cp1-historial-blame.txt`
- `cp2-blame-completo.txt`
- `cp3-investigacion-bug.txt`
- `cp4-blame-rango.txt`
- `reflexion-6-11.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Uso correcto de `git blame` en archivo completo y en rangos de líneas, combinándolo con `git show` / `git log`.
- 3 pts – Evidencias claras en los checkpoints (hashes identificados, contexto de commits, rangos).
- 3 pts – Calidad de la reflexión en `reflexion-6-11.md` (visión madura y profesional del uso de blame).

**Puntuación máxima: 10 puntos.**

---
```
