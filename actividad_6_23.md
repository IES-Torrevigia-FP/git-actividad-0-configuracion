Aquí tienes la **Actividad 6.23** sobre *GitHub Actions para despliegue*, centrada en automatizar el deploy (por ejemplo, a GitHub Pages) al hacer push a `main` tras pasar CI. [github](https://github.com/peaceiris/actions-gh-pages)

***

```markdown
# 🚀 Actividad 6.23 – GitHub Actions para deploy

> Ya has usado GitHub Actions para ejecutar checks en PRs.
> Ahora vas a configurar un **pipeline de deploy** con GitHub Actions que publique tu aplicación automáticamente cuando se actualice la rama principal.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Crear un workflow de GitHub Actions que despliegue una aplicación estática a GitHub Pages (o similar).
- Condicionar el despliegue a que los tests pasen correctamente.
- Entender qué eventos disparan el deploy y cómo monitorizarlo.

---

## 🧩 Parte 1 – Preparar una app estática sencilla

### Reto 1.1 – Crear o reutilizar un proyecto

Puedes usar:

- Una SPA muy simple (HTML + CSS + JS)
- O un proyecto generado con Vite / React / similar que genere archivos estáticos en `dist/`.

1. Crea o adapta un repo llamado `actividad-6-23-deploy-actions` en GitHub.

2. Clónalo en local:

   ```bash
   git clone <URL_DEL_REPO> actividad-6-23-deploy-actions
   cd actividad-6-23-deploy-actions
   ```

3. Asegúrate de que el proyecto se construye localmente (por ejemplo):

   ```bash
   npm install
   npm run build
   ```

   y que el resultado se genera en una carpeta como `dist/` o `build/`.

4. Crea `cp1-contexto-deploy.txt` con:
   - URL del repo.
   - Comando de build que genera los archivos estáticos.

---

## 🧩 Parte 2 – Configurar GitHub Pages como destino (si usas Pages)

### Reto 2.1 – Activar GitHub Pages

1. En GitHub, ve a **Settings → Pages**.
2. Configura como fuente de publicación **GitHub Actions** (no rama).

Esto indica que GitHub Pages tomará el contenido de un workflow de Actions en lugar de una rama específica.

Guarda una nota en `cp2-gh-pages-config.txt` explicando:

- Que has elegido GitHub Actions como fuente.

---

## 🧩 Parte 3 – Workflow CI + deploy a GitHub Pages

### Reto 3.1 – Crear el workflow de build y deploy

1. En el repo, crea `.github/workflows/deploy.yml` con un flujo basado en el ejemplo oficial de Pages (ajusta comandos de build según tu proyecto):

   ```yaml
   name: CI + Deploy to GitHub Pages

   on:
     push:
       branches: ["main"]
     workflow_dispatch:

   permissions:
     contents: read
     pages: write
     id-token: write

   concurrency:
     group: "pages"
     cancel-in-progress: false

   jobs:
     build:
       name: Build project
       runs-on: ubuntu-latest
       steps:
         - name: Checkout
           uses: actions/checkout@v4

         - name: Setup Node.js
           uses: actions/setup-node@v4
           with:
             node-version: "20"

         - name: Install dependencies
           run: npm ci

         - name: Run tests
           run: npm test

         - name: Build
           run: npm run build

         - name: Upload artifact
           uses: actions/upload-pages-artifact@v3
           with:
             path: ./dist # o ./build según tu proyecto

     deploy:
       name: Deploy to GitHub Pages
       needs: build
       runs-on: ubuntu-latest
       environment:
         name: github-pages
         url: ${{ steps.deployment.outputs.page_url }}
       steps:
         - name: Deploy to GitHub Pages
           id: deployment
           uses: actions/deploy-pages@v4
   ```

   - El workflow se dispara en `push` a `main` y manualmente con `workflow_dispatch`.
   - El job `deploy` depende de `build` (`needs: build`), por lo que solo se ejecuta si el build y los tests pasan.

2. Haz commit y push:

   ```bash
   git add .github/workflows/deploy.yml
   git commit -m "ci: añade workflow de build y deploy a GitHub Pages"
   git push
   ```

### Checkpoint 3 – Evidencia

- Crea `cp3-deploy-yml.txt` con:
  - El contenido de `deploy.yml`.
  - Una breve explicación de la relación `build` → `deploy` y del evento que dispara el workflow.

---

## 🧩 Parte 4 – Ejecutar el deploy y verificar la web

### Reto 4.1 – Desencadenar el primer despliegue

1. Haz un cambio pequeño en el proyecto (por ejemplo, en el texto de la página principal).

2. Haz commit y push a `main`:

   ```bash
   git add .
   git commit -m "feat: actualiza contenido de la home"
   git push
   ```

3. Ve a la pestaña **Actions** en GitHub y observa el workflow `CI + Deploy to GitHub Pages` ejecutándose.

4. Cuando termine, ve a **Settings → Pages** o a la URL que se muestre en el job `deploy` (salida `page_url`) y comprueba que la web está actualizada.

### Checkpoint 4 – Evidencia

- Crea `cp4-despliegue-ok.txt` con:
  - El enlace público a tu GitHub Pages.
  - Una breve descripción de qué cambio de código verificaste en la web desplegada.

---

## 🧩 Parte 5 – Probar fallo de build/tests y ver impacto en el deploy

### Reto 5.1 – Romper los tests para bloquear el deploy

1. Modifica algo para que `npm test` falle (por ejemplo, cambia una expectativa o lanza una excepción en un test).

2. Haz commit y push a `main`.

3. Observa el workflow:

   - El job `build` debería fallar.
   - El job `deploy`, al depender de `build`, **no debería ejecutarse**.

4. Corrige el problema, haz commit y push de nuevo, y asegúrate de que esta vez sí se despliega.

### Checkpoint 5 – Evidencia

- Crea `cp5-fallo-build-sin-deploy.txt` con:
  - Descripción del fallo provocado.
  - Confirmación de que el job `deploy` no se ejecutó mientras `build` fallaba.

---

## 🧩 Parte 6 – (Opcional) Deploy a otro proveedor (ejemplo Heroku/DigitalOcean/Kubernetes)

> Esta parte es opcional: solo si quieres practicar deploy a otro destino usando un secreto.

### Reto 6.1 – Esbozar un workflow de deploy alternativo

1. Crea un segundo archivo, por ejemplo `.github/workflows/deploy-heroku.yml` o similar, basándote en un ejemplo de CI/CD a otro proveedor (Heroku, DigitalOcean, Kubernetes…).

2. Usa un patrón similar:

   - Evento: `push` a `main`.
   - Job de tests.
   - Job de deploy que solo corre si tests pasan.

No hace falta que el deploy real funcione si no tienes cuenta; el objetivo es que practiques la configuración y el uso de `secrets`.

### Checkpoint 6 – Evidencia (opcional)

- Crea `cp6-deploy-alternativo.txt` con:
  - El YAML del workflow alternativo.
  - Explicación de qué proveedor usarías y qué secretos necesitarías.

---

## 🧩 Parte 7 – Reflexión final: de CI a CD

Crea `reflexion-6-23.md` y responde:

1. Explica con tus palabras la diferencia entre usar GitHub Actions solo para **tests en PR** (CI) y usarlos además para **desplegar** (CD).
2. ¿Qué riesgos hay en desplegar automáticamente a producción en cada push a `main`, y cómo los mitigarías (entornos previos, approvals, environments, etc.)?
3. ¿Qué beneficios aporta tener un deploy reproducible y automatizado frente a hacerlo manualmente?

---

## 📦 Entrega esperada en el repositorio

En `actividad-6-23-deploy-actions` deben aparecer:

- Proyecto de la app (código y `package.json` o equivalente).
- `.github/workflows/deploy.yml`
- (Opcional) `.github/workflows/deploy-heroku.yml` u otro destino.
- `cp1-contexto-deploy.txt`
- `cp2-gh-pages-config.txt`
- `cp3-deploy-yml.txt`
- `cp4-despliegue-ok.txt`
- `cp5-fallo-build-sin-deploy.txt`
- `cp6-deploy-alternativo.txt` (si haces la parte opcional)
- `reflexion-6-23.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Workflow de deploy correctamente configurado y funcionando para GitHub Pages (build + deploy condicionados).
- 3 pts – Evidencias claras de despliegue correcto y bloqueo de deploy cuando el build falla.
- 3 pts – Calidad de la reflexión en `reflexion-6-23.md` (comprensión de CI/CD y sus riesgos/beneficios).

**Puntuación máxima: 10 puntos.**
```
