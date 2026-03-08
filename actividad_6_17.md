Aquí tienes la **Actividad 6.17** sobre Git LFS, centrada en aprender a versionar archivos grandes (imágenes, vídeos, datasets) sin romper el repositorio. [docs.github](https://docs.github.com/en/repositories/working-with-files/managing-large-files/configuring-git-large-file-storage)

***

```markdown
# 🧱 Actividad 6.17 – Git LFS: trabajar con archivos grandes

> Git no está optimizado para archivos binarios grandes (imágenes, vídeos, datasets, binarios…).
> En esta actividad aprenderás a usar **Git LFS (Large File Storage)** para versionar archivos grandes sin engordar tu repositorio ni alcanzar los límites de GitHub/GitLab.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Explicar qué es Git LFS y cuándo conviene usarlo.
- Instalar y habilitar Git LFS en un repositorio (`git lfs install`).
- Rastrear extensiones de archivos grandes con `git lfs track` y entender `.gitattributes`.
- Añadir, commitear y hacer push de archivos grandes controlados por LFS.

---

## 🧠 Conceptos clave: ¿qué es Git LFS?

- Git LFS es una **extensión de Git** que reemplaza archivos grandes por **pequeños punteros de texto** dentro del repositorio Git.
- El contenido real de los archivos grandes se guarda en un **almacenamiento separado** (LFS store, por ejemplo en GitHub/GitLab).
- Ventajas:
  - Repositorios más ligeros y clones/fetch más rápidos.
  - Solo se descargan las versiones necesarias de los archivos grandes al hacer checkout.
  - Gestión específica de límites de tamaño en plataformas remotas.

---

## 🧩 Parte 1 – Preparar el repositorio y un “archivo grande”

### Reto 1.1 – Crear el repo base

1. Crea el repo:

   ```bash
   mkdir actividad-6-17-git-lfs
   cd actividad-6-17-git-lfs
   git init
   ```

2. Crea un `README.md`:

   ```markdown
   # Proyecto con archivos grandes

   Este repositorio usará Git LFS para manejar archivos grandes.
   ```

3. Haz commit:

   ```bash
   git add README.md
   git commit -m "Commit inicial del proyecto con LFS"
   ```

### Reto 1.2 – Simular un archivo grande

1. Crea una carpeta `data` y un archivo que represente un archivo grande (puede ser una imagen, vídeo o un archivo binario simulado). Por simplicidad, crea un archivo grande de texto:

   ```bash
   mkdir data
   base64 /dev/urandom | head -c 5000000 > data/dataset.bin
   ```

   (En Windows puedes crear un archivo grande de otra forma, por ejemplo copiando un vídeo o usando un comando equivalente).

2. Comprueba el tamaño:

   ```bash
   ls -lh data
   ```

### Checkpoint 1 – Evidencia

- Crea `cp1-repo-inicial-lfs.txt` con:
  - Salida de `git status`.
  - Salida de `ls -lh data`.
  - Una frase explicando por qué **no** es buena idea versionar directamente muchos archivos grandes con Git normal.

---

## 🧩 Parte 2 – Instalar y habilitar Git LFS

### Reto 2.1 – Instalar LFS en el sistema (si no lo tienes)

1. Asegúrate de tener Git LFS instalado siguiendo la guía oficial de tu sistema (solo si no lo tienes ya).
   - En la práctica, puedes verificar con:

     ```bash
     git lfs version
     ```

2. Inicializa LFS en el repositorio actual:

   ```bash
   git lfs install
   ```

   Este comando configura Git para usar LFS (a nivel global o de usuario).

### Checkpoint 2 – Evidencia

- Crea `cp2-lfs-install.txt` con:
  - Salida de `git lfs version` (si está disponible).
  - El comando `git lfs install` y una breve explicación de su función.

---

## 🧩 Parte 3 – Rastrear archivos grandes con `git lfs track`

### Reto 3.1 – Configurar qué extensiones van a LFS

1. En el repo, indica que quieres que todos los archivos `.bin` se gestionen con LFS:

   ```bash
   git lfs track "*.bin"
   ```

   Esto añadirá una entrada en `.gitattributes`.

2. Comprueba el contenido de `.gitattributes`:

   ```bash
   cat .gitattributes
   ```

   Deberías ver algo similar a:

   ```text
   *.bin filter=lfs diff=lfs merge=lfs -text
   ```

3. Añade `.gitattributes` al índice:

   ```bash
   git add .gitattributes
   ```

> Es importante que `.gitattributes` esté versionado para que el resto del equipo también use LFS para esas extensiones.

### Checkpoint 3 – Evidencia

- Crea `cp3-gitattributes-lfs.txt` con:
  - El comando `git lfs track "*.bin"`.
  - El contenido de `.gitattributes`.
  - Una explicación de la línea `*.bin filter=lfs diff=lfs merge=lfs -text`.

---

## 🧩 Parte 4 – Añadir, hacer commit y push de un archivo LFS

### Reto 4.1 – Versionar el archivo grande usando LFS

1. Asegúrate de que `data/dataset.bin` existe.
2. Añádelo y haz commit:

   ```bash
   git add data/dataset.bin
   git commit -m "Añade dataset grande gestionado con LFS"
   ```

   En el commit, Git guardará un **puntero de texto** en lugar del archivo completo.

3. Abre el archivo en el repo (opcional) para ver que es un pequeño puntero y no el binario completo.

### Reto 4.2 – Subir a un remoto con soporte LFS

> Si tienes un remoto (GitHub/GitLab) para este ejercicio:

1. Crea un repositorio vacío en GitHub o GitLab con soporte LFS activado (GitHub y GitLab lo soportan de forma nativa).

2. Añade el remoto:

   ```bash
   git remote add origin <url-del-repo-remoto>
   ```

3. Haz push:

   ```bash
   git push -u origin main
   ```

   Git enviará el commit y los objetos LFS (punteros al repo Git y archivos grandes al LFS store).

### Checkpoint 4 – Evidencia

- Crea `cp4-commit-y-push-lfs.txt` con:
  - El comando de commit para `data/dataset.bin`.
  - Si has usado remoto, el comando `git push` y cualquier salida relevante de LFS (mensajes de subida de objetos LFS).

---

## 🧩 Parte 5 – Clonar el repo y comprobar el comportamiento de LFS

### Reto 5.1 – Clonar como otra persona

1. Vuelve al directorio padre:

   ```bash
   cd ..
   ```

2. Clona el repo remoto (o el local si no usas remoto):

   ```bash
   git clone actividad-6-17-git-lfs actividad-6-17-git-lfs-clone
   cd actividad-6-17-git-lfs-clone
   ```

3. Asegúrate de tener LFS instalado en este entorno también (`git lfs install` si hace falta).

4. Comprueba el tamaño aproximado del repo clonado:

   ```bash
   du -sh .
   ```

   En repos con muchos archivos grandes, el uso de LFS puede reducir significativamente el tamaño del clone inicial.

5. Comprueba que el archivo `data/dataset.bin` está disponible:

   ```bash
   ls -lh data
   ```

   Git LFS descarga el contenido real al hacer checkout de la rama.

### Checkpoint 5 – Evidencia

- Crea `cp5-clone-lfs.txt` (en el repo clonado) con:
  - Comandos de clonación y `git lfs install` (si lo has ejecutado).
  - Salida de `ls -lh data`.
  - Una breve explicación de qué ocurre al clonar y hacer checkout en un repo con Git LFS.

---

## 🧩 Parte 6 – Reflexión final: cuándo usar (y cuándo no) Git LFS

Crea `reflexion-6-17.md` en el repo principal y responde:

1. Explica con tus palabras qué problema resuelve Git LFS y cómo lo hace (punteros + almacenamiento separado).
2. Indica **tres tipos de archivos** para los que usarías Git LFS en proyectos reales (por ejemplo, modelos de IA, vídeos, imágenes de alta resolución, datasets…).
3. ¿Qué inconvenientes o limitaciones ves en Git LFS (cuotas de almacenamiento, necesidad de que todos los colaboradores lo tengan instalado, etc.)?

---

## 📦 Entrega esperada en el repositorio principal

En `actividad-6-17-git-lfs` deben aparecer:

- `README.md`
- `.gitattributes` (con el patrón de LFS)
- Carpeta `data/` con `dataset.bin` (gestionado por LFS)
- `cp1-repo-inicial-lfs.txt`
- `cp2-lfs-install.txt`
- `cp3-gitattributes-lfs.txt`
- `cp4-commit-y-push-lfs.txt`
- `cp5-clone-lfs.txt` (puedes copiarlo desde el clon)
- `reflexion-6-17.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Configuración correcta de Git LFS (`install`, `track`, `.gitattributes`, commit/push de archivo grande).
- 3 pts – Evidencias claras en los checkpoints (estado del repo, comportamiento al clonar).
- 3 pts – Calidad de la reflexión en `reflexion-6-17.md` (comprensión de cuándo usar LFS y sus limitaciones).

**Puntuación máxima: 10 puntos.**

---
```
