Actividad 6.16 puede servir como “cierre” del módulo 6: un repaso aplicado donde el alumnado combina varias técnicas avanzadas en un mini‑proyecto y explora alguna funcionalidad menos común (hooks, rerere, atributos, notas). [atlassian](https://www.atlassian.com/git/tutorials/advanced-overview)

Te propongo una actividad tipo **laboratorio integrador** en formato `README.md`, con bloques optativos.

***

```markdown
# 🧠 Actividad 6.16 – Laboratorio de Git avanzado

> En el módulo 6 has visto ramas, rebase, cherry-pick, stash, reset, revert, log/reflog, blame, bisect, worktree, submodule y subrepo.
> En esta actividad vas a **combinar varias técnicas avanzadas en un mini-proyecto** y explorar algunas funcionalidades extra como hooks, `rerere`, notas y atributos.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Diseñar y ejecutar un flujo de trabajo de Git avanzado sobre un pequeño proyecto.
- Configurar y usar al menos **dos funcionalidades poco habituales** (hooks simples, `git rerere`, `git notes`, `git attributes`, alias avanzados).
- Documentar tu flujo de trabajo y justificar las decisiones tomadas.

---

## 🧩 Parte 1 – Preparar el mini-proyecto

### Reto 1.1 – Crear el repositorio de laboratorio

1. Crea un repositorio nuevo llamado `actividad-6-16-git-avanzado`:

   ```bash
   mkdir actividad-6-16-git-avanzado
   cd actividad-6-16-git-avanzado
   git init
   ```

2. Crea un pequeño proyecto (elige uno):

   - Opción A: app de consola (`app.js` o `app.py`) que haga algo simple (por ejemplo, sumar números, leer un archivo, etc.).
   - Opción B: mini‑proyecto con varios archivos (una “mini‑API” o un CLI de ejemplo).

3. Haz un commit inicial con el proyecto funcionando:

   ```bash
   git add .
   git commit -m "Commit inicial del laboratorio avanzado"
   ```

4. Crea al menos dos ramas:

   ```bash
   git checkout -b feature-a
   # Haz algún cambio sencillo y commit
   git checkout main
   git checkout -b feature-b
   # Haz otro cambio y commit
   git checkout main
   ```

### Checkpoint 1 – Evidencia

- Crea `cp1-contexto.txt` con:
  - Descripción breve del mini‑proyecto (qué hace).
  - Salida de `git log --oneline --all`.

---

## 🧩 Parte 2 – Flujo avanzado integrado (rebase, cherry-pick, stash, reset…)

### Reto 2.1 – Simular un flujo con varias herramientas

En esta parte debes demostrar que sabes **usar y combinar** varios comandos avanzados en un flujo coherente. Te propongo:

1. Sitúate en `feature-a` y realiza cambios incompletos, luego guárdalos con `git stash`.
2. Cambia a `feature-b`, realiza un bugfix y cherry‑pickea ese bugfix a `main`.
3. Vuelve a `feature-a`, recupera el stash y haz `git rebase main` para actualizar la rama.
4. Ajusta el historial de `feature-a` con `git rebase -i` (por ejemplo, squash de commits pequeños).
5. Si cometes un error, usa `git reset` o `git reflog` para recuperar el estado.

No se prescribe exactamente el código; lo importante es que **documentes qué has hecho y por qué**.

### Checkpoint 2 – Evidencia

- Crea `cp2-flujo-avanzado.txt` con:
  - Lista ordenada de los comandos clave que has usado (`stash`, `cherry-pick`, `rebase`, `rebase -i`, `reset`, etc.), con 1–2 líneas de explicación por paso.
  - Salida final de `git log --oneline --all` mostrando el resultado del flujo.

---

## 🧩 Parte 3 – Funcionalidad avanzada 1: Hooks simples

### Reto 3.1 – Configurar un hook de `pre-commit` o `commit-msg`

1. En `.git/hooks`, copia el ejemplo de `pre-commit.sample` a `pre-commit` o crea uno nuevo:

   ```bash
   cp .git/hooks/pre-commit.sample .git/hooks/pre-commit
   chmod +x .git/hooks/pre-commit
   ```

2. Modifica el hook para que haga algo sencillo, por ejemplo:

   - Bloquear commits si hay la palabra `WIP` en el mensaje.
   - Ejecutar un script de tests (aunque sea un echo o un comando sencillo).

   Ejemplo mínimo (en `pre-commit`):

   ```bash
   #!/bin/bash
   if git diff --cached | grep -q "console.log"; then
     echo "Evita subir console.log en commits finales."
     exit 1
   fi
   ```

3. Intenta hacer un commit que dispare el hook (por ejemplo, con `console.log`) y comprueba que se bloquea; luego arréglalo y vuelve a commitear.

### Checkpoint 3 – Evidencia

- Crea `cp3-hook.txt` con:
  - El contenido de tu hook (`pre-commit` o `commit-msg`).
  - Una breve explicación de qué problema ayuda a evitar en el flujo de trabajo.

---

## 🧩 Parte 4 – Funcionalidad avanzada 2: `git rerere`, `notes` o `attributes`

Elige **al menos una** de estas funcionalidades y aplícala en tu repo:

### Opción A – `git rerere` (Reuse Recorded Resolution)

1. Activa rerere globalmente o solo en este repo:

   ```bash
   git config rerere.enabled true
   ```

2. Crea un conflicto artificial (por ejemplo, modificando la misma línea en dos ramas y haciendo merge).
3. Resuélvelo una primera vez y completa el merge.
4. Repite el conflicto (reset y reproduce el escenario); comprueba que `rerere` recuerda tu resolución y la aplica automáticamente o con ayuda mínima.

Guarda en `cp4a-rerere.txt`:
- Comandos usados.
- Descripción de cómo rerere ha recordado tu resolución.

### Opción B – `git notes`

1. Activa notas y añade una nota a un commit importante:

   ```bash
   git notes add -m "Explicación adicional de este commit clave" <hash>
   ```

2. Muestra las notas:

   ```bash
   git log --show-notes
   ```

3. Explica cómo podrías usar notas para documentar decisiones sin ensuciar mensajes de commit.

Guarda en `cp4b-notes.txt`:
- Comandos usados.
- Ejemplo de salida de `git log --show-notes`.

### Opción C – `git attributes` (formato, diff, linguist…)

1. Crea un archivo `.gitattributes` donde definas algún comportamiento, por ejemplo:

   - Forzar `text eol=lf` para ciertos ficheros.
   - Definir un `diff` especial para un tipo de archivo.
   - Marcar archivos binarios para que no se diff‑een.

2. Haz un cambio que demuestre el efecto (por ejemplo, ver cómo se muestra el diff).

Guarda en `cp4c-attributes.txt`:
- Contenido de `.gitattributes`.
- Breve explicación de su efecto.

---

## 🧩 Parte 5 – Reflexión final del módulo 6

Crea `reflexion-6-16.md` y responde:

1. De todas las herramientas avanzadas vistas en el módulo 6, ¿cuáles crees que usarás más en tu día a día y por qué?
2. Describe un flujo de trabajo de Git “ideal” para un equipo de desarrollo de tamaño medio (5–10 personas), nombrando explícitamente algunas herramientas que ayudarían (hooks, rebase, worktrees, CI, etc.).
3. Identifica un error frecuente que cometías (o podrías cometer) con Git antes de este módulo y explica cómo lo evitarás a partir de ahora.

---

## 📦 Entrega esperada en el repositorio

En `actividad-6-16-git-avanzado` deben aparecer:

- Código del mini‑proyecto (app y archivos auxiliares).
- `.git/hooks/pre-commit` (u otro hook si lo has creado).
- `.gitattributes`, `git notes` u otra funcionalidad avanzada si la has usado.
- `cp1-contexto.txt`
- `cp2-flujo-avanzado.txt`
- `cp3-hook.txt`
- `cp4a-rerere.txt` / `cp4b-notes.txt` / `cp4c-attributes.txt` (según la opción elegida, puede haber más de uno si exploras varias).
- `reflexion-6-16.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Flujo avanzado bien diseñado en `cp2-flujo-avanzado.txt` (uso coherente de varias herramientas).
- 3 pts – Implementación de al menos dos funcionalidades avanzadas (hooks + una de rerere/notes/attributes) con evidencias claras.
- 3 pts – Calidad de la reflexión en `reflexion-6-16.md` (visión global y madura del uso de Git en equipo).

**Puntuación máxima: 10 puntos.**

---
```
