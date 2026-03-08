
# 🛡️ Actividad 6.25 – GitHub Environments y approvals en despliegues

> Has visto cómo desplegar con GitHub Actions.
> Ahora vas a añadir **“gates” de aprobación** usando GitHub Environments, para que ciertos despliegues (por ejemplo, a producción) requieran revisión manual antes de ejecutarse.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Crear **environments** en GitHub (development, staging, production) y asignarlos a jobs de Actions.
- Configurar **environment protection rules** con *required reviewers* y evitar self‑reviews.
- Entender y practicar el flujo “workflow pausado → revisión → aprobación → despliegue”.

---

## 🧩 Parte 1 – Crear environments en el repositorio

### Reto 1.1 – Configurar development, staging y production

1. En GitHub, ve a **Settings → Environments** del repositorio de despliegue (puedes reutilizar el de la Actividad 6.23/6.24).

2. Crea tres entornos:
   - `development`
   - `staging`
   - `production`

3. Para cada uno, puedes definir una URL (por ejemplo, URLs reales o ficticias de cada entorno).

4. En el entorno `production`, activa:
   - **Required reviewers**: añade 1–2 usuarios o equipos como revisores obligatorios.
   - Opción de **prevent self-reviews** para que la persona que dispara el deploy no pueda aprobarlo ella misma.

5. Crea `cp1-environments-config.txt` con:
   - Lista de environments creados.
   - Protecciones configuradas en `production` (required reviewers, prevent self-reviews).

---

## 🧩 Parte 2 – Workflow multi-entorno con approvals

### Reto 2.1 – Definir un pipeline dev → staging → production

1. En el repo, crea/edita `.github/workflows/release-pipeline.yml` con una estructura inspirada en el ejemplo oficial:

   ```yaml
   name: Release Pipeline with Environments

   on:
     push:
       branches: [main]

   jobs:
     build:
       runs-on: ubuntu-latest
       outputs:
         version: ${{ steps.version.outputs.version }}
       steps:
         - uses: actions/checkout@v4

         - name: Install deps
           run: npm ci

         - name: Run tests
           run: npm test

         - name: Build
           run: npm run build

         - name: Get version
           id: version
           run: echo "version=$(node -p \"require('./package.json').version\")" >> $GITHUB_OUTPUT

         - name: Upload artifact
           uses: actions/upload-artifact@v4
           with:
             name: build
             path: dist/

     deploy-dev:
       needs: build
       runs-on: ubuntu-latest
       environment:
         name: development
         url: https://dev.example.com
       steps:
         - uses: actions/download-artifact@v4
           with:
             name: build
         - name: Deploy to development
           run: ./deploy.sh development

     deploy-staging:
       needs: deploy-dev
       runs-on: ubuntu-latest
       environment:
         name: staging
         url: https://staging.example.com
       steps:
         - uses: actions/download-artifact@v4
           with:
             name: build
         - name: Deploy to staging
           run: ./deploy.sh staging
         - name: Smoke tests
           run: npm run test:smoke -- --url https://staging.example.com

     deploy-production:
       needs: deploy-staging
       runs-on: ubuntu-latest
       environment:
         name: production
         url: https://example.com
       steps:
         - uses: actions/download-artifact@v4
           with:
             name: build
         - name: Deploy to production
           run: ./deploy.sh production
   ```

   - Fíjate en la clave `environment:` en cada job: enlaza el job con un environment concreto y activa sus reglas de protección.

2. Adapta comandos (`npm`, rutas, URLs) a tu proyecto real o simulado.

3. Haz commit y push:

   ```bash
   git add .github/workflows/release-pipeline.yml
   git commit -m "ci: añade pipeline con environments y approvals"
   git push
   ```

### Checkpoint 2 – Evidencia

- Crea `cp2-release-pipeline-yml.txt` con:
  - El YAML del workflow (o la parte relevante).
  - Una explicación de cómo avanzan los jobs: build → deploy-dev → deploy-staging → deploy-production.

---

## 🧩 Parte 3 – Ver el workflow pausado esperando aprobación

### Reto 3.1 – Disparar el pipeline y aprobar el deploy a producción

