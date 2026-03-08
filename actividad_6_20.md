
# 📥 Actividad 6.20 – GitHub Pull Requests: de la rama al merge

> Las Pull Requests (PR) son el corazón de la colaboración en GitHub: permiten proponer cambios, revisarlos y discutirlos antes de fusionarlos.
> En esta actividad practicarás el flujo completo: crear una rama, abrir una PR, revisar, aplicar cambios y fusionar.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Crear una Pull Request desde una rama de feature hacia `main` o `dev`.
- Escribir títulos y descripciones claras y útiles para las PRs.
- Participar en una revisión: comentar, solicitar cambios, actualizar la PR y fusionarla.

---

## 🧩 Parte 1 – Preparar el repositorio en GitHub

### Reto 1.1 – Crear repo remoto y clonarlo

1. En GitHub, crea un repositorio nuevo llamado `actividad-6-20-pull-requests` (público o privado).
2. Clónalo en local:

   ```bash
   git clone <URL_DEL_REPO> actividad-6-20-pull-requests
   cd actividad-6-20-pull-requests
   ```

3. Crea un archivo `README.md` con una breve descripción (por ejemplo, “Demo de Pull Requests en GitHub”).

4. Haz commit y push:

   ```bash
   git add README.md
   git commit -m "docs: añade README inicial"
   git push -u origin main
   ```

### Checkpoint 1 – Evidencia

- Crea `cp1-repo-remoto.txt` con:
  - URL del repositorio en GitHub.
  - Salida de `git remote -v`.

---

## 🧩 Parte 2 – Crear una rama y hacer cambios

### Reto 2.1 – Rama de feature local

1. Crea y cambia a una rama de feature, por ejemplo `feature/mejora-readme`:

   ```bash
   git checkout -b feature/mejora-readme
   ```

2. Edita `README.md` para añadir secciones como:

   - Objetivo del proyecto.
   - Tecnologías usadas.
   - Cómo ejecutar el proyecto (aunque sea un simple `echo`).

3. Haz uno o dos commits pequeños y descriptivos:

   ```bash
   git add README.md
   git commit -m "docs: añade objetivos del proyecto"

   git commit --amend # si quieres ajustar el mensaje, opcional
   ```

4. Sube la rama a GitHub:

   ```bash
   git push -u origin feature/mejora-readme
   ```

   En GitHub verás un banner “Compare & pull request” para esa rama.

### Checkpoint 2 – Evidencia

- Crea `cp2-rama-feature.txt` con:
  - Nombre de la rama creada.
  - Salida de `git log --oneline` en esa rama.

---

## 🧩 Parte 3 – Crear la Pull Request en GitHub

### Reto 3.1 – Abrir la PR con buena descripción

1. En la página del repo en GitHub, haz clic en el botón “Compare & pull request” o ve a la pestaña **Pull requests** y pulsa “New pull request”.

2. Asegúrate de que:
   - **Base branch**: `main`.
   - **Compare branch**: `feature/mejora-readme`.

3. Rellena:
   - **Título** claro, por ejemplo: `docs: mejora documentación del README`.
   - **Descripción** usando Markdown, incluyendo:
     - Contexto (qué problema resuelve o qué mejora añade).
     - Lista de cambios principales.
     - Cómo probar o revisar (si aplica).

4. Crea la PR (“Create pull request”).

### Checkpoint 3 – Evidencia

- Crea `cp3-detalles-pr.txt` con:
  - Título de la PR.
  - Descripción de la PR (puedes copiarla del formulario de GitHub).

---

## 🧩 Parte 4 – Simular revisión de código y cambios

### Reto 4.1 – Comentar y solicitar cambios

1. En la PR, ve a la pestaña **Files changed** y deja al menos 2 comentarios en líneas concretas, por ejemplo:
   - Sugerir reescribir una frase.
   - Proponer añadir una sección (instalación, licencia, etc.).

