
# 📦 Actividad 6.7 – `git stash`: guardar cambios temporales

> A veces necesitas cambiar de tarea o de rama sin estar listo para hacer commit.
> En esta actividad aprenderás a usar **`git stash` para guardar cambios temporalmente**, volver a un árbol limpio y recuperarlos más tarde.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Explicar qué es el **stash** de Git y cuándo utilizarlo.
- Guardar cambios en curso con `git stash` y `git stash push -m`.
- Listar, aplicar y eliminar stashes (`git stash list`, `apply`, `pop`, `drop`).
- Manejar stashes múltiples y entender la diferencia entre `apply` y `pop`.

---

## 🧠 Conceptos clave: ¿qué hace `git stash`?

- `git stash` guarda un **snapshot de tus cambios sin commitear** (staged y unstaged) en un área especial llamada *stash*, y devuelve tu directorio de trabajo a un estado limpio.
- Es útil cuando necesitas:
  - Cambiar de rama para arreglar algo rápido.
  - Actualizar desde remoto sin mezclar tu trabajo a medias.
  - Evitar commits “basura” tipo `wip`.
- Comandos clave:
  - `git stash` / `git stash push -m "mensaje"` – guarda cambios.
  - `git stash list` – lista todos los stashes.
  - `git stash apply [stash@{n}]` – aplica cambios pero **mantiene** el stash.
  - `git stash pop [stash@{n}]` – aplica cambios y **elimina** el stash.
  - `git stash drop` / `git stash clear` – elimina uno o todos.

---

## 🧩 Parte 1 – Preparar un repositorio con trabajo en curso

### Reto 1.1 – Crear el escenario

1. Crea una carpeta para esta actividad:

   ```bash
   mkdir actividad-6-7-git-stash
   cd actividad-6-7-git-stash
   ```

2. Inicializa el repositorio:

   ```bash
   git init
   ```

3. Crea `tarea.txt` con:

   ```text
   Tarea principal: implementar login.
   ```

4. Añade y haz commit:

   ```bash
   git add tarea.txt
   git commit -m "Define tarea principal de login"
   ```

5. Simula que empiezas a trabajar en la tarea:

   ```bash
   echo "Paso 1: crear formulario de login." >> tarea.txt
   echo "Paso 2: validar credenciales." >> tarea.txt
   ```

6. Comprueba el estado:

   ```bash
   git status
   ```

Deberías ver cambios sin commitear en `tarea.txt`.

### Checkpoint 1 – Evidencia

- Crea `cp1-estado-inicial.txt` con la salida de `git status`.
- Añade una frase explicando por qué **no** quieres hacer todavía commit de estos cambios (por ejemplo, están incompletos).

---

## 🧩 Parte 2 – Guardar cambios con `git stash` y cambiar de rama

### Reto 2.1 – Hacer stash de tu trabajo en curso

Imagina que te avisan de un bug urgente en otra rama, pero no quieres perder estos cambios.

1. Guarda los cambios actuales en un stash con mensaje:

   ```bash
   git stash push -m "WIP login pasos 1 y 2"
   ```

   Esto debería guardar tus cambios y dejar el árbol limpio.

2. Comprueba de nuevo:

   ```bash
   git status
   ```

   Ahora no debería haber cambios pendientes.

3. Lista los stashes:

   ```bash
   git stash list
   ```

   Verás algo como `stash@{0}: On main: WIP login pasos 1 y 2`.

### Reto 2.2 – Simular un arreglo rápido en otra rama

1. Crea una rama `hotfix`:

   ```bash
   git checkout -b hotfix
   ```

2. Crea `hotfix.txt` con:

   ```text
   Hotfix urgente aplicado.
   ```

3. Añade y haz commit:

   ```bash
   git add hotfix.txt
   git commit -m "Aplica hotfix urgente"
   ```

4. Vuelve a `main`:

   ```bash
   git checkout main
   ```

### Checkpoint 2 – Evidencia

- Crea `cp2-stash-list.txt` con:
  - Salida de `git stash list`.
  - Salida de `git log --oneline --all`.
  - Una frase explicando qué ha pasado con tus cambios de login mientras hacías el hotfix.

---

## 🧩 Parte 3 – Recuperar el stash: `apply` vs `pop`

### Reto 3.1 – Recuperar cambios con `git stash apply`

1. Asegúrate de estar en `main`:

   ```bash
   git checkout main
   ```

2. Aplica el stash **sin eliminarlo**:

   ```bash
   git stash apply
   ```

   Esto traerá de vuelta los cambios a `tarea.txt`, pero el stash seguirá listado.