1. Haz un pequeño cambio en el proyecto (texto, versión, etc.) y haz push a `main` para disparar el workflow.

2. Ve a **Actions** y observa:
   - `build`, `deploy-dev` y `deploy-staging` deben ejecutarse automáticamente si todo va bien.
   - Cuando llegue a `deploy-production`, el job debería quedar **en estado “Waiting for review”** debido a las reglas de `production`.

3. Como revisor designado (o simulando ese rol):

   - Ve a **Actions → el run concreto → desplegar job de producción**.
   - Verás la opción de **Approve / Reject deployment**.

4. Aprueba el despliegue y espera a que el job `deploy-production` se ejecute.

5. Comprueba que el deployment se marca como “successful” y que el entorno `production` muestra la última actualización.

### Checkpoint 3 – Evidencia

- Crea `cp3-aprobacion-deploy.txt` con:
  - Descripción del estado “Waiting for review” que viste.
  - Quién aprobó el deployment y qué pasó después (ejecución del job).

---

## 🧩 Parte 4 – Probar protección “sin self-review”

### Reto 4.1 – Evitar que quien dispara el pipeline sea quien aprueba

1. Asegúrate de que en el environment `production` está activa la opción para **prevent self-reviews**.

2. Con tu usuario (que está en la lista de required reviewers), haz un nuevo cambio en `main`:

   ```bash
   git commit -am "feat: cambio para probar self-review"
   git push
   ```

3. Deja que el workflow llegue de nuevo al job `deploy-production`.

4. Intenta aprobar el deployment desde la misma cuenta que hizo el push.
   - Deberías ver que **no puedes** aprobar o que se te impide completar la revisión, dependiendo de la configuración.

5. Simula que otro usuario (o describe el proceso) aprueba en tu lugar.

### Checkpoint 4 – Evidencia

- Crea `cp4-self-review.txt` con:
  - Descripción de lo que ocurre cuando intentas aprobar tu propio deployment.
  - Explicación de por qué esta protección es útil para entornos sensibles.

---

## 🧩 Parte 5 – (Opcional) Gates por entorno y múltiples approvals

### Reto 5.1 – Endurecer reglas de producción y suavizar otras

1. Ajusta las reglas de `staging` y `production` para explorar diferentes políticas, por ejemplo:
   - `staging`: sin required reviewers, despliegue automático.
   - `production`: required reviewers + espera mínima (delay) + restricción de branches.

2. Documenta cómo cambiaría el flujo de trabajo del equipo.

### Checkpoint 5 – Evidencia (opcional)

- Crea `cp5-politicas-entornos.txt` con:
  - Tabla/resumen de políticas para `development`, `staging`, `production`.
  - Justificación de por qué son distintas.

---

## 🧩 Parte 6 – Reflexión final: control de despliegues con environments

Crea `reflexion-6-25.md` y responde:

1. ¿Qué aportan los **environments con required reviewers** respecto a simplemente tener un workflow de deploy sin gates?
2. ¿En qué tipo de proyectos o equipos ves más necesario este tipo de approvals (por ejemplo, producción crítica, datos sensibles, equipos grandes)?
3. ¿Cómo combinarías environments, branch protection y PR reviews para tener una cadena de seguridad completa desde el cambio de código hasta producción?

---

## 📦 Entrega esperada en el repositorio

En el repo (por ejemplo `actividad-6-25-environments-approvals`) deben aparecer:

- `.github/workflows/release-pipeline.yml`
- `cp1-environments-config.txt`
- `cp2-release-pipeline-yml.txt`
- `cp3-aprobacion-deploy.txt`
- `cp4-self-review.txt`
- `cp5-politicas-entornos.txt` (si realizas la parte opcional)
- `reflexion-6-25.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Pipeline multi‑entorno funcional con `environment:` y gates de aprobación en producción.
- 3 pts – Configuración y documentación clara de las reglas de environments y el flujo de approvals.
- 3 pts – Calidad de la reflexión en `reflexion-6-25.md` (comprensión del valor de environments y approvals en un flujo de despliegue seguro).

**Puntuación máxima: 10 puntos.**

---