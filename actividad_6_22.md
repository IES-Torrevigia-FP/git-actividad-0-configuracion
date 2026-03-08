Aquí tienes la **Actividad 6.22** sobre *GitHub Actions en Pull Requests*, centrada en configurar workflows que se ejecutan automáticamente al abrir/actualizar PRs para correr tests y checks de calidad. [docs.github](https://docs.github.com/actions/using-workflows/events-that-trigger-workflows)

***

```markdown
# ⚙️ Actividad 6.22 – GitHub Actions en Pull Requests

> Has visto cómo crear y revisar Pull Requests.
> Ahora vas a añadir **GitHub Actions** para que, cada vez que se abra o actualice una PR, se ejecuten tests y otros checks automáticos.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Crear un workflow de GitHub Actions que se ejecute en eventos `pull_request`.
- Configurar jobs básicos (instalar dependencias, ejecutar tests o linters).
- Ver los resultados de la Action en la PR y entender cómo influyen en la revisión.

---

## 🧩 Parte 1 – Preparar el repositorio con una PR de prueba

### Reto 1.1 – Usar un repo con código sencillo

Puedes reutilizar el repo de la Actividad 6.20 (`actividad-6-20-pull-requests`) u otro repo con un pequeño proyecto Node.js / Python (ideal: algo que pueda ejecutar tests).

1. Clona (o entra en) el repo en local:

   ```bash
   git clone <URL_DEL_REPO> actividad-6-22-gh-actions-pr
   cd actividad-6-22-gh-actions-pr
   ```

2. Asegúrate de tener una rama principal (`main`) y al menos una rama de feature con una PR abierta o lista para abrir.

3. Crea `cp1-contexto-actions.txt` con:
   - URL del repo.
   - URL de una PR que usarás para probar el workflow (o indica que la crearás después).

---

## 🧩 Parte 2 – Crear un workflow básico para PR

### Reto 2.1 – Workflow mínimo que se ejecuta en `pull_request`

1. Crea el directorio de workflows si no existe:

   ```bash
   mkdir -p .github/workflows
   ```

2. Crea un archivo `.github/workflows/pr-checks.yml` con un workflow mínimo como este (ejemplo Node.js; adapta a tu stack):

   ```yaml
   name: PR Checks

   on:
     pull_request:
       branches:
         - main
       types: [opened, synchronize, reopened]

   jobs:
     test:
       name: Run tests on PR
       runs-on: ubuntu-latest

       steps:
         - name: Checkout code
           uses: actions/checkout@v4

         - name: Setup Node.js
           uses: actions/setup-node@v4
           with:
             node-version: '20'

         - name: Install dependencies
           run: npm ci

         - name: Run tests
           run: npm test
   ```

   - `on.pull_request` hace que el workflow se dispare cuando se abre/actualiza una PR hacia `main`.
   - El job `test` instala dependencias y ejecuta `npm test`.

3. Haz commit y push en la rama adecuada (normalmente `main`):

   ```bash
   git add .github/workflows/pr-checks.yml
   git commit -m "ci: añade workflow de tests en PR"
   git push
   ```

### Checkpoint 2 – Evidencia

- Crea `cp2-pr-checks-yml.txt` con:
  - El contenido de `.github/workflows/pr-checks.yml`.
  - Una breve explicación de qué eventos disparan el workflow y qué hace el job `test`.

---

## 🧩 Parte 3 – Abrir o actualizar una PR y ver la Action en acción

### Reto 3.1 – Disparar el workflow desde una Pull Request

1. Crea o actualiza una rama de feature (por ejemplo `feature/demo-actions`) con algún cambio trivial (texto, comentario…).

2. Haz push de la rama y abre una PR hacia `main` en GitHub.

3. Nada más crear o actualizar la PR:

   - Ve a la pestaña **Actions** del repo y observa que se ha lanzado el workflow `PR Checks`.
   - En la PR, comprueba la sección de checks (GitHub mostrará el estado: pending, success o failed).

4. Espera a que termine el job `test` y anota el resultado.

### Checkpoint 3 – Evidencia

- Crea `cp3-ejecucion-actions.txt` con:
  - Nombre de la PR usada.
  - Captura del resultado textual (o descripción) del workflow en la PR (success/failure) y enlace a la ejecución si quieres.

---

## 🧩 Parte 4 – Probar fallos de CI en la PR

### Reto 4.1 – Hacer que el workflow falle

1. Modifica algo en el proyecto para forzar un fallo de tests, por ejemplo:
   - Cambiar una expectativa en un test.
   - Introducir un error deliberado que haga que `npm test` devuelva código ≠ 0.

2. Haz commit en la rama de la PR y push:

   ```bash
   git add .
   git commit -m "test: fuerza fallo en los tests"
   git push
   ```

3. Observa de nuevo la PR:
   - El workflow se volverá a ejecutar (evento `synchronize`).
   - Comprueba que ahora los checks aparecen en rojo (fallidos).

4. Repara el problema (corrige el test o el código) y vuelve a hacer commit/push para conseguir que los checks pasen en verde.

### Checkpoint 4 – Evidencia

- Crea `cp4-fallos-y-arreglos-ci.txt` con:
  - Descripción de qué cambio provocó el fallo.
  - Descripción de cómo lo arreglaste.
  - Resultado final de la CI (de nuevo en verde).

---

## 🧩 Parte 5 – Extender el workflow con linting o build (opcional)

### Reto 5.1 – Añadir un segundo job de calidad

Opcionalmente, mejora el workflow añadiendo un job `lint` o `build`, por ejemplo:

```yaml
  lint:
    name: Lint
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - run: npm ci
      - run: npm run lint
```

- Asegúrate de tener `npm run lint` definido en `package.json`.

Haz commit, push y revisa la PR para ver que ahora se ejecutan varios jobs.

### Checkpoint 5 – Evidencia (opcional)

- Crea `cp5-lint-o-build.txt` con:
  - El fragmento añadido al workflow (job extra).
  - Descripción de qué comprueba este nuevo job.

---

## 🧩 Parte 6 – Reflexión final: CI en PR como “gatekeeper”

Crea `reflexion-6-22.md` y responde:

1. Explica con tus palabras qué beneficios aporta tener GitHub Actions que se ejecuten en cada PR (calidad, confianza, menos errores en main, etc.).
2. ¿Qué tipos de checks incluirías como obligatorios antes de poder fusionar una PR en un proyecto real (tests, lint, build, seguridad, cobertura mínima…)?
3. ¿Qué problemas pueden aparecer si los workflows de PR son demasiado lentos o inestables, y cómo podrías mitigarlos (caché, paths-filter, dividir jobs, etc.)?

---

## 📦 Entrega esperada en el repositorio

En `actividad-6-22-gh-actions-pr` deben aparecer:

- `.github/workflows/pr-checks.yml` (versión final del workflow).
- `cp1-contexto-actions.txt`
- `cp2-pr-checks-yml.txt`
- `cp3-ejecucion-actions.txt`
- `cp4-fallos-y-arreglos-ci.txt`
- `cp5-lint-o-build.txt` (si realizas la parte opcional)
- `reflexion-6-22.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Workflow correctamente configurado para eventos `pull_request` y ejecutado en al menos una PR.
- 3 pts – Evidencias claras de ejecución, fallo y posterior arreglo de CI en la PR.
- 3 pts – Calidad de la reflexión en `reflexion-6-22.md` (comprensión del rol de la CI en el proceso de revisión).

**Puntuación máxima: 10 puntos.**
```
