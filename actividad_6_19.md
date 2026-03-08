Aquí tienes la **Actividad 6.19** sobre Git en equipos colaborativos, centrada en flujo de ramas, buenas prácticas, pull requests y resolución de conflictos en equipo. [gitkraken](https://www.gitkraken.com/learn/git/best-practices/git-branch-strategy)

***

```markdown
# 🤝 Actividad 6.19 – Git en equipos colaborativos

> Hasta ahora has trabajado sobre todo en repos individuales.
> En esta actividad vas a practicar un **flujo de trabajo colaborativo** con ramas de feature, pull requests, revisiones de código y buenas prácticas de equipo.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Aplicar una **estrategia de ramas** sencilla para trabajo en equipo (por ejemplo, main + dev + feature/*).
- Trabajar con ramas de feature, sincronizarlas y fusionarlas mediante pull requests (PR).
- Gestionar conflictos y seguir buenas prácticas de commits, naming y protección de ramas.

---

## 🧩 Parte 1 – Definir el flujo de ramas del equipo

### Reto 1.1 – Crear la estructura básica de ramas

En esta actividad puedes simular un equipo con **dos personas** (por ejemplo, tú con dos clones del repo, o alternando ramas y roles).

1. Crea un nuevo repositorio:

   ```bash
   mkdir actividad-6-19-git-equipo
   cd actividad-6-19-git-equipo
   git init
   ```

2. Crea un archivo `README.md` con una breve descripción del proyecto, por ejemplo una pequeña API, app web o CLI.

3. Haz commit inicial en `main`:

   ```bash
   git add README.md
   git commit -m "Commit inicial del proyecto colaborativo"
   ```

4. Crea una rama `dev` que se usará como rama de integración:

   ```bash
   git checkout -b dev
   git push -u origin dev # si tienes remoto
   ```

   La idea:
   - `main`: siempre estable y desplegable.
   - `dev`: integración de features antes de pasar a `main`.

### Checkpoint 1 – Evidencia

- Crea `cp1-estructura-ramas.txt` con:
  - Salida de `git branch -a`.
  - Una breve explicación del rol de `main` y `dev` en tu flujo.

---

## 🧩 Parte 2 – Flujo de trabajo con ramas de feature

### Reto 2.1 – Crear y trabajar en feature branches

Vas a simular dos features: `feature/ui` y `feature/api`.

1. Desde `dev`, crea la rama `feature/ui`:

   ```bash
   git checkout dev
   git checkout -b feature/ui
   ```

   Añade un archivo `ui.md` o una carpeta `frontend/` con algún contenido.

2. Haz commits pequeños y claros (2–3 commits) en `feature/ui`.

3. Vuelve a `dev` y crea `feature/api`:

   ```bash
   git checkout dev
   git checkout -b feature/api
   ```

   Añade un archivo `api.md` o carpeta `backend/` con algo de código o especificación.

4. De nuevo, realiza 2–3 commits pequeños y descriptivos.

### Reto 2.2 – Mantener features sincronizadas con `dev`

1. Mientras trabajas en `feature/api`, simula que `dev` avanza (por ejemplo, mergeando `feature/ui` primero).

2. Desde `feature/api`, actualiza tu rama:

   ```bash
   git checkout feature/api
   git pull origin dev # o git fetch + merge/rebase según tu política
   ```

   El objetivo es practicar traer cambios de la rama base y resolver conflictos si los hay.

### Checkpoint 2 – Evidencia

- Crea `cp2-features.txt` con:
  - Los comandos clave que has usado para crear y actualizar `feature/ui` y `feature/api`.
  - Salida abreviada de `git log --oneline --all` donde se vean las ramas de feature.

---

## 🧩 Parte 3 – Pull requests y revisión de código (simulada)

> Esta parte se apoya en un remoto tipo GitHub/GitLab si lo tienes. Si no, documenta el proceso como si lo fueras a hacer.

### Reto 3.1 – PR de `feature/ui` hacia `dev`

1. Sube tus ramas al remoto:

   ```bash
   git push -u origin feature/ui
   git push -u origin feature/api
   ```

2. En la interfaz del remoto (GitHub/GitLab):

   - Crea una pull request con base `dev` y compare `feature/ui`.
   - Rellena título y descripción claros.

3. Simula una revisión de código:
   - Comenta en al menos 1–2 líneas, proponiendo mejoras o preguntando dudas.
   - Marca la PR como “aprobada” o “requiere cambios” según tus propios criterios.

4. Fusiona la PR a `dev` usando merge “normal” o squash, según prefieras.

### Reto 3.2 – PR de `feature/api` con conflictos

1. Después de haber integrado `feature/ui` en `dev`, crea una PR desde `feature/api` hacia `dev`.

2. Si generas conflictos (por ejemplo, editando la misma sección del README en ambas branches), resuélvelos localmente:
   ```bash
   git checkout feature/api
   git pull origin dev
   # Resolver conflictos en los archivos
   git add <archivos>
   git commit
   git push
   ```

3. Actualiza la PR, revisa y fusiona.

### Checkpoint 3 – Evidencia

- Crea `cp3-pull-requests.txt` con:
  - Descripción breve de cada PR (título, rama origen, rama destino).
  - Resumen de conflictos encontrados y cómo los has resuelto.

---

## 🧩 Parte 4 – Buenas prácticas de equipos: naming, protección, checklist

### Reto 4.1 – Definir estándares del equipo

Basándote en lo que has practicado y tu experiencia, define un **acuerdo de equipo** sencillo.

Crea un archivo `GIT_STANDARDS.md` con al menos:

1. Estrategia de ramas:
   - Prefijo `feature/`, `bugfix/`, `hotfix/` con ejemplo: `feature/login-form`.
   - Reglas sobre cuándo borrar ramas de feature tras merge.

2. Commits:
   - Mensajes cortos, en imperativo, un cambio lógico por commit.
   - No commitear código sin tests básicos (cuando aplique).

3. Reglas sobre ramas compartidas:
   - No usar `git push -f` en ramas compartidas (solo en ramas personales cuando sea necesario).
   - No hacer desarrollo directo en `main`.

4. Pull requests:
   - Tamaño razonable de PR.
   - Mínimo 1 revisor.
   - Revisión de conflictos y tests antes de fusionar.

### Checkpoint 4 – Evidencia

- El propio archivo `GIT_STANDARDS.md` es la evidencia.

---

## 🧩 Parte 5 – Simular errores típicos y cómo recuperarse

### Reto 5.1 – “Ups, hice push -f en la rama equivocada”

Simula un error típico y cómo lo resolverías:

1. En una rama de feature, realiza un rebase y un `push --force` (válido en ramas personales).

2. Reflexiona qué pasaría si esto se hiciera en `dev` o `main` y cómo lo mitigaríais:
   - Uso de ramas protegidas en el remoto.
   - Uso de PRs obligatorios y prohibición de `push -f` en ramas protegidas.

3. Opcional: usa `git reflog` para ilustrar cómo podrías recuperar el estado anterior si fuera necesario.

### Checkpoint 5 – Evidencia

- Crea `cp5-errores-y-rescate.txt` con:
  - Descripción de un error simulado (por ejemplo, mal uso de `rebase` o `push -f`).
  - Pasos que seguiríais como equipo para minimizar el daño y recuperarse (incluyendo herramientas Git y reglas de proceso).

---

## 🧩 Parte 6 – Reflexión final: tu flujo ideal de equipo

Crea `reflexion-6-19.md` y responde:

1. ¿Qué estrategia de ramas te convence más para un equipo pequeño: GitHub Flow (main + features), GitFlow (main + dev + release + hotfix), trunk-based, etc.? Justifica.
2. ¿Qué tres normas pondrías como “no negociables” para mantener la calidad del historial y evitar caos en producción?
3. ¿Qué parte del flujo colaborativo crees que será más difícil cumplir en un equipo real y qué harías para facilitarla (documentación, automatización, hooks, CI, etc.)?

---

## 📦 Entrega esperada en el repositorio

En `actividad-6-19-git-equipo` deben aparecer:

- Proyecto base (README, código o docs de ejemplo).
- `GIT_STANDARDS.md`
- `cp1-estructura-ramas.txt`
- `cp2-features.txt`
- `cp3-pull-requests.txt`
- `cp5-errores-y-rescate.txt`
- `reflexion-6-19.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Uso coherente de ramas (`main`, `dev`, `feature/*`) y PRs, con conflictos gestionados correctamente.
- 3 pts – Definición clara de estándares en `GIT_STANDARDS.md`.
- 3 pts – Calidad de la reflexión en `reflexion-6-19.md` (comprensión madura de Git en equipo).

**Puntuación máxima: 10 puntos.**
```
