Aquí tienes la **Actividad 6.14** sobre `git submodule`, centrada en añadir, inicializar/actualizar y trabajar con submódulos como repositorios dentro de otro repositorio. [atlassian](https://www.atlassian.com/git/tutorials/git-submodule)

***

```markdown
# 🧩 Actividad 6.14 – `git submodule`: repos dentro de repos

> Algunos proyectos necesitan reutilizar código de otros repositorios (librerías, plantillas, módulos comunes).
> En esta actividad aprenderás a usar **`git submodule` para incluir un repositorio dentro de otro**, gestionando versiones concretas del submódulo.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Explicar qué es un **submódulo** y cuándo usarlo.
- Añadir un submódulo con `git submodule add`.
- Inicializar y actualizar submódulos (`git submodule init`, `git submodule update`).
- Ver y entender `.gitmodules` y el commit anclado del submódulo.
- Actualizar un submódulo a otro commit y registrar ese cambio en el repositorio principal.

---

## 🧠 Conceptos clave: ¿qué es un submódulo?

- Un **submódulo** es un repositorio Git incluido como **subdirectorio** dentro de otro repositorio.
- El repositorio principal **no copia todo el historial** del submódulo, sino que apunta a **un commit concreto** del repo externo.
- Archivos importantes:
  - `.gitmodules`: configuración de submódulos (ruta, URL, nombre).
  - La entrada del submódulo en el índice del repositorio principal, que guarda el commit de referencia.

Casos de uso típicos: **librerías compartidas, componentes reutilizables, plantillas comunes** entre proyectos.

---

## 🧩 Parte 1 – Preparar dos repositorios: principal y “librería”

### Reto 1.1 – Crear repositorio de la librería (submódulo)

1. En un directorio de trabajo, crea la “librería”:

   ```bash
   mkdir lib-matematicas
   cd lib-matematicas
   git init
   ```

2. Crea `lib_math.js` con funciones simples:

   ```js
   // lib_math.js
   // Librería de matemáticas

   function cuadrado(x) {
     return x * x;
   }

   module.exports = { cuadrado };
   ```

3. Commit:

   ```bash
   git add lib_math.js
   git commit -m "Crea librería lib_math con cuadrado"
   ```

4. Añade una mejora:

   ```bash
   echo "// TODO: añadir función cubo" >> lib_math.js
   git add lib_math.js
   git commit -m "Añade TODO para cubo"
   ```

5. Vuelve al directorio padre:

   ```bash
   cd ..
   ```

### Reto 1.2 – Crear repositorio principal

1. Crea el repo principal:

   ```bash
   mkdir actividad-6-14-submodule
   cd actividad-6-14-submodule
   git init
   ```

2. Crea `app.js` que por ahora no use la librería:

   ```js
   // app.js
   // Aplicación principal

   console.log("App sin librería aún.");
   ```

3. Commit:

   ```bash
   git add app.js
   git commit -m "Crea app principal sin librería"
   ```

### Checkpoint 1 – Evidencia

- Crea `cp1-repos-iniciales.txt` en el repo **principal** con:
  - Descripción de las carpetas creadas (`lib-matematicas` y `actividad-6-14-submodule`).
  - Salida de `git log --oneline` de cada uno (puedes copiar y pegar desde la terminal).

---

## 🧩 Parte 2 – Añadir el submódulo al repositorio principal

### Reto 2.1 – `git submodule add`

1. Desde el repo principal (`actividad-6-14-submodule`), añade `lib-matematicas` como submódulo local:

   ```bash
   git submodule add ../lib-matematicas libs/lib-matematicas
   ```

   - El primer argumento es la URL/ruta del repo de la librería.
   - El segundo es la carpeta donde se incluirá en el proyecto.

2. Comprueba el estado:

   ```bash
   git status
   ```

   Deberías ver:
   - Un archivo nuevo `.gitmodules`.
   - El directorio `libs/lib-matematicas` listado como nuevo (submódulo).

3. Mira el contenido de `.gitmodules`:

   ```bash
   cat .gitmodules
   ```

   Verás algo similar a:

   ```ini
   [submodule "libs/lib-matematicas"]
     path = libs/lib-matematicas
     url = ../lib-matematicas
   ```

4. Haz commit en el repo principal:

   ```bash
   git add .gitmodules libs/lib-matematicas
   git commit -m "Añade submódulo lib-matematicas"
   ```

### Checkpoint 2 – Evidencia

- Crea `cp2-add-submodule.txt` con:
  - El comando `git submodule add` usado.
  - El contenido de `.gitmodules`.
  - Una breve explicación de qué representa la entrada del submódulo (ruta, URL).

---

## 🧩 Parte 3 – Clonar y usar `submodule init` / `update`

> Simularemos el caso de otra persona que clona el repositorio principal y debe inicializar el submódulo.

### Reto 3.1 – Clonar el repo principal en otra carpeta

1. Vuelve al directorio padre:

   ```bash
   cd ..
   ```

2. Clona el repo principal en una carpeta nueva:

   ```bash
   git clone actividad-6-14-submodule actividad-6-14-submodule-clone
   cd actividad-6-14-submodule-clone
   ```

3. Comprueba:

   ```bash
   ls
   ls libs
   ```

   Verás la carpeta del submódulo, pero puede estar vacía (o sin contenido del repo interno) hasta inicializarlo/actualizarlo.

### Reto 3.2 – Inicializar y actualizar submódulos

1. Ejecuta:

   ```bash
   git submodule init
   git submodule update
   ```

   - `init` lee `.gitmodules` y prepara la configuración local.
   - `update` clona el submódulo y lo posiciona en el commit adecuado.

   También puedes hacerlo en un solo paso con `git submodule update --init --recursive` (solo mención, no obligatorio).

2. Comprueba de nuevo:

   ```bash
   ls libs/lib-matematicas
   ```

   Ahora deberías ver `lib_math.js`.

### Checkpoint 3 – Evidencia

- Crea `cp3-init-update.txt` (en el repo clonado) con:
  - Los comandos `git submodule init` y `git submodule update`.
  - Una breve explicación de qué problema resuelven cuando alguien clona un proyecto con submódulos.

---

## 🧩 Parte 4 – Usar el submódulo desde la app principal

### Reto 4.1 – Importar la librería en `app.js`

1. En el repo clonado (`actividad-6-14-submodule-clone`), edita `app.js` para usar la librería:

   ```js
   // app.js
   // Aplicación principal usando la librería

   const { cuadrado } = require("./libs/lib-matematicas/lib_math");

   console.log("Resultado:", cuadrado(5));
   ```

2. Ejecuta (si tienes Node instalado):

   ```bash
   node app.js
   ```

   Deberías ver `Resultado: 25`.

3. Haz commit:

   ```bash
   git add app.js
   git commit -m "Usa lib-matematicas desde app"
   ```

### Checkpoint 4 – Evidencia

- Crea `cp4-uso-submodulo.txt` con:
  - El contenido actual de `app.js`.
  - Una frase explicando cómo se referencia el submódulo desde el código (ruta relativa).

---

## 🧩 Parte 5 – Actualizar el submódulo a una nueva versión

### Reto 5.1 – Añadir una nueva función en la librería y actualizar commit

1. En la carpeta original de la librería (`../lib-matematicas`, no en el clon), añade una función nueva:

   ```bash
   cd ../lib-matematicas
   ```

   Edita `lib_math.js`:

   ```js
   function cubo(x) {
     return x * x * x;
   }

   module.exports = { cuadrado, cubo };
   ```

2. Commit en la librería:

   ```bash
   git add lib_math.js
   git commit -m "Añade función cubo"
   ```

3. Vuelve al repo principal original (`actividad-6-14-submodule`) y entra al submódulo:

   ```bash
   cd ../actividad-6-14-submodule
   cd libs/lib-matematicas
   ```

4. Actualiza este submódulo a la última versión:

   ```bash
   git pull # o 'git fetch' + 'git checkout' del nuevo commit, según el caso
   ```

5. Vuelve a la raíz del repo principal:

   ```bash
   cd ../..
   ```

6. Comprueba el estado:

   ```bash
   git status
   ```

   Verás que `libs/lib-matematicas` aparece modificado porque ahora apunta a otro commit del submódulo.

7. Commit en el repo principal:

   ```bash
   git add libs/lib-matematicas
   git commit -m "Actualiza submódulo lib-matematicas a nueva versión"
   ```

### Checkpoint 5 – Evidencia

- Crea `cp5-update-submodule.txt` (en el repo principal original) con:
  - Los comandos usados para actualizar el submódulo.
  - Una explicación de qué significa “actualizar un submódulo a otro commit” en el contexto del repositorio principal.

---

## 🧩 Parte 6 – Reflexión final: cuándo usar submódulos (y cuándo no)

Crea `reflexion-6-14.md` en el repo principal y responde:

1. Explica con tus palabras qué es un submódulo y qué problema resuelve (librerías compartidas, repos reutilizables, etc.).
2. Indica **dos situaciones** donde usarías submódulos y **una situación** donde preferirías otra solución (por ejemplo, gestor de paquetes, monorepo, copia de código).
3. ¿Qué precauciones crees que hay que tener al trabajar con submódulos en equipo (clonado, init/update, versiones sincronizadas)?

---

## 📦 Entrega esperada

En el **repositorio principal** `actividad-6-14-submodule` (no en el clon) debe constar:

- `.gitmodules`
- Carpeta `libs/lib-matematicas` (como submódulo, no hace falta subir el repo externo si se evalúa localmente).
- `app.js` (versión final usando la librería).
- `cp1-repos-iniciales.txt`
- `cp2-add-submodule.txt`
- `cp3-init-update.txt` (puedes copiarlo desde el clon si lo hiciste allí)
- `cp4-uso-submodulo.txt`
- `cp5-update-submodule.txt`
- `reflexion-6-14.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Uso correcto de `git submodule add`, `.gitmodules`, `git submodule init`, `git submodule update`.
- 3 pts – Actualización de la versión del submódulo y registro de ese cambio en el repositorio principal.
- 3 pts – Calidad de la reflexión en `reflexion-6-14.md` (comprensión de cuándo submódulos son útiles y qué complicaciones tienen).

**Puntuación máxima: 10 puntos.**

---
```
