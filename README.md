# Implementación de modo offline en la app de pagos

La aplicación de pagos debe soportar operaciones sin conexión, permitiendo al usuario realizar transacciones que se sincronizarán cuando se restablezca la conexión. Los actores involucrados son el usuario de la aplicación, el servicio de pagos y el almacén local de datos. Las transacciones deben ser idempotentes, asegurando que una transacción repetida no resulte en duplicados. El umbral de latencia aceptable para la sincronización es de 5 segundos. La razón de negocio es asegurar que los usuarios puedan realizar pagos incluso en áreas con mala cobertura de red.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | persistencia local y modo offline |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 10 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Diseño del almacén local de datos

**Objetivo:** Definir la estructura del almacén local que permitirá almacenar transacciones sin conexión.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Identificar los tipos de transacciones que deben ser almacenadas localmente.
- Diseñar la estructura de datos para asegurar la idempotencia de las transacciones.
- Establecer criterios de aceptación para la fase: el almacén debe soportar lectura y escritura de transacciones, y manejar colisiones de claves de manera idempotente.

**Entregable:** Especificación del diseño del almacén local de datos.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el uso de claves únicas para cada transacción.
- Piensa en cómo manejarías la consistencia de los datos en caso de fallos de escritura.

</details>

### Fase 2: Implementación de la persistencia local

**Objetivo:** Implementar la funcionalidad para almacenar transacciones localmente cuando no hay conexión.

**Tiempo estimado:** 4 horas

**Instrucciones:**

- Implementar la lógica para almacenar transacciones en el almacén local.
- Asegurar que las transacciones sean idempotentes.
- Establecer criterios de aceptación para la fase: la aplicación debe poder almacenar transacciones localmente sin conexión y recuperarlas cuando se restablezca la conexión.

**Entregable:** Código funcional para la persistencia local de transacciones.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza una estrategia de escritura atómica para asegurar la idempotencia.
- Considera el uso de timestamps para manejar versiones de transacciones.

</details>

### Fase 3: Sincronización de transacciones

**Objetivo:** Implementar la funcionalidad para sincronizar transacciones almacenadas localmente con el servicio de pagos una vez que se restablezca la conexión.

**Tiempo estimado:** 4 horas

**Instrucciones:**

- Implementar la lógica para sincronizar transacciones almacenadas localmente con el servicio de pagos.
- Asegurar que las transacciones se envíen en el orden correcto y se manejen los posibles conflictos.
- Establecer criterios de aceptación para la fase: la aplicación debe poder sincronizar transacciones localmente almacenadas con el servicio de pagos cuando se restablezca la conexión, dentro de un umbral de latencia de 5 segundos.

**Entregable:** Código funcional para la sincronización de transacciones.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el uso de colas para asegurar el orden de las transacciones.
- Piensa en cómo manejarías conflictos de sincronización usando versiones de transacciones.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es la persistencia local y por qué es importante en una aplicación de pagos?
- **paraQueSirve**: ¿Para qué sirve el modo offline en la aplicación de pagos?
- **comoSeUsa**: ¿Cómo se usa la idempotencia para evitar duplicados en las transacciones?
- **erroresComunes**: ¿Cuáles son los errores comunes al implementar la persistencia local y la sincronización de transacciones?
- **queDecisionesImplica**: ¿Qué decisiones implica el diseño del almacén local de datos y la estrategia de sincronización?

## Criterios de Evaluacion

- Diseño del almacén local de datos que soporta transacciones idempotentes.
- Implementación de la persistencia local de transacciones.
- Implementación de la sincronización de transacciones con el servicio de pagos.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
flutter pub get && flutter analyze
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
