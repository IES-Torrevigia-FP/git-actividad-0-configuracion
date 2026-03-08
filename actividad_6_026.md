
# 📋 Actividad 6.26 – GitHub Projects: planificación y seguimiento

> GitHub Projects te permite gestionar tareas (issues, PRs, notas) con vistas de tabla, tablero Kanban y roadmap, directamente junto al código.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Crear un GitHub Project asociado a un repositorio.
- Configurar vistas de **tabla**, **tablero (Board)** y **roadmap**.
- Añadir issues/PRs al proyecto y usar campos personalizados (estado, prioridad, fechas).

---

## 🧩 Parte 1 – Crear el Project y vincularlo al repo

### Reto 1.1 – Crear un proyecto de curso

1. En GitHub, entra al repositorio donde quieras planificar (por ejemplo, `actividad-6-26-github-projects`).

2. Ve a la pestaña **Projects** del repo o a tu perfil → **Projects** y pulsa **New project**.

3. Elige **Start from scratch → Board** o **Table** (lo cambiarás después).

4. Nombra el proyecto, por ejemplo: `Roadmap Módulo 6 – Git`. Añade una breve descripción (qué módulo/curso estás gestionando).

### Checkpoint 1 – Evidencia

- Crea `cp1-project-creado.txt` en el repo con:
  - URL del Project.
  - Tipo inicial de vista (Table/Board).

---

## 🧩 Parte 2 – Poblar el Project con trabajo (issues, PRs, draft items)

### Reto 2.1 – Crear issues representando tareas

1. En el repositorio, crea al menos **5 issues** que representen trabajo del módulo (por ejemplo: “Preparar enunciados del tema 6”, “Corregir ejercicios de git reset”, etc.).

2. Desde el Project:
   - Usa **+ Add item** o **Add items** para añadir issues existentes al Project.
   - Crea al menos un **Draft item** directamente desde el Project (tarea que aún no es issue).

3. Comprueba que ves todos los elementos en la vista actual.

### Checkpoint 2 – Evidencia

- Crea `cp2-items-en-project.txt` con:
  - Lista de los títulos de los items en el Project (issues + draft).
  - Indica qué items son issues y cuál es draft.

---

## 🧩 Parte 3 – Configurar campos (Status, Priority, Iteration, Owner…)

### Reto 3.1 – Añadir y usar campos personalizados

1. En la vista de **Table**, añade o verifica los campos:

   - `Status` (To do, In progress, Done).
   - `Priority` (High, Medium, Low).
   - `Assignee` (quién se encarga).
   - Opcional: un campo de tipo `Date` (por ejemplo, `Target date`).

2. Para cada item del Project:
   - Asigna un Status.
   - Define Priority.
   - Asigna a una persona (o a ti mismo).
   - Rellena `Target date` orientativo.

### Checkpoint 3 – Evidencia

- Crea `cp3-campos-y-valores.txt` con:
  - Nombres de los campos que has configurado.
  - Una pequeña tabla (en texto) con 3–4 items y sus valores de Status, Priority y Target date.

---

## 🧩 Parte 4 – Vistas: Board (Kanban) y Roadmap

### Reto 4.1 – Crear una vista tipo Board (Kanban)

1. En el Project, crea una **New view** y selecciona layout **Board**.

2. Configura las columnas basadas en el campo `Status` (To do / In progress / Done).

3. Arrastra varios items entre columnas para simular el avance del trabajo.

### Reto 4.2 – Crear una vista tipo Roadmap

1. Crea otra **New view** y selecciona layout **Roadmap** (timeline).

2. Usa el campo de fecha (`Target date` o similar) para posicionar los items en el tiempo.

3. Ajusta el rango de fechas para ver el periodo del módulo (por ejemplo, las próximas 4–6 semanas).

### Checkpoint 4 – Evidencia

- Crea `cp4-vistas-board-roadmap.txt` con:
  - Nombres de las vistas que has creado (Board y Roadmap).
  - Breve descripción de cómo se organizan (por columnas en Board, por fechas en Roadmap).

---

## 🧩 Parte 5 – Automatización básica (status vinculado a issues/PRs)

### Reto 5.1 – Vincular progreso al estado real de issues/PRs

1. Abre una de las issues del Project, trabájala y ciérrala (Close issue).

2. En el Project, observa cómo se actualiza la información (según configuración), por ejemplo cambios de estado si usas workflows o campos vinculados.

3. Opcional: crea una PR vinculada a una issue del Project y añádela también como item.

### Checkpoint 5 – Evidencia

- Crea `cp5-sincronizacion-issues.txt` con:
  - Ejemplo de issue cerrada y cómo se refleja en el Project.
  - Comentario sobre por qué es útil tener Projects como “fuente de verdad” para seguimiento (single source of truth).

---

## 🧩 Parte 6 – Reflexión final: uso de GitHub Projects en tu contexto

Crea `reflexion-6-26.md` y responde:

1. ¿Qué vista (Table, Board, Roadmap) crees que usarías más para organizar tu trabajo diario como docente/desarrollador y por qué?
2. ¿Qué campos personalizados consideras imprescindibles para tus proyectos (estado, prioridad, tipo de tarea, fecha, módulo, grupo de alumnos…)?
3. ¿Cómo integrarías GitHub Projects con issues y PRs para que el alumnado vea claramente qué hay que hacer y qué está en progreso o terminado?

---

## 📦 Entrega esperada en el repositorio

En `actividad-6-26-github-projects` (o repo que hayas usado) deben aparecer:

- `cp1-project-creado.txt`
- `cp2-items-en-project.txt`
- `cp3-campos-y-valores.txt`
- `cp4-vistas-board-roadmap.txt`
- `cp5-sincronizacion-issues.txt`
- `reflexion-6-26.md`

*(El propio GitHub Project vive en GitHub; aquí solo entregas la documentación de lo que has configurado.)*

---

## 🏁 Evaluación sugerida

- 4 pts – Project correctamente creado con items, campos y varias vistas (Table/Board/Roadmap).
- 3 pts – Evidencias claras de configuración y sincronización con issues/PRs.
- 3 pts – Calidad de la reflexión en `reflexion-6-26.md` (visión práctica de GitHub Projects como herramienta de planificación).

**Puntuación máxima: 10 puntos.**

---