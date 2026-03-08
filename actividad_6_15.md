
# 🧬 Actividad 6.15 – `git subrepo`: otra forma de integrar repos externos

> En la Actividad 6.14 has trabajado con `git submodule`.
> Ahora vas a aprender a usar **`git subrepo` como alternativa para integrar repositorios externos** dentro de tu proyecto, manteniendo su historia pero evitando algunos inconvenientes de los submódulos.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Explicar qué es `git subrepo` y en qué se diferencia de un submódulo.
- Añadir un subrepo con `git subrepo clone` o `git subrepo add`.
- Sincronizar cambios con el repositorio remoto usando `git subrepo pull` y `git subrepo push`.
- Entender el papel del fichero `.gitrepo` y cómo se rastrea el estado del subrepo.

---

## 🧠 Conceptos clave: ¿qué es `git subrepo`?

- `git subrepo` es una herramienta (script externo) que añade un nuevo comando `git subrepo`.
- Permite **clonar otro repositorio dentro de un subdirectorio** de tu proyecto, manteniendo su **historial integrado** en el repo principal.
- A diferencia de submodules:
  - No depende de un puntero a un commit externo en el índice, sino que **trae el código y su historia** al repo principal.
  - Usa un archivo de metadatos **`.gitrepo`** dentro del subdirectorio para rastrear el último estado sincronizado (remote, branch, commit).
- Comandos básicos (según implementación estándar):
  - `git subrepo clone <url> <subdir>` / `git subrepo add ...`
  - `git subrepo pull <subdir>`
  - `git subrepo push <subdir>`
  - `git subrepo status <subdir>`

---

## 🧩 Parte 1 – Preparar repositorio principal y repositorio “librería”

### Reto 1.1 – Crear la librería externa

1. En tu directorio de trabajo, crea la librería:

   ```bash
   mkdir lib-utilidades
   cd lib-utilidades
   git init
   ```

2. Crea `util.js` con contenido sencillo:

   ```js
   // util.js
   // Librería de utilidades

   function saludar(nombre) {
     return `Hola, ${nombre}!`;
   }

   module.exports = { saludar };
   ```

3. Haz commit:

   ```bash
   git add util.js
   git commit -m "Crea librería util con función saludar"
   ```

4. Añade una mejora:

   ```bash
   echo "// TODO: añadir función despedir" >> util.js
   git add util.js
   git commit -m "Añade TODO para despedir"
   ```

5. Vuelve al directorio padre:

   ```bash
   cd ..
   ```

### Reto 1.2 – Crear el repositorio principal

1. Crea el repo principal:

   ```bash
   mkdir actividad-6-15-subrepo
   cd actividad-6-15-subrepo
   git init
   ```

2. Crea `app.js`:

   ```js
   // app.js
   // App principal sin utilidades aún

   console.log("App principal lista para usar una librería.");
   ```

3. Haz commit:

   ```bash
   git add app.js
   git commit -m "Crea app principal"
   ```

### Checkpoint 1 – Evidencia

- Crea `cp1-repos-iniciales-subrepo.txt` en el repo principal con:
  - Descripción de las carpetas `lib-utilidades` y `actividad-6-15-subrepo`.
  - Salida de `git log --oneline` de ambos repositorios.

---

## 🧩 Parte 2 – Añadir el subrepo al repositorio principal

### Reto 2.1 – `git subrepo clone` / `git subrepo add`

> Dependiendo de la implementación instalada, usarás `git subrepo clone` o `git subrepo add`. Consulta `git subrepo -h` si tienes dudas.

1. Desde el repo principal (`actividad-6-15-subrepo`), ejecuta (elige uno de los dos, según tu herramienta):

   ```bash
   git subrepo clone ../lib-utilidades libs/lib-utilidades
   ```

   o bien:

   ```bash
   git subrepo add ../lib-utilidades libs/lib-utilidades
   ```

   Esto:
   - Copia el contenido del repo `lib-utilidades` a `libs/lib-utilidades`.
   - Crea un archivo `.gitrepo` dentro de `libs/lib-utilidades` para rastrear el repositorio remoto, rama y commit.

2. Comprueba:

   ```bash
   ls libs/lib-utilidades
   cat libs/lib-utilidades/util.js
   ```

3. Observa el archivo `.gitrepo`:

   ```bash
   cat libs/lib-utilidades/.gitrepo
   ```

   Deberías ver información sobre el remote, branch y commit usado para sincronizar.

4. Haz commit en el repo principal:

   ```bash
   git add libs/lib-utilidades
   git commit -m "Añade lib-utilidades como subrepo"
   ```

### Checkpoint 2 – Evidencia

- Crea `cp2-add-subrepo.txt` con:
  - El comando `git subrepo clone` o `git subrepo add` que has usado.
  - El contenido de `libs/lib-utilidades/.gitrepo`.
  - Una breve explicación de qué representa este archivo en el contexto de `git subrepo`.

---

## 🧩 Parte 3 – Usar el subrepo desde la app principal

### Reto 3.1 – Importar y usar la librería

1. Edita `app.js` en el repositorio principal para usar la librería:

   ```js
   // app.js
   // App principal usando la librería utilidades

   const { saludar } = require("./libs/lib-utilidades/util");

   console.log(saludar("Mundo"));
   ```

2. Ejecuta (si tienes Node):

   ```bash
   node app.js
   ```

   Deberías ver `Hola, Mundo!`.

