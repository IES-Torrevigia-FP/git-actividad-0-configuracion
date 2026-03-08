
# 📊 Actividad 6.27 – GitHub Insights: salud y actividad del repositorio

> GitHub ofrece gráficos de actividad (Insights) que ayudan a entender cómo se usa y mantiene un repositorio: contribuciones, tráfico, ritmo de cambios, etc.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Navegar por las secciones de **Insights** de un repo (Pulse, Contributors, Traffic, etc.).
- Interpretar métricas básicas de salud: actividad de commits, número de contribuidores, tráfico, issues/PRs.
- Redactar conclusiones sobre el estado de un proyecto basándote en estos datos.

---

## 🧩 Parte 1 – Elegir un repositorio para analizar

### Reto 1.1 – Seleccionar el repo

1. Elige un repositorio en GitHub para analizar con Insights. Puede ser:
   - Un repo tuyo (curso, ejemplo, proyecto personal).
   - Un repo open source conocido (por ejemplo, una librería de JS, etc.).

2. Asegúrate de que tiene algo de actividad (commits, issues, PRs).

3. Crea `cp1-repo-elegido.txt` con:
   - URL del repositorio.
   - Breve descripción del proyecto (qué hace, lenguaje principal).

---

## 🧩 Parte 2 – Contributors: quién contribuye y cuánto

### Reto 2.1 – Ver el gráfico de contribuidores

1. En GitHub, entra al repo → pestaña **Insights → Contributors**.

2. Observa:
   - Número de contribuidores totales (top 100).
   - Cómo se reparte el número de commits entre ellos.
   - Evolución de las contribuciones en el tiempo (curvas por persona).

3. Cambia el periodo (All / Last year / Last 3 months, etc.) si la interfaz lo permite.

4. Crea `cp2-contributors.txt` con:
   - Número aproximado de contribuidores activos.
   - ¿Es un “one-person show” o hay varios contribuidores relevantes?
   - Comentario breve sobre cómo ha cambiado la actividad de commits a lo largo del tiempo (picos, pausas).

---

## 🧩 Parte 3 – Pulse: resumen de actividad reciente

### Reto 3.1 – Revisar Pulse (resumen de última semana/mes)

1. En el mismo repo, ve a **Insights → Pulse**.

2. Observa los datos para el periodo por defecto (últimos 7 días) y, si quieres, para un periodo más largo:

   - Número de PRs abiertas/merged.
   - Número de issues abiertas/cerradas.
   - Gráfico de actividad de commits para el top de contribuidores.

3. Crea `cp3-pulse.txt` con:
   - Número de PRs abiertas y merged en el periodo.
   - Número de issues abiertas y cerradas en el periodo.
   - Tu valoración: ¿parece un proyecto activo en la última semana/mes? ¿Se atienden issues y PRs?

---

## 🧩 Parte 4 – Traffic: visitas, clones y contenido popular

### Reto 4.1 – Ver tráfico (si tienes permisos)

> Solo verás **Traffic** si tienes permisos de push en el repo; si analizas un repo ajeno, puedes saltarte esta parte o usar uno propio.

1. Ve a **Insights → Traffic**.

2. Observa:
   - `Clones`: número total y únicos en los últimos 14 días.
   - `Views`: visitas al repo, total y únicas.
   - `Referring sites`: desde qué sitios llega la gente.
   - `Popular content`: qué archivos o rutas reciben más visitas.

3. Crea `cp4-traffic.txt` con:
   - Resumen de clones y views en los últimos 14 días.
   - Principales referring sites (si aparecen).
   - Tu hipótesis sobre qué contenido del repo parece despertar más interés y por qué (por ejemplo, README, docs, carpeta de ejemplos).

---

## 🧩 Parte 5 – Síntesis: “salud” del repositorio

### Reto 5.1 – Redactar un pequeño informe de salud

Usando lo observado en Contributors, Pulse y Traffic (y, si quieres, otros gráficos como Commits, Code frequency, Network):

1. Crea `informe-salud-repo.md` con secciones como:

   - **Actividad de commits**: frecuencia, evolución reciente.
   - **Participación de la comunidad**: cuántas personas contribuyen, concentración en pocas personas o equipo más repartido.
   - **Atención a issues y PRs**: se cierran issues, se fusionan PRs, tiempos razonables o largos.
   - **Interés externo (tráfico)**: cuánta gente visita/clona, qué partes del repo son más consultadas.

2. Termina con una conclusión tipo:

   - “El proyecto está muy activo y bien mantenido…”
   - “Parece semi-abandonado desde hace X meses…”
   - “Tiene buena comunidad de usuarios pero pocas personas manteniendo…”

---

## 🧩 Parte 6 – Reflexión final: usar Insights en tus propios proyectos

Crea `reflexion-6-27.md` y responde:

1. ¿Qué métricas de Insights te parecen más útiles para ti como mantenedor/a (contributors, Pulse, Traffic, Commits…)? ¿Por qué?
2. Imagina que ves que tu repo tiene mucho tráfico pero poca actividad reciente: ¿qué acciones podrías tomar (mejorar docs, aceptar PRs, buscar co-mantenedores, etc.)?
3. ¿Cómo explicarías a tu alumnado qué señales buscar en Insights para evaluar si una librería de terceros es “sana” para usarla en clase/proyecto?

---

## 📦 Entrega esperada en el repositorio

En `actividad-6-27-github-insights` (o repositorio donde documentes el análisis) deben aparecer:

- `cp1-repo-elegido.txt`
- `cp2-contributors.txt`
- `cp3-pulse.txt`
- `cp4-traffic.txt` (si tienes acceso a Traffic; si no, menciónalo dentro del archivo)
- `informe-salud-repo.md`
- `reflexion-6-27.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Uso correcto de secciones de Insights (Contributors, Pulse, Traffic) para extraer datos.
- 3 pts – Informe de salud bien estructurado y apoyado en datos.
- 3 pts – Calidad de la reflexión en `reflexion-6-27.md` (visión crítica sobre métricas y toma de decisiones).

**Puntuación máxima: 10 puntos.**

---