
# 🏢 Actividad 6.33 – Migración a GitHub Copilot Enterprise

> Imagina que tu centro educativo o empresa quiere pasar de no usar Copilot (o usar Copilot Individual/Business) a **GitHub Copilot Enterprise**, con políticas, formación y despliegue gradual.

---

## 🎯 Objetivos de la actividad

Al finalizar esta actividad serás capaz de:

- Identificar diferencias clave entre Copilot Business y Copilot Enterprise.
- Diseñar un plan de migración/rollout por fases para una organización.
- Proponer políticas, formación y métricas de éxito específicas para tu contexto.

---

## 🧩 Parte 1 – Entender qué aporta Copilot Enterprise

### Reto 1.1 – Comparar planes y funcionalidades

1. Investiga las principales características de **Copilot Business** y **Copilot Enterprise** (integración con código interno, chat contextualizado con tu organización, características avanzadas, etc.).

2. Crea `cp1-comparativa-planes.txt` con una tabla de dos columnas:

   - Columna 1: Copilot Business.
   - Columna 2: Copilot Enterprise.

   Incluye al menos:
   - Nivel al que se contrata (organización vs enterprise).
   - Precio aproximado por usuario y requisitos (Enterprise Cloud, etc.).
   - Funcionalidades específicas de Enterprise (contexto de tu org, integración profunda con repos internos, etc.).

---

## 🧩 Parte 2 – Escenario de partida de la organización

### Reto 2.1 – Definir el punto de partida

1. Define un escenario (elige uno):

   - A) Centro educativo/FP con varios profes de programación y alumnado usando repos en GitHub.
   - B) Empresa de desarrollo con 3–5 equipos de software que ya usan GitHub Enterprise Cloud.

2. En `cp2-escenario-inicial.txt` describe:

   - Número aproximado de personas que programan (profes + alumnado, o devs).
   - Situación actual respecto a Copilot (sin Copilot, uso individual, Copilot Business en algunos equipos).
   - Objetivos de la migración a Copilot Enterprise (ej.: mejorar productividad, acelerar onboarding, modernizar código, centralizar políticas).

---

## 🧩 Parte 3 – Plan de migración por fases

### Reto 3.1 – Diseñar un rollout gradual

1. Basándote en guías de rollout por fases, diseña un plan de 3 meses (o 3 trimestres) con hitos claros, por ejemplo:

   - Fase 1 – Piloto:
     - Activar Copilot Enterprise solo para un grupo pequeño (equipo piloto o 1-2 clases).
     - Recoger feedback, detectar bloqueos, ajustar políticas.

   - Fase 2 – Expansión controlada:
     - Ampliar a todo el departamento de desarrollo / ciclo formativo.
     - Añadir formación formal y “power users” que ayuden al resto.

   - Fase 3 – Adopción amplia:
     - Activar Copilot Enterprise para el resto de equipos relacionados (DevOps, data, etc.) o más grupos de alumnado.

2. Crea `plan-migracion-copilot-enterprise.md` con un cronograma que incluya:

   - Fases, duración e hitos.
   - Personas implicadas (rol de dirección, IT, profes/equipo técnico).
   - Riesgos que quieres vigilar en cada fase (técnicos y pedagógicos).

---

## 🧩 Parte 4 – Configuración, políticas y gobierno

### Reto 4.1 – Definir quién puede usar qué y cómo

1. Revisa qué puede configurar un **enterprise owner** respecto a políticas de Copilot (activar/desactivar funciones, limitar modelos, restringir repos sensibles, etc.).

2. Diseña una propuesta de políticas de Copilot Enterprise para tu escenario, en `cp4-politicas-y-gobierno.txt`, incluyendo:

   - Qué organizaciones/repositorios tienen Copilot activado.
   - Qué tipos de código se excluyen (repos super sensibles, exámenes, proyectos con IP especial).
   - Requisitos de revisión de código asistido por IA (por ejemplo, siempre revisión por otra persona antes de merge).
   - Integración con SSO/IdP si aplica (control de quién obtiene licencia).

---

## 🧩 Parte 5 – Formación y buenas prácticas para la adopción

### Reto 5.1 – Diseñar un plan de enablement

1. Inspirándote en las recomendaciones de formación y adopción (onboarding, training, champions):

   - Define qué sesiones o materiales se ofrecerán:
     - Taller inicial “Introducción a Copilot Enterprise”.
     - Guía rápida de comandos y ejemplos específicos de tu stack.
     - Sesiones avanzadas para “power users”.

   - Define cómo se compartirá conocimiento (notas internas, repos de ejemplos, canal de dudas, etc.).

2. Crea `cp5-formacion-y-adopcion.txt` con:

   - Lista de actividades de formación (títulos, formato y duración).
   - Papel de los “champions” o personas de referencia que ayudan al resto.

---

## 🧩 Parte 6 – Métricas de éxito y feedback

### Reto 6.1 – Medir si la migración ha merecido la pena

1. A partir de las recomendaciones de GitHub sobre medir el impacto de Copilot (productividad, satisfacción, calidad del código):

   - Define **3–5 métricas** que quieras seguir, por ejemplo:
     - Encuestas de satisfacción de desarrolladores/alumnado.
     - Tiempo medio para tareas típicas antes/después.
     - Número de PRs con tests añadidos gracias a Copilot.
     - Uso de Copilot (minutos o prompts por usuario) frente a adopción esperada.

2. Crea `cp6-metricas-y-feedback.txt` con:

   - Lista de métricas, cómo las medirías y cada cuánto (mensual, trimestral).
   - Cómo usarías ese feedback para ajustar políticas, formación o alcance del rollout.

---

## 🧩 Parte 7 – Reflexión final: impacto en centro educativo/equipo

Crea `reflexion-6-33.md` y responde:

1. En tu contexto (docente o profesional), ¿qué ventajas específicas esperas de migrar a Copilot Enterprise en comparación con seguir con licencias individuales o Business?
2. ¿Qué te preocupa más de una adopción masiva (dependencia, calidad, seguridad, equidad entre quien lo tiene y quien no) y cómo lo abordarías desde el diseño del rollout?
3. Si tuvieras que convencer a dirección (equipo directivo / CTO), ¿qué tres argumentos usarías basados en valor y no solo en “moda tecnológica”?

---

## 📦 Entrega esperada en el repositorio

En `actividad-6-33-migracion-copilot-enterprise` (o repo que uses) deben aparecer:

- `cp1-comparativa-planes.txt`
- `cp2-escenario-inicial.txt`
- `plan-migracion-copilot-enterprise.md`
- `cp4-politicas-y-gobierno.txt`
- `cp5-formacion-y-adopcion.txt`
- `cp6-metricas-y-feedback.txt`
- `reflexion-6-33.md`

---

## 🏁 Evaluación sugerida

- 4 pts – Plan de migración por fases sólido y adaptado a un escenario realista.
- 3 pts – Definición clara de políticas, gobierno y formación asociadas a Copilot Enterprise.
- 3 pts – Profundidad de la reflexión en `reflexion-6-33.md` (visión estratégica, no solo técnica).

**Puntuación máxima: 10 puntos.**

---