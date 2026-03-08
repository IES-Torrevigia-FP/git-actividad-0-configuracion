Aquí tienes la **Actividad 6.24** sobre *deploy a servidores con GitHub Actions*, centrada en desplegar a un servidor remoto (VPS) vía SSH/rsync desde un workflow. [blog.ando](https://blog.ando.ai/posts/github-actions-vps-deployment/)

***

```markdown
# 🌐 Actividad 6.24 – Deploy a servidores con GitHub Actions (VPS/SSH)

> Ya sabes desplegar a GitHub Pages con Actions.
> Ahora vas a aprender a **desplegar tu aplicación a un servidor remoto (por ejemplo, un VPS Linux) usando GitHub Actions y SSH/rsync**, como paso final de un pipeline CI/CD.

> ⚠️ Puedes hacerlo contra un servidor real o simularlo documentando los pasos y usando datos ficticios en los secretos.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Diseñar un workflow de GitHub Actions que, tras build/tests, despliegue código a un servidor remoto vía SSH/rsync.
- Configurar secretos en GitHub para credenciales de despliegue.
- Entender qué comandos ejecutar en el servidor para actualizar la app (git pull, docker-compose, reinicio de servicio, etc.).

---

## 🧩 Parte 1 – Contexto del proyecto y del servidor

### Reto 1.1 – Preparar repo y “servidor”

1. Elige un repo en GitHub (puede ser uno de los usados en actividades anteriores) que represente una app desplegable (Node, Python, PHP, estática…).

2. Simula o usa un servidor Linux (VPS) con:
   - Una ruta de despliegue, por ejemplo `/var/www/miapp`.
   - Acceso SSH con usuario dedicado a deploy.

3. En GitHub, en **Settings → Secrets and variables → Actions**, crea al menos estos **secrets** (usa valores reales o ficticios según tu caso):

   - `SSH_HOST` (IP o dominio del servidor).
   - `SSH_USER` (usuario de despliegue).
   - `SSH_PRIVATE_KEY` (clave privada deploy) **o** `SSH_PASSWORD` (menos recomendado).
   - `SSH_TARGET_DIR` (ruta del proyecto en el servidor, por ejemplo `/var/www/miapp`).

4. Crea `cp1-contexto-servidor.txt` en el repo con:
   - URL del repo.
   - Descripción del servidor objetivo (real o simulado).
   - Lista de secrets que has definido.

---

## 🧩 Parte 2 – Workflow de deploy vía SSH con `appleboy/ssh-action`

### Reto 2.1 – Crear un workflow que ejecute comandos remotos

Vas a usar una acción tipo `appleboy/ssh-action` para conectarte por SSH y ejecutar comandos de deploy.

1. Crea `.github/workflows/deploy-ssh.yml` con un contenido similar a:

   ```yaml
   name: Deploy to VPS via SSH

   on:
     push:
       branches: ["main"]

   jobs:
     deploy:
       name: Build & Deploy
       runs-on: ubuntu-latest

       steps:
         - name: Checkout code
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

         - name: Deploy over SSH
           uses: appleboy/ssh-action@master
           with:
             host: ${{ secrets.SSH_HOST }}
             username: ${{ secrets.SSH_USER }}
             key: ${{ secrets.SSH_PRIVATE_KEY }} # o 'password: ${{ secrets.SSH_PASSWORD }}'
             script: |
               cd ${{ secrets.SSH_TARGET_DIR }}
               git pull
               npm ci
               npm run build
               pm2 restart miapp || true
   ```

   - Evento: `push` a `main` → despliegue automático.
   - Tests y build en GitHub antes de tocar el servidor.
   - En el servidor se ejecutan comandos típicos: `git pull`, reinstalar deps, rebuild, reiniciar proceso.

2. Ajusta los comandos del bloque `script:` a tu stack real (por ejemplo, `systemctl restart`, `php artisan migrate`, `docker-compose up -d`, etc.).

3. Haz commit y push de `deploy-ssh.yml`:

   ```bash
   git add .github/workflows/deploy-ssh.yml
   git commit -m "ci: añade workflow de deploy al servidor por SSH"
   git push
   ```

### Checkpoint 2 – Evidencia

- Crea `cp2-deploy-ssh-yml.txt` con:
  - El contenido de `deploy-ssh.yml`.
  - Una explicación de los pasos del job `deploy` (en qué orden y qué hacen).

---

## 🧩 Parte 3 – Deploy con rsync/scp (opcional pero recomendado)

### Reto 3.1 – Sincronizar archivos al servidor con rsync

En lugar de `git pull` en el servidor, puedes subir directamente los archivos desplegables con rsync.

1. Crea un segundo workflow o amplía el anterior con un paso usando una acción tipo `rsync` (ejemplo adaptado):

   ```yaml
   - name: Deploy to server via rsync
     uses: trendyminds/github-actions-rsync@master
     with:
       RSYNC_OPTIONS: -avzr --delete --exclude=node_modules --exclude='.git*'
       RSYNC_TARGET: ${{ secrets.SSH_TARGET_DIR }}
       RSYNC_SOURCE: dist/ # carpeta de build
     env:
       SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
       SSH_USERNAME: ${{ secrets.SSH_USER }}
       SSH_HOSTNAME: ${{ secrets.SSH_HOST }}
   ```

2. Asegúrate de que la carpeta `dist/` (o equivalente) contiene lo que quieres desplegar.

3. Haz commit y push de los cambios en el workflow.

### Checkpoint 3 – Evidencia

- Crea `cp3-rsync-deploy.txt` con:
  - El fragmento YAML añadido para rsync.
  - Ventajas de rsync frente al `git pull` directo en el servidor (control de qué subes, excluir `.git`, etc.).

---

## 🧩 Parte 4 – Ejecutar el workflow y validar el despliegue

### Reto 4.1 – Despliegue real o simulado

1. Introduce un pequeño cambio visible en la app (por ejemplo, texto en la página principal o mensaje de consola).

2. Haz commit y push a `main` para disparar el workflow:

   ```bash
   git add .
   git commit -m "feat: actualiza banner de la página"
   git push
   ```

3. En GitHub, ve a **Actions** y observa:

   - El job de deploy ejecutándose.
   - Si falla, revisa logs (puertos cerrados, claves, comandos incorrectos…).

4. Una vez finalizado con éxito:

   - Conéctate al servidor (SSH) y comprueba que el código o la carpeta de build se han actualizado.
   - Abre la URL de tu app (si está expuesta) y verifica el cambio.

### Checkpoint 4 – Evidencia

- Crea `cp4-despliegue-servidor.txt` con:
  - Fecha/hora de una ejecución exitosa del workflow (ID o enlace al run opcional).
  - Confirmación de qué cambio verificaste en el servidor (ruta o URL).

---

## 🧩 Parte 5 – Deploy de entorno dockerizado (opcional)

### Reto 5.1 – Orquestar `docker-compose` desde Actions

Si tu app se despliega con Docker:

1. Ajusta el script SSH para hacer algo tipo:

   ```yaml
   script: |
     cd ${{ secrets.SSH_TARGET_DIR }}
     git pull
     docker compose pull
     docker compose up -d --remove-orphans
   ```



2. Documenta en tu repo cómo está configurado `docker-compose.yml` en el servidor (puede ser un resumen).

### Checkpoint 5 – Evidencia (opcional)

- Crea `cp5-docker-compose.txt` con:
  - Script de deploy adaptado a Docker.
  - Explicación del flujo: pull de imágenes, recreación de contenedores, Nginx u otro reverse proxy si aplica.

---

## 🧩 Parte 6 – Reflexión final: buenas prácticas de deploy a servidores

Crea `reflexion-6-24.md` y responde:

1. Compara brevemente dos enfoques de deploy desde Actions:
   - `git pull` en el servidor.
   - rsync/scp de artefactos generados.

2. ¿Qué medidas de seguridad consideras imprescindibles al desplegar por SSH (usuarios limitados, claves en Secrets, no exponer la clave privada, etc.)?

3. ¿Qué buenas prácticas aplicarías para no romper producción (entorno de staging, despliegues azules/verdes, backups, pruebas de humo, etc.)?

---

## 📦 Entrega esperada en el repositorio

En el repo (por ejemplo `actividad-6-24-deploy-servidor`) deben aparecer:

- Código de la app.
- `.github/workflows/deploy-ssh.yml` (y, si lo usas, workflow con rsync).
- `cp1-contexto-servidor.txt`
- `cp2-deploy-ssh-yml.txt`
- `cp3-rsync-deploy.txt`
- `cp4-despliegue-servidor.txt`
- `cp5-docker-compose.txt` (si haces la parte opcional)
- `reflexion-6-24.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Workflow funcional que despliega al servidor (SSH + comandos o rsync) tras build/tests.
- 3 pts – Evidencias claras del despliegue (logs, confirmación en servidor/URL).
- 3 pts – Calidad de la reflexión en `reflexion-6-24.md` (comprensión de estrategias y riesgos de deploy a servidores).

**Puntuación máxima: 10 puntos.**
```
