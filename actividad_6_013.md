
# 🧩 Actividad 6.13 – `git worktree`: varias ramas, varios directorios

> Cuando trabajas en varias ramas a la vez, cambiar de rama y hacer `stash` continuamente puede ser incómodo.
> En esta actividad aprenderás a usar **`git worktree` para tener varias copias de trabajo del mismo repositorio**, cada una en una rama distinta.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Explicar qué es un **worktree** y en qué se diferencia de clonar el repositorio varias veces.
- Crear worktrees adicionales con `git worktree add` (incluyendo `-b` para crear rama nueva).
- Listar worktrees con `git worktree list`.
- Eliminar/prunear worktrees con `git worktree remove` / `prune`.

---

## 🧠 Conceptos clave: ¿qué es `git worktree`?

- `git worktree` permite tener **varios directorios de trabajo enlazados al mismo repositorio**.
- Cada worktree:
  - Tiene su propia carpeta con archivos.
  - Puede tener una rama distinta check‑out.
  - Comparte el mismo `.git`/historial con el repositorio principal, evitando clones duplicados.
- Comandos básicos:
  - `git worktree add <ruta> <branch>`
  - `git worktree add -b <nueva-rama> <ruta>`
  - `git worktree list`
  - `git worktree remove <ruta-o-nombre>`
  - `git worktree prune`

---

## 🧩 Parte 1 – Preparar un repositorio base

### Reto 1.1 – Crear un repo sencillo con varias ramas

1. Crea una carpeta para esta actividad:

   ```bash
   mkdir actividad-6-13-git-worktree
   cd actividad-6-13-git-worktree
   ```

2. Inicializa el repositorio:

   ```bash
   git init
   ```

3. Crea `README.md`:

   ```markdown
   # Proyecto Worktree

   Rama main.
   ```

4. Añade y haz commit:

   ```bash
   git add README.md
   git commit -m "Commit inicial en main"
   ```

5. Crea una rama `feature-a`:

   ```bash
   git checkout -b feature-a
   echo "Funcionalidad A en desarrollo." >> README.md
   git add README.md
   git commit -m "Añade funcionalidad A"
   ```

6. Vuelve a `main`:

   ```bash
   git checkout main
   ```

### Checkpoint 1 – Evidencia

- Crea `cp1-historial-worktree.txt` con:
  - La salida de `git log --oneline --all`.
  - La salida de `git branch`.

---

## 🧩 Parte 2 – Crear un segundo directorio para trabajar con `feature-a`

### Reto 2.1 – Crear un worktree para `feature-a`

En lugar de cambiar de rama en el mismo directorio, vas a crear otro directorio de trabajo para `feature-a`.

1. Desde el directorio del repo principal (donde está `main`), ejecuta:

   ```bash
   git worktree add ../wt-feature-a feature-a
   ```

   Esto creará un nuevo directorio `../wt-feature-a` con el contenido de la rama `feature-a`.

2. Lista los worktrees:

   ```bash
   git worktree list
   ```

   Deberías ver al menos:
   - El worktree principal (este directorio).
   - El nuevo worktree `../wt-feature-a` asociado a `feature-a`.

3. Entra en el nuevo directorio:

   ```bash
   cd ../wt-feature-a
   ```

4. Comprueba en qué rama estás:

   ```bash
   git branch
   ```

   Debería indicar `feature-a` como rama activa.

### Checkpoint 2 – Evidencia

- Crea en el **worktree principal** (directorio original) el archivo `cp2-worktree-list.txt` con:
  - Salida de `git worktree list`.
  - Una breve explicación de la estructura de directorios que ves (principal + wt‑feature‑a).

---

## 🧩 Parte 3 – Trabajar en paralelo en dos worktrees

### Reto 3.1 – Hacer cambios independientes en cada worktree

1. En el directorio `../wt-feature-a` (worktree de `feature-a`), añade:

   ```bash
   echo "Detalle técnico de la funcionalidad A." >> README.md
   git add README.md
   git commit -m "Amplía detalles de funcionalidad A"
   ```

2. Vuelve al directorio principal del repo (el de la actividad, rama `main`):

   ```bash
   cd ../actividad-6-13-git-worktree
   ```

3. Aquí, en `main`, añade otra línea distinta:

   ```bash
   echo "Cambio independiente en main." >> README.md
   git add README.md
   git commit -m "Actualiza README en main"
   ```