3. Haz commit:

   ```bash
   git add app.js
   git commit -m "Usa lib-utilidades como subrepo en app"
   ```

### Checkpoint 3 – Evidencia

- Crea `cp3-uso-subrepo.txt` con:
  - El contenido actual de `app.js`.
  - Una frase explicando cómo se integra el código del subrepo en la app (ruta, require/import).

---

## 🧩 Parte 4 – Actualizar el subrepo con cambios desde el remoto (`subrepo pull`)

### Reto 4.1 – Modificar la librería upstream y traer cambios

1. Ve al repo de la librería (`../lib-utilidades`) y añade la función `despedir`:

   ```bash
   cd ../lib-utilidades
   ```

   Edita `util.js`:

   ```js
   function despedir(nombre) {
     return `Adiós, ${nombre}!`;
   }

   module.exports = { saludar, despedir };
   ```

2. Haz commit:

   ```bash
   git add util.js
   git commit -m "Añade función despedir"
   ```

3. Vuelve al repo principal con subrepo:

   ```bash
   cd ../actividad-6-15-subrepo
   ```

4. Comprueba el estado del subrepo:

   ```bash
   git subrepo status libs/lib-utilidades
   ```

   Debería indicar que el subrepo tiene cambios disponibles en upstream (según la herramienta).

5. Trae los cambios con:

   ```bash
   git subrepo pull libs/lib-utilidades
   ```

   Esto suele hacer internamente:
   - `fetch` del repositorio upstream.
   - Rebase/merge de tus cambios locales sobre la nueva versión.
   - Actualización del archivo `.gitrepo`.

6. Revisa:

   ```bash
   cat libs/lib-utilidades/util.js
   cat libs/lib-utilidades/.gitrepo
   ```

7. Haz commit en el repo principal:

   ```bash
   git add libs/lib-utilidades
   git commit -m "Actualiza subrepo lib-utilidades con función despedir"
   ```

### Checkpoint 4 – Evidencia

- Crea `cp4-pull-subrepo.txt` con:
  - El comando `git subrepo pull` utilizado.
  - Una descripción de qué ha cambiado en el subdirectorio (nueva función, nuevo commit de referencia en `.gitrepo`).

---

## 🧩 Parte 5 – Enviar cambios desde el subrepo al remoto (`subrepo push`)

### Reto 5.1 – Hacer cambios locales en el subrepo y subirlos

1. En el repo principal, edita `libs/lib-utilidades/util.js` para mejorar `saludar`:

   ```bash
   cd ./libs/lib-utilidades

   // Modifica la función saludar, por ejemplo:
   function saludar(nombre) {
     return `Hola, ${nombre}! Bienvenido/a.`;
   }
   ```

2. Haz commit **en el repo principal** (no en `lib-utilidades`):

   ```bash
   cd ../..
   git add libs/lib-utilidades
   git commit -m "Mejora mensaje de saludar en subrepo"
   ```

   Estos cambios están registrados dentro del historial del repo principal, pero aún no en el remoto original de `lib-utilidades`.

3. Usa `git subrepo push` para enviar esos cambios al repo remoto de la librería:

   ```bash
   git subrepo push libs/lib-utilidades
   ```

   Esto suele:
   - Crear una rama temporal en el subrepo.
   - Reproducir tus commits en el remoto.
   - Actualizar `.gitrepo` para reflejar el nuevo estado sincronizado.

4. Si tienes permisos sobre el repo remoto, tus cambios quedarán integrados; si no, al menos verás el flujo del comando (puede fallar por permisos, pero el ejercicio ilustra el proceso).

### Checkpoint 5 – Evidencia

- Crea `cp5-push-subrepo.txt` con:
  - El comando `git subrepo push` usado.
  - Una explicación de qué intenta hacer este comando (subir cambios del subdirectorio al repo remoto originario).

---

## 🧩 Parte 6 – Reflexión final: subrepo vs submodule/subtree

Crea `reflexion-6-15.md` y responde:

1. Explica con tus palabras la diferencia de enfoque entre:
   - `git submodule`
   - `git subrepo`
   (por ejemplo, puntero a commit externo vs historia embebida y `.gitrepo`).
2. Indica **dos ventajas** de usar `git subrepo` frente a submódulos en ciertos proyectos (por ejemplo, menos fricción para el equipo, independencia del remoto, mejor integración del historial).
3. ¿En qué tipo de proyectos te plantearías usar `git subrepo` y qué cuidado tendrías al introducir esta herramienta (instalación, documentación de uso para el equipo, etc.)?

---

## 📦 Entrega esperada en el repositorio principal

En `actividad-6-15-subrepo` debe constar:

- `app.js` (versión final usando la librería).
- Carpeta `libs/lib-utilidades` con su `.gitrepo`.
- `cp1-repos-iniciales-subrepo.txt`
- `cp2-add-subrepo.txt`
- `cp3-uso-subrepo.txt`
- `cp4-pull-subrepo.txt`
- `cp5-push-subrepo.txt`
- `reflexion-6-15.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Uso correcto de `git subrepo clone`/`add`, `git subrepo pull`, `git subrepo push`, comprensión de `.gitrepo`.
- 3 pts – Evidencias claras en checkpoints (estado del subdirectorio, cambios traídos/llevados).
- 3 pts – Calidad de la reflexión en `reflexion-6-15.md` (comprensión comparativa con submodule/subtree y criterio de uso).

**Puntuación máxima: 10 puntos.**

---