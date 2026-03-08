
# 🪝 Actividad 6.18 – Git hooks: automatizar tareas en el flujo de trabajo

> Git permite enganchar scripts en distintos puntos del flujo (antes de un commit, antes de un push, después de un merge…).
> En esta actividad vas a crear **hooks locales** para automatizar comprobaciones básicas y ver cómo podrían compartirse con tu equipo.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Explicar qué es un Git hook y en qué momentos se ejecuta.
- Crear y probar al menos un hook de `pre-commit`, uno de `commit-msg` y uno de `pre-push`.
- Configurar un directorio de hooks versionado con `core.hooksPath` para poder compartirlos en un repo.

---

## 🧠 Conceptos clave: ¿qué son los Git hooks?

- Los Git hooks son **scripts** que se ejecutan automáticamente cuando ocurre un evento en un repositorio: pre-commit, commit-msg, pre-push, post-merge, etc.
- Se guardan por defecto en `.git/hooks` y no se versionan, pero puedes cambiar la ruta con `core.hooksPath` para compartirlos.
- Si el script termina con código distinto de 0, **bloquea** la acción (por ejemplo, aborta el commit o el push).

---

## 🧩 Parte 1 – Preparar el repositorio de pruebas

### Reto 1.1 – Crear un repo sencillo

1. Crea el repo:

   ```bash
   mkdir actividad-6-18-git-hooks
   cd actividad-6-18-git-hooks
   git init
   ```

2. Crea un archivo `src/app.js`:

   ```js
   // app.js
   // Ejemplo simple

   function main() {
     console.log("Hola desde app.js");
   }

   main();
   ```

3. Haz commit inicial:

   ```bash
   mkdir src
   mv app.js src/app.js # o crea directamente en src
   git add src/app.js
   git commit -m "Commit inicial con app.js"
   ```

### Checkpoint 1 – Evidencia

- Crea `cp1-repo-hooks.txt` con:
  - Salida de `git status`.
  - Salida de `git log --oneline`.

---

## 🧩 Parte 2 – Hook `pre-commit`: evitar commits con `console.log` o `WIP`

### Reto 2.1 – Crear un pre-commit local

1. Abre/crea el archivo `.git/hooks/pre-commit` y dale permisos de ejecución:

   ```bash
   nano .git/hooks/pre-commit # o tu editor
   chmod +x .git/hooks/pre-commit
   ```

2. Escribe un script como este (ejemplo para evitar `console.log` y mensajes WIP en código staged):

   ```bash
   #!/bin/bash

   # Buscar "console.log" en los archivos staged
   if git diff --cached --name-only | xargs grep -n "console.log" -H 2>/dev/null; then
     echo "❌ Se ha encontrado 'console.log' en los cambios staged."
     echo " Elimina o comenta los console.log antes de commitear."
     exit 1
   fi

   exit 0
   ```

   (Puedes adaptarlo según el lenguaje/proyecto).

3. Modifica `src/app.js` y añade un `console.log` extra:

   ```js
   console.log("DEBUG: esto no debería llegar al commit");
   ```

4. Intenta hacer commit:

   ```bash
   git add src/app.js
   git commit -m "Prueba pre-commit"
   ```

   Debería bloquearse el commit si el hook detecta `console.log`.

### Checkpoint 2 – Evidencia

- Crea `cp2-pre-commit.txt` con:
  - El contenido de `.git/hooks/pre-commit`.
  - Un resumen del resultado al intentar commitear con `console.log` (mensajes y bloqueo).

---

## 🧩 Parte 3 – Hook `commit-msg`: validar el formato del mensaje

### Reto 3.1 – Enforzar un formato mínimo del mensaje

1. Crea el hook `.git/hooks/commit-msg`:

   ```bash
   nano .git/hooks/commit-msg
   chmod +x .git/hooks/commit-msg
   ```

2. Añade un script que exija que el mensaje empiece por un tipo simple (`feat:`, `fix:`, `docs:`, etc.):

   ```bash
   #!/bin/bash

   COMMIT_MSG_FILE="$1"
   COMMIT_MSG=$(head -n1 "$COMMIT_MSG_FILE")

   PATTERN='^(feat|fix|docs|chore): .+'

   if [[ ! "$COMMIT_MSG" =~ $PATTERN ]]; then
     echo "❌ El mensaje de commit debe empezar por 'feat:', 'fix:', 'docs:' o 'chore:'."
     echo " Ejemplo: feat: añade nueva funcionalidad"
     exit 1
   fi

   exit 0
   ```



3. Arregla `src/app.js` quitando el `console.log` de debug, añade y prueba a commitear:

   - Mensaje inválido:

     ```bash
     git add src/app.js
     git commit -m "mensaje incorrecto"
     ```

     Debería fallar.

   - Mensaje válido:

     ```bash
     git commit -m "fix: corrige mensaje de debug"
     ```

     Debería funcionar.