4. Lista de nuevo worktrees y revisa logs:

   ```bash
   git worktree list
   git log --oneline --all
   ```

### Checkpoint 3 – Evidencia

- Actualiza `cp2-worktree-list.txt` (o crea `cp3-trabajo-paralelo.txt`) con:
  - Nuevas salidas de `git worktree list`.
  - Un pequeño esquema (texto) que explique qué cambios hay en cada directorio y en qué rama.

---

## 🧩 Parte 4 – Crear un nuevo worktree con rama nueva (`-b`)

### Reto 4.1 – Worktree para `feature-b` creada al vuelo

1. Desde el directorio del repo principal (`actividad-6-13-git-worktree`), ejecuta:

   ```bash
   git worktree add -b feature-b ../wt-feature-b main
   ```

   Esto:
   - Crea una **nueva rama** `feature-b` a partir de `main`.
   - Crea un directorio `../wt-feature-b` con esa rama check‑out.

2. Entra en el nuevo worktree:

   ```bash
   cd ../wt-feature-b
   git branch
   ```

   Verifica que estás en `feature-b`.

3. Haz algún cambio:

   ```bash
   echo "Funcionalidad B en desarrollo." >> README.md
   git add README.md
   git commit -m "Añade funcionalidad B en rama feature-b"
   ```

4. Vuelve al directorio principal y revisa:

   ```bash
   cd ../actividad-6-13-git-worktree
   git worktree list
   git log --oneline --all
   ```

### Checkpoint 4 – Evidencia

- Crea `cp4-feature-b-worktree.txt` con:
  - El comando `git worktree add -b ...` que has usado.
  - La salida de `git worktree list` mostrando los tres worktrees.
  - Una breve explicación de la diferencia entre crear la rama con `git branch` y crearla directamente con `git worktree add -b`.

---

## 🧩 Parte 5 – Eliminar worktrees y limpiar (`remove` / `prune`)

### Reto 5.1 – Quitar un worktree que ya no necesitas

> Importante: antes de eliminar un worktree, asegúrate de no tener cambios sin commitear en esa carpeta.

1. Asegúrate de estar en el **worktree principal** (`actividad-6-13-git-worktree`) o en cualquier otro distinto al que vas a eliminar.

2. Elimina el worktree de `feature-a`:

   ```bash
   git worktree remove ../wt-feature-a
   ```

   Si da error por estar “unclean”, puedes limpiar o usar `--force` (solo en este ejercicio).

3. Comprueba:

   ```bash
   git worktree list
   ```

   Verás que `wt-feature-a` ya no aparece.

4. Opcional: si has borrado manualmente algún directorio de worktree, puedes ejecutar:

   ```bash
   git worktree prune
   ```

   para limpiar referencias antiguas.

### Checkpoint 5 – Evidencia

- Crea `cp5-remove-prune.txt` con:
  - El comando `git worktree remove` utilizado.
  - La salida de `git worktree list` antes y después de eliminar el worktree.
  - Una explicación de la diferencia entre `remove` y `prune`.

---

## 🧩 Parte 6 – Reflexión final: cuándo usar worktrees

Crea `reflexion-6-13.md` y responde:

1. Explica con tus palabras qué ventaja tienen los worktrees frente a:
   - Cambiar de rama en el mismo directorio.
   - Clonar el repositorio varias veces.
2. Describe **dos situaciones reales** donde usarías `git worktree` (por ejemplo, revisar un PR en paralelo a una feature, probar un hotfix sin tocar tu rama actual, etc.).
3. ¿Qué buenas prácticas seguirías para nombrar y organizar los directorios de worktrees (ej.: prefijos, limpieza periódica)?

---

## 📦 Entrega esperada en el repositorio

En el repositorio principal (`actividad-6-13-git-worktree`) debe constar:

- `README.md` (versión final).
- `cp1-historial-worktree.txt`
- `cp2-worktree-list.txt`
- `cp3-trabajo-paralelo.txt`
- `cp4-feature-b-worktree.txt`
- `cp5-remove-prune.txt`
- `reflexion-6-13.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Uso correcto de `git worktree add`, `git worktree list`, `git worktree remove` (y `prune` si se usa).
- 3 pts – Evidencias claras en los checkpoints (estructuras de directorios, ramas y logs).
- 3 pts – Calidad de la reflexión en `reflexion-6-13.md` (comprensión de cuándo worktree mejora el flujo de trabajo).

**Puntuación máxima: 10 puntos.**

---