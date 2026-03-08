# 🧭 Actividad 6.1 – Primer flujo de trabajo con Git

> En la Actividad 6.0 dejaste Git listo para usarse (usuario, rama `main`, alias, etc.).
> En esta actividad vas a **entender y practicar el flujo básico de Git**. Practicaremos como trabajar, preparar cambios y registrarlos en el historial.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Distinguir entre **directorio de trabajo**, **zona de staging** e **historial de commits**.
- Usar `git status`, `git add`, `git commit` y `git log` en un flujo básico.
- Crear commits pequeños y con mensajes claros.
- Entender qué significa “cambios sin seguir”, “cambios preparados” y “cambios confirmados”.

---

## 🧠 Conceptos clave antes de empezar

Piensa en Git como tres “espacios” donde pueden estar tus cambios:

- **Directorio de trabajo (working directory)**: donde editas los archivos normalmente en tu sistema de archivos.
- **Zona de staging (staging area / index)**: zona intermedia donde seleccionas qué cambios quieres incluir en el próximo commit.
- **Historial de commits (repository / commit history)**: registro permanente de cambios confirmados.

El flujo habitual es:

1. Editar archivos en el directorio de trabajo.
2. Añadir los cambios que quieres preparar con `git add` (pasan a staging).
3. Confirmar esos cambios con `git commit` (pasan al historial).

---

## 🧩 Parte 1 – Preparar el repositorio

### Reto 1.1 – Crear un nuevo repositorio

1. Crea una carpeta para esta actividad:
   ```bash
   mkdir actividad-6-1-flujo-git
   cd actividad-6-1-flujo-git
   ```
2. Inicializa un repositorio:
   ```bash
   git init
   ```
3. Verifica la rama actual:
   ```bash
   git branch
   ```
   Debería aparecer `main` si configuraste bien la Actividad 0.

### Checkpoint 1 – Evidencia

- Haz una captura de pantalla de la terminal donde se vea:
  - El `git init`.
  - La rama `main` mostrada por `git branch`.
- Guarda la captura con el nombre `cp1-init-rama-main.png` (o formato similar).

---

## 🧩 Parte 2 – Directorio de trabajo y archivo inicial

### Reto 2.1 – Crear el primer archivo

1. Crea un archivo llamado `notas-git.md` con el siguiente contenido inicial (puedes usar tu editor favorito):

   ```markdown
   # Notas de Git – Actividad 6.1

   - Concepto 1:
   - Concepto 2:
   - Concepto 3:
   ```

2. Comprueba el estado del repositorio:
   ```bash
   git status
   ```

Debería aparecer `notas-git.md` como archivo **untracked** (sin seguimiento).

### Checkpoint 2 – Evidencia

- Crea un archivo de texto en el repositorio llamado `cp2-estado-inicial.txt`.
- Copia en él la salida de `git status` y añade una breve frase explicando qué significa que un archivo esté “untracked”.

---

## 🧩 Parte 3 – Zona de staging

### Reto 3.1 – Añadir el archivo a staging

1. Añade el archivo a la zona de staging:
   ```bash
   git add notas-git.md
   ```
2. Vuelve a ejecutar:
   ```bash
   git status
   ```

Ahora `notas-git.md` debería aparecer como “changes to be committed” (preparado para commit).

### Checkpoint 3 – Evidencia

- Actualiza `cp2-estado-inicial.txt` (o crea `cp3-staging.txt`) pegando la nueva salida de `git status`.
- Debajo, responde a estas preguntas:
  1. ¿Qué diferencia hay entre estar “untracked” y estar en “staging”?
  2. ¿Qué comando has utilizado para pasar el archivo a la zona de staging?

---

## 🧩 Parte 4 – Primer commit

### Reto 4.1 – Crear un commit con mensaje claro

1. Crea tu primer commit:
   ```bash
   git commit -m "Añade archivo de notas inicial sobre Git"
   ```
2. Comprueba el estado:
   ```bash
   git status
   ```
   Debería indicar “nothing to commit, working tree clean”.

3. Consulta el historial:
   ```bash
   git log --oneline
   ```
   Verás tu commit con un identificador corto y el mensaje.

### Checkpoint 4 – Evidencia

- Crea un archivo `cp4-primer-commit.txt` con:
  - La salida de `git log --oneline`.
  - Una breve explicación de por qué es importante escribir mensajes de commit claros.

---

## 🧩 Parte 5 – Simular trabajo real: varios cambios

### Reto 5.1 – Añadir contenido y hacer otro commit

1. Edita `notas-git.md` y rellena los conceptos, por ejemplo:

   ```markdown
   # Notas de Git – Actividad 6.1

   - Concepto 1: Directorio de trabajo
   - Concepto 2: Zona de staging
   - Concepto 3: Historial de commits
   ```

2. Comprueba el estado:
   ```bash
   git status
   ```
3. Añade los cambios a staging:
   ```bash
   git add notas-git.md
   ```
4. Crea un nuevo commit:
   ```bash
   git commit -m "Completa conceptos básicos de flujo en Git"
   ```
5. Revisa el historial:
   ```bash
   git log --oneline
   ```

### Checkpoint 5 – Evidencia

- Actualiza `cp4-primer-commit.txt` (o crea `cp5-historial.txt`) con el nuevo `git log --oneline`.
- Contesta:
  1. ¿Cuántos commits tienes ahora en el repositorio?
  2. ¿Qué diferencia hay entre el primer y el segundo commit?

---

## 🧩 Parte 6 – Reflexión final

Crea un archivo `reflexion-6-1.md` con respuestas breves (2–4 líneas por punto):

1. Explica con tus palabras la diferencia entre:
   - Directorio de trabajo.
   - Zona de staging.
   - Historial de commits.
2. Describe un error típico que podría cometer alguien que empieza con Git en este flujo (por ejemplo, olvidarse de `git add`) y cómo lo evitarías.
3. ¿Qué ventaja tiene poder decidir qué cambios entran en cada commit (gracias a la zona de staging)?

---

## 📦 Entrega esperada en el repositorio

Al terminar, tu repositorio de la actividad 6.1 debe incluir:

- `notas-git.md`
- `cp2-estado-inicial.txt`
- `cp3-staging.txt` (si lo has separado)
- `cp4-primer-commit.txt` o `cp5-historial.txt` (según cómo lo organices)
- `reflexion-6-1.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Flujo técnico correcto (uso de `git add`, `git commit`, `git status`, `git log`).
- 3 pts – Evidencias de los distintos estados (`untracked`, staging, commits) en los archivos de checkpoints.
- 3 pts – Calidad de la reflexión en `reflexion-6-1.md`.

**Puntuación máxima: 10 puntos.**

---