### Checkpoint 3 – Evidencia

- Crea `cp3-commit-msg.txt` con:
  - Contenido de `.git/hooks/commit-msg`.
  - Resultado de intentar commitear con mensaje inválido y después con mensaje válido.

---

## 🧩 Parte 4 – Hook `pre-push`: ejecutar tests antes de hacer push

### Reto 4.1 – Simular tests con pre-push

1. Crea el hook `.git/hooks/pre-push`:

   ```bash
   nano .git/hooks/pre-push
   chmod +x .git/hooks/pre-push
   ```

2. Añade un script simplificado que simule tests:

   ```bash
   #!/bin/bash

   echo "▶ Ejecutando tests antes del push..."

   # Simulación: si existe el archivo FAIL_TESTS, fallar
   if [ -f FAIL_TESTS ]; then
     echo "❌ Tests fallidos (archivo FAIL_TESTS encontrado). Abortando push."
     exit 1
   fi

   echo "✅ Tests OK. Continuando con el push."
   exit 0
   ```

   (En un proyecto real, aquí podrías ejecutar `npm test`, `pytest`, etc.).

3. Crea un remoto local o ficticio (puedes usar `git remote add origin <ruta_falsa>` si solo quieres ver que se bloquea antes de contactar con el servidor).

4. Crea el archivo `FAIL_TESTS`:

   ```bash
   touch FAIL_TESTS
   ```

5. Intenta hacer push:

   ```bash
   git push origin main
   ```

   Debería bloquearse por el hook.

6. Borra `FAIL_TESTS` y vuelve a intentarlo.

### Checkpoint 4 – Evidencia

- Crea `cp4-pre-push.txt` con:
  - El contenido de `.git/hooks/pre-push`.
  - Descripción de qué pasa con `FAIL_TESTS` presente y ausente al hacer push.

---

## 🧩 Parte 5 – Compartir hooks con `core.hooksPath`

### Reto 5.1 – Mover hooks a un directorio versionado

Por defecto, `.git/hooks` no se versiona. Vas a:

1. Crear una carpeta `.githooks` en el repo y mover ahí tus scripts:

   ```bash
   mkdir .githooks
   cp .git/hooks/pre-commit .githooks/pre-commit
   cp .git/hooks/commit-msg .githooks/commit-msg
   cp .git/hooks/pre-push .githooks/pre-push
   chmod +x .githooks/*
   ```

2. Configurar Git para usar `.githooks` como directorio de hooks:

   ```bash
   git config core.hooksPath .githooks
   ```

   A partir de ahora, Git ejecutará los hooks desde `.githooks` en lugar de `.git/hooks`, y puedes versionarlos.

3. Haz commit de `.githooks` y de la configuración si quieres documentarla (por ejemplo en el README).

### Checkpoint 5 – Evidencia

- Crea `cp5-core-hooksPath.txt` con:
  - El comando `git config core.hooksPath .githooks`.
  - Listado de archivos dentro de `.githooks`.
  - Una breve explicación de cómo esto permite compartir hooks con el equipo.

---

## 🧩 Parte 6 – Reflexión final

Crea `reflexion-6-18.md` y responde:

1. Explica con tus palabras qué diferencia hay entre hooks de cliente (pre-commit, commit-msg, pre-push) y hooks de servidor (pre-receive, post-receive, etc.).
2. Describe **dos ejemplos reales** de cosas útiles que automatizarías con hooks en tu contexto (por ejemplo, linting, tests, detectar secretos/API keys, normalizar mensajes de commit).
3. ¿Qué riesgos o malas prácticas pueden aparecer si los hooks son demasiado estrictos o lentos, y cómo los mitigarías?

---

## 📦 Entrega esperada en el repositorio

En `actividad-6-18-git-hooks` deben aparecer:

- `src/app.js` (versión final).
- Carpeta `.githooks/` con al menos:
  - `pre-commit`
  - `commit-msg`
  - `pre-push`
- `cp1-repo-hooks.txt`
- `cp2-pre-commit.txt`
- `cp3-commit-msg.txt`
- `cp4-pre-push.txt`
- `cp5-core-hooksPath.txt`
- `reflexion-6-18.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Creación y funcionamiento correcto de los tres hooks (pre-commit, commit-msg, pre-push).
- 3 pts – Configuración de `core.hooksPath` y versionado de los hooks en `.githooks`.
- 3 pts – Calidad de la reflexión en `reflexion-6-18.md` (visión práctica de cómo los hooks mejoran calidad y flujo de trabajo).

**Puntuación máxima: 10 puntos.**

---