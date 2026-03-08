Aquí tienes la **Actividad 6.5** centrada en `git rebase -i` (rebase interactivo), pensada como ejercicio de limpieza de historial: reordenar, corregir mensajes y hacer squash de commits. [thoughtbot](https://thoughtbot.com/blog/git-interactive-rebase-squash-amend-rewriting-history)

***

```markdown
# 🧹 Actividad 6.5 – `git rebase -i`: limpiar y organizar el historial

> En la Actividad 6.4 aprendiste a usar `git rebase` para actualizar una rama sobre otra.  
> Ahora vas a usar **rebase interactivo (`git rebase -i`)** para **reordenar, combinar y corregir commits**, dejando un historial más limpio antes de integrar tu trabajo.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Iniciar un **rebase interactivo** sobre los últimos N commits (`git rebase -i HEAD~N`).
- Usar comandos básicos de rebase interactivo: `pick`, `reword`, `squash`, `drop`.
- Reordenar commits para agrupar cambios relacionados.
- Combinar varios commits pequeños en uno más significativo (squash).

> Recuerda: esto **reescribe la historia**, así que se usa en **ramas locales que aún no has compartido**.

---

## 🧠 Conceptos clave: rebase interactivo

Cuando ejecutas:

```bash
git rebase -i HEAD~N
```

Git abre en tu editor una lista de los últimos N commits, con un formato similar a:

```text
pick a1b2c3d Commit 1
pick e4f5g6h Commit 2
pick i7j8k9l Commit 3
# Commands:
# p, pick = usar el commit
# r, reword = usar el commit pero cambiar el mensaje
# e, edit = parar aquí para modificar el commit
# s, squash = combinar este commit con el anterior
# f, fixup = como squash, pero descartando el mensaje de este commit
# d, drop = eliminar el commit
# Puedes reordenar las líneas; se ejecutan de arriba a abajo.
```

Tú puedes:

- Cambiar `pick` por otros comandos (`reword`, `squash`, `drop`, etc.).  
- Reordenar las líneas para cambiar el orden de los commits.  
- Guardar y cerrar el editor para que Git aplique los cambios.  

---

## 🧩 Parte 1 – Preparar un historial “sucio”

### Reto 1.1 – Crear varios commits pequeños

1. Crea una carpeta para esta actividad:

   ```bash
   mkdir actividad-6-5-rebase-interactivo
   cd actividad-6-5-rebase-interactivo
   ```

2. Inicializa el repositorio:

   ```bash
   git init
   ```

3. Crea el archivo `app.md` con:

   ```markdown
   # App

   Versión inicial de la aplicación.
   ```

4. Añade y haz commit:

   ```bash
   git add app.md
   git commit -m "Commit 1: versión inicial"
   ```

5. Realiza varios cambios pequeños con commits poco descriptivos:

   - Cambio 1:

     ```bash
     echo "Línea extra 1" >> app.md
     git add app.md
     git commit -m "wip 1"
     ```

   - Cambio 2:

     ```bash
     echo "Línea extra 2" >> app.md
     git add app.md
     git commit -m "arreglo"
     ```

   - Cambio 3:

     ```bash
     echo "Línea extra 3" >> app.md
     git add app.md
     git commit -m "otro commit"
     ```

Ahora tienes 4 commits, de los cuales 3 son “ruidosos” (wip, arreglo, otro commit).

### Checkpoint 1 – Evidencia

- Crea `cp1-historial-original.txt` con la salida de:

  ```bash
  git log --oneline
  ```

---

## 🧩 Parte 2 – Reescribir mensajes con `reword`

### Reto 2.1 – Cambiar mensajes de los últimos commits

1. Inicia un rebase interactivo sobre los últimos 3 commits:

   ```bash
   git rebase -i HEAD~3
   ```

2. En el editor verás algo como:

   ```text
   pick <hash2> wip 1
   pick <hash3> arreglo
   pick <hash4> otro commit
   ```

3. Cambia `pick` por `reword` en los commits que tengan mensajes poco claros, por ejemplo:

   ```text
   reword <hash2> wip 1
   reword <hash3> arreglo
   pick   <hash4> otro commit
   ```

4. Guarda y cierra el editor.  
5. Git te irá abriendo el editor para que cambies cada mensaje de commit marcado con `reword`.

   - Escribe mensajes más informativos, por ejemplo:
     - `Añade línea extra 1 en app`
     - `Añade línea extra 2 en app`

6. Cuando termine, revisa el historial:

   ```bash
   git log --oneline
   ```

### Checkpoint 2 – Evidencia

- Crea `cp2-reword.txt` con:
  - La nueva salida de `git log --oneline`.  
  - Una explicación breve de qué hace `reword` en rebase interactivo.

---

## 🧩 Parte 3 – Hacer squash: combinar commits

### Reto 3.1 – Combinar cambios relacionados

Supón que quieres combinar los tres commits que añaden líneas extra en `app.md` en **un único commit**.

1. Ejecuta:

   ```bash
   git rebase -i HEAD~3
   ```

2. En el editor, verás los tres últimos commits, por ejemplo:

   ```text
   pick <hash2> Añade línea extra 1 en app
   pick <hash3> Añade línea extra 2 en app
   pick <hash4> otro commit
   ```

3. Decide qué commit quieres que sea el “principal” (normalmente el primero) y marca los siguientes como `squash`:

   ```text
   pick   <hash2> Añade línea extra 1 en app
   squash <hash3> Añade línea extra 2 en app
   squash <hash4> otro commit
   ```

   Esto indicará a Git que combine los commits 3 y 4 dentro del 2.

4. Guarda y cierra el editor.  
5. Git abrirá otro editor para que combines o ajustes el mensaje del nuevo commit “fusionado”.
   - Escribe algo como: `Agrupa cambios de líneas extra en app`.

6. Al finalizar, revisa:

   ```bash
   git log --oneline
   ```

   Verás que ahora hay **menos commits** y uno de ellos agrupa los cambios anteriores.

### Checkpoint 3 – Evidencia

- Crea `cp3-squash.txt` con:
  - La salida de `git log --oneline` después del squash.  
  - Una explicación de cuándo puede ser útil agrupar commits antes de abrir un pull request.

---

## 🧩 Parte 4 – Reordenar commits

### Reto 4.1 – Cambiar el orden de commits

1. Realiza un par de commits nuevos para tener algo que reordenar (por ejemplo, modificando `app.md` o creando archivos simples).  
2. Ejecuta:

   ```bash
   git log --oneline
   ```

   Anota cuántos commits recientes quieres poder reordenar (por ejemplo, 3).

3. Inicia el rebase interactivo:

   ```bash
   git rebase -i HEAD~3
   ```

4. En el editor, verás los últimos 3 commits en orden cronológico (el más antiguo arriba, el más reciente abajo).

5. Cambia el orden de las líneas (corta/pega) para que los commits aparezcan en otro orden lógico (por ejemplo, primero el commit que introduce una funcionalidad, luego el que la refina).

6. Guarda y cierra el editor.  
7. Comprueba el nuevo orden:

   ```bash
   git log --oneline
   ```

### Checkpoint 4 – Evidencia

- Crea `cp4-reordenar.txt` con:
  - La salida de `git log --oneline` antes de reordenar (si la guardaste) o una descripción del orden original.  
  - La salida actual de `git log --oneline`.  
  - Una breve explicación de por qué puede ser útil reordenar commits.

---

## 🧩 Parte 5 – El botón del pánico: `--abort`

### Reto 5.1 – Probar `git rebase --abort`

1. Lanza un `git rebase -i HEAD~3` y, a propósito, cancela mal o genera un conflicto que no quieras resolver.  
2. En lugar de continuar, ejecuta:

   ```bash
   git rebase --abort
   ```

   Esto debería devolver el repositorio al estado anterior al rebase.

3. Comprueba:

   ```bash
   git status
   git log --oneline
   ```

### Checkpoint 5 – Evidencia

- Crea `cp5-abortar-rebase.txt` con:
  - El comando `git rebase --abort`.  
  - Una frase explicando en qué situaciones reales lo usarías.

---

## 🧩 Parte 6 – Reflexión final

Crea `reflexion-6-5.md` con respuestas breves:

1. Explica con tus palabras para qué sirve `git rebase -i` y qué ventajas ofrece frente a dejar el historial “tal cual”.
2. Describe con un ejemplo cuándo usarías:
   - `reword`.  
   - `squash`.  
   - `drop`.
3. ¿Qué riesgos tiene usar mal `git rebase -i` (especialmente en ramas compartidas)?

---

## 📦 Entrega esperada en el repositorio

Tu repositorio de la Actividad 6.5 debe incluir:

- `app.md` (versión final).  
- `cp1-historial-original.txt`  
- `cp2-reword.txt`  
- `cp3-squash.txt`  
- `cp4-reordenar.txt`  
- `cp5-abortar-rebase.txt`  
- `reflexion-6-5.md`  

---

## 🏁 Evaluación sugerida

- 4 pts – Uso correcto de `git rebase -i` con `reword`, `squash` y reordenación de commits.
- 3 pts – Evidencias claras en los archivos de checkpoints.  
- 3 pts – Calidad de la reflexión en `reflexion-6-5.md` (entender el impacto en el historial y las buenas prácticas).

**Puntuación máxima: 10 puntos.**

---
```