
# ☁️ Actividad 6.28 – GitHub Codespaces: entorno de desarrollo en la nube

> GitHub Codespaces te permite abrir un entorno de desarrollo completo (VS Code en un contenedor) directamente desde un repositorio, sin configurar nada en tu máquina.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Crear un codespace a partir de un repositorio.
- Explorar el entorno (VS Code en navegador, terminal, puertos).
- Configurar un `devcontainer` básico para personalizar el entorno (runtimes, extensiones).

---

## 🧩 Parte 1 – Crear un codespace desde un repositorio

### Reto 1.1 – Abrir tu primer codespace

1. Elige un repositorio sencillo en GitHub (puede ser uno propio, por ejemplo un proyecto Node/JS pequeño o un repo de ejercicios de este módulo).

2. En la barra verde de **Code**, haz clic en la pestaña **Codespaces** y luego en **Create codespace on main** (o rama que elijas).

3. Espera a que se cree el entorno. Se abrirá una instancia de VS Code en el navegador con tu repo ya clonado dentro del contenedor.

4. Crea `cp1-codespace-creado.txt` en el repositorio (fuera o dentro del Codespace, pero commiteado) con:
   - URL del repositorio de origen.
   - Nombre del codespace (aparece en la barra superior o en github.com/codespaces).

---

## 🧩 Parte 2 – Explorar el entorno de Codespaces

### Reto 2.1 – VS Code en el navegador y terminal

En el codespace recién creado:

1. Abre el panel de **Explorer** (ficheros) y verifica que ves el contenido del repo.

2. Abre una terminal integrada (`Terminal → New Terminal`) y ejecuta algunos comandos, por ejemplo:

   ```bash
   pwd
   ls
   git status
   ```

3. Si es un proyecto Node/Python, instala dependencias y ejecuta la app, por ejemplo:

   ```bash
   npm install
   npm run dev # o npm start / comando equivalente
   ```

4. Si la app abre un servidor web, GitHub Codespaces debería detectar el puerto y ofrecerte abrirlo en un navegador (Forwarded Ports).

### Checkpoint 2 – Evidencia

- Crea `cp2-exploracion-entorno.txt` con:
  - Comandos que has ejecutado en la terminal.
  - Indicación de si has llegado a ver una app web a través de un puerto reenviado (describe la URL/puerto).

---

## 🧩 Parte 3 – Añadir configuración de devcontainer básica

### Reto 3.1 – Crear un `devcontainer.json` sencillo

1. En el codespace (o localmente), crea la carpeta `.devcontainer/` en la raíz del repo.

2. Dentro, crea un archivo `devcontainer.json` con una configuración mínima, por ejemplo para Node:

   ```json
   {
     "name": "Node Dev Container",
     "image": "mcr.microsoft.com/devcontainers/javascript-node:20",
     "features": {
       "ghcr.io/devcontainers/features/git:1": {},
       "ghcr.io/devcontainers/features/github-cli:1": {}
     },
     "customizations": {
       "vscode": {
         "extensions": [
           "dbaeumer.vscode-eslint",
           "esbenp.prettier-vscode"
         ]
       }
     },
     "postCreateCommand": "npm install"
   }
   ```

   - `image`: imagen base con Node configurado.
   - `features`: herramientas adicionales (git, GitHub CLI, etc.).
   - `extensions`: extensiones recomendadas para VS Code en ese repo.
   - `postCreateCommand`: comando que se ejecuta tras crear el contenedor (instala dependencias).

3. Guarda los cambios.

### Reto 3.2 – Reconstruir el codespace con el nuevo devcontainer

1. En la paleta de comandos (`F1`), busca: **Codespaces: Rebuild Container** o similar.

2. Confirma la reconstrucción para que el codespace se reinicie usando la nueva configuración de `devcontainer.json`.

3. Una vez reconstruido:
   - Comprueba que las extensiones se han instalado.
   - Verifica que `npm install` se ha ejecutado automáticamente (node_modules presente).

### Checkpoint 3 – Evidencia

- Crea `cp3-devcontainer-config.txt` con:
  - El contenido actual de `.devcontainer/devcontainer.json`.
  - Comentario corto sobre qué ha cambiado en el entorno tras reconstruir (herramientas preinstaladas, extensiones, etc.).

---

## 🧩 Parte 4 – Guardar cambios y cerrar el codespace

### Reto 4.1 – Trabajar como si fuera tu IDE normal

1. Modifica un archivo del repo (por ejemplo, añade una línea al README o a un archivo de código).

2. Usa la terminal dentro del codespace para hacer commit y push:

   ```bash
   git status
   git add .
   git commit -m "chore: prueba de cambios desde codespace"
   git push
   ```

3. Cierra el codespace desde el menú de GitHub (Stop / Delete) para ahorrar minutos.

### Checkpoint 4 – Evidencia

- Crea `cp4-commits-desde-codespace.txt` con:
  - Mensaje del commit que hiciste desde el codespace.
  - Nota de que has cerrado/detenido el codespace para no seguir consumiendo recursos (esto es importante en Educación/Campus).

---

## 🧩 Parte 5 – (Opcional) Aspectos educativos y límites de uso

### Reto 5.1 – Analizar uso en contexto educativo

1. Si tienes GitHub Education/Teacher, revisa la documentación sobre límites de horas gratuitas para Codespaces.

2. Piensa cómo organizarías el uso de Codespaces con tu alumnado para no agotar el presupuesto:
   - Usar máquinas de 2 cores.
   - Cerrar codespaces cuando no se usen.
   - Reservar Codespaces para prácticas específicas y usar entorno local para otras.

3. Crea `cp5-estrategia-educativa.txt` con:
   - 3–4 ideas de cómo gestionarías Codespaces en clase.

---

## 🧩 Parte 6 – Reflexión final: ¿cuándo usar Codespaces?

Crea `reflexion-6-28.md` y responde:

1. ¿Qué ventajas le ves a Codespaces frente a configurar el entorno local (especialmente para alumnado o equipos con máquinas heterogéneas)?
2. ¿En qué tipos de proyectos o situaciones lo usarías (por ejemplo, talleres rápidos, asignaturas de programación, contribuciones a OSS, data science en máquinas poco potentes)?
3. ¿Qué limitaciones o precauciones ves (coste, necesidad de conexión, performance, gestión de minutos en cuentas Education)?

---

## 📦 Entrega esperada en el repositorio

En el repo que hayas usado (por ejemplo `actividad-6-28-github-codespaces`) deben aparecer:

- Carpeta `.devcontainer/` con `devcontainer.json`.
- `cp1-codespace-creado.txt`
- `cp2-exploracion-entorno.txt`
- `cp3-devcontainer-config.txt`
- `cp4-commits-desde-codespace.txt`
- `cp5-estrategia-educativa.txt` (si realizas la parte opcional)
- `reflexion-6-28.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Creación y uso correcto de un codespace + configuración básica de devcontainer.
- 3 pts – Evidencias claras de trabajo real dentro del codespace (comandos, commits, rebuild).
- 3 pts – Calidad de la reflexión en `reflexion-6-28.md` (visión práctica de cuándo Codespaces aporta valor).

**Puntuación máxima: 10 puntos.**

---