3. Comprueba:

   ```bash
   git status
   git stash list
   ```

   Verás cambios sin commitear y el stash aún presente.

### Reto 3.2 – Eliminar el stash con `pop`

1. Una vez comprobado, ejecuta:

   ```bash
   git stash pop
   ```

   Esto aplicará (de nuevo, si el stash seguía intacto) y **eliminará** el stash correspondiente.

2. Vuelve a comprobar:

   ```bash
   git stash list
   ```

   Debería estar vacío (o tener menos entradas).

> Nota: si tras el `apply` ya no había stash, puedes rehacer el escenario: crea nuevos cambios, haz `git stash push -m "..."` y luego `git stash pop`.

### Checkpoint 3 – Evidencia

- Crea `cp3-apply-vs-pop.txt` con:
  - Salida de `git stash list` antes y después de `apply` y/o `pop`.
  - Una explicación clara de la diferencia entre `git stash apply` y `git stash pop`.

---

## 🧩 Parte 4 – Varios stashes y recuperar uno específico

### Reto 4.1 – Crear múltiples stashes

1. Asegúrate de tener un árbol limpio (haz commit o descarta cambios si hace falta).

2. Cambia `tarea.txt`:

   ```bash
   echo "Paso 3: mostrar mensaje de error." >> tarea.txt
   git stash push -m "WIP login paso 3"
   ```

3. Vuelve a cambiar `tarea.txt`:

   ```bash
   echo "Paso 4: recordar usuario." >> tarea.txt
   git stash push -m "WIP login paso 4"
   ```

4. Lista:

   ```bash
   git stash list
   ```

   Deberías ver al menos `stash@{0}` y `stash@{1}` con sus mensajes.

### Reto 4.2 – Aplicar un stash concreto

1. Aplica **solo** el stash más antiguo (por ejemplo, `stash@{1}`):

   ```bash
   git stash apply stash@{1}
   ```

2. Comprueba el contenido de `tarea.txt` y el listado de stashes:

   ```bash
   cat tarea.txt
   git stash list
   ```

3. Si quieres, elimina manualmente un stash concreto:

   ```bash
   git stash drop stash@{1}
   ```

### Checkpoint 4 – Evidencia

- Crea `cp4-multiples-stash.txt` con:
  - Salida de `git stash list` mostrando varios stashes con mensajes.
  - El comando que has usado para aplicar un stash específico.
  - Una breve explicación de por qué es útil poner **mensajes descriptivos** a los stashes.

---

## 🧩 Parte 5 – (Opcional) Incluir archivos no trackeados

> Esta parte es opcional y algo más avanzada.

### Reto 5.1 – Usar `git stash -u` o `--include-untracked`

1. Crea un archivo nuevo sin añadirlo a Git, por ejemplo:

   ```bash
   echo "Notas temporales" > notas-temporales.txt
   ```

2. Ejecuta:

   ```bash
   git stash -u -m "Incluye archivo no trackeado"
   ```

   `-u` incluye también archivos sin seguimiento en el stash.

3. Comprueba:

   ```bash
   git status
   git stash list
   ```

4. Recupera el stash:

   ```bash
   git stash pop
   ```

   Verás que vuelve a aparecer `notas-temporales.txt`.

### Checkpoint 5 – Evidencia (opcional)

- Crea `cp5-untracked.txt` con:
  - Comandos usados (`git stash -u`, `git stash pop`).
  - Una explicación de qué diferencia hay entre `git stash` normal y con `-u`.

---

## 🧩 Parte 6 – Reflexión final

Crea `reflexion-6-7.md` y responde:

1. Explica con tus palabras qué es el stash y en qué se diferencia de hacer commit.
2. Indica **dos situaciones reales** donde usarías `git stash` en tu trabajo diario.
3. ¿Qué riesgos tiene abusar de `git stash` o acumular muchos stashes sin documentarlos?

---

## 📦 Entrega esperada en el repositorio

Tu repositorio de la Actividad 6.7 debe incluir:

- `tarea.txt` (versión final).
- `cp1-estado-inicial.txt`
- `cp2-stash-list.txt`
- `cp3-apply-vs-pop.txt`
- `cp4-multiples-stash.txt`
- `cp5-untracked.txt` (si realizas la parte opcional)
- `reflexion-6-7.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Uso correcto de `git stash`, `stash list`, `apply`, `pop`, `drop` (y `-u` si se hace la parte opcional).
- 3 pts – Evidencias claras en los archivos de checkpoints.
- 3 pts – Calidad de la reflexión en `reflexion-6-7.md` (comprensión de cuándo y por qué usar stash, y sus riesgos).

**Puntuación máxima: 10 puntos.**

---