2. Si puedes usar otra cuenta o un compañero, que esa persona:
   - Revise la PR.
   - Use “Request changes” o “Approve” según considere.

   Si estás solo, simula el rol del revisor y documenta la intención.

### Reto 4.2 – Actualizar la PR en respuesta a feedback

1. Vuelve a tu repo local en la rama `feature/mejora-readme`.

2. Aplica los cambios sugeridos en los comentarios (por ejemplo, mejora textos o añade secciones).

3. Haz nuevos commits:

   ```bash
   git add README.md
   git commit -m "docs: aplica sugerencias de revisión"
   git push
   ```

   Los nuevos commits se añaden automáticamente a la PR abierta.

4. Marca los comentarios como “Resolved” en GitHub, si procede.

### Checkpoint 4 – Evidencia

- Crea `cp4-revision-y-updates.txt` con:
  - Resumen de los comentarios de revisión realizados.
  - Lista de cambios que hiciste después del feedback.

---

## 🧩 Parte 5 – Fusionar la Pull Request y limpiar ramas

### Reto 5.1 – Merge desde GitHub

1. Cuando la PR esté aprobada (o cuando lo decidas para el ejercicio), pulsa el botón de **Merge** (puede ser “Merge pull request” o “Squash and merge”, según tu preferencia).

2. Confirma el merge y, si GitHub te lo ofrece, **borra la rama** `feature/mejora-readme` desde la propia interfaz.

3. En local, actualiza tu `main`:

   ```bash
   git checkout main
   git pull origin main
   ```

4. Limpia ramas locales que ya no necesites:

   ```bash
   git branch -d feature/mejora-readme
   ```

### Checkpoint 5 – Evidencia

- Crea `cp5-merge-y-limpieza.txt` con:
  - Tipo de merge usado (merge normal, squash, etc.).
  - Salida de `git log --oneline` en `main` después del merge.

---

## 🧩 Parte 6 – (Opcional) PR desde un fork (colaboración en OSS)

> Esta parte es opcional, pero muy útil para entender contribuciones a proyectos de terceros.

### Reto 6.1 – Flujo básico de contribución vía fork

1. Elige un repositorio sencillo en GitHub que permita contribuciones (por ejemplo, uno de ejercicios o documentación).

2. Haz un **fork** del repositorio a tu cuenta.

3. Clona el fork, crea una rama, haz un cambio mínimo (corregir un typo, mejorar README, etc.) y sube la rama a tu fork.

4. Desde la página de tu fork, crea una PR hacia el repo original (upstream).

### Checkpoint 6 – Evidencia (opcional)

- Crea `cp6-pr-fork.txt` con:
  - URL del repositorio original y de tu fork.
  - URL de la PR enviada al proyecto upstream (aunque quede pendiente).

---

## 🧩 Parte 7 – Reflexión final: buenas prácticas de PR

Crea `reflexion-6-20.md` y responde:

1. ¿Qué elementos crees que son imprescindibles en una **buena descripción de PR** (contexto, cambios, pruebas, riesgos, etc.)?
2. ¿Por qué es importante mantener las PR pequeñas y enfocadas, y qué problemas generan las PR “gigantes”?
3. Desde el punto de vista del revisor, ¿qué hábitos ayudan a hacer revisiones de código útiles y respetuosas?

---

## 📦 Entrega esperada en el repositorio

En `actividad-6-20-pull-requests` deben aparecer:

- `README.md` (versión final).
- `cp1-repo-remoto.txt`
- `cp2-rama-feature.txt`
- `cp3-detalles-pr.txt`
- `cp4-revision-y-updates.txt`
- `cp5-merge-y-limpieza.txt`
- `cp6-pr-fork.txt` (si realizas la parte opcional)
- `reflexion-6-20.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Flujo correcto de creación de PR, actualización y merge en GitHub.
- 3 pts – Buena documentación en checkpoints y calidad de títulos/descripciones de PR.
- 3 pts – Calidad de la reflexión en `reflexion-6-20.md` (comprensión del rol de las PR en la colaboración).

**Puntuación máxima: 10 puntos.**

---