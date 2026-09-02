# Informe Comparativo Técnico — Stacks de Backend y Frontend

Análisis comparativo de los frameworks evaluados para el proyecto **Coop-Jump**, considerando requisitos de un juego cooperativo en tiempo real: baja latencia en comunicación entre jugadores, manejo de estado del juego, integración con motores gráficos (Phaser 3) y escalabilidad.

---

## Tabla de contenidos

- [1. Backend — Express vs FastAPI vs Django](#1-backend)
  - [1.1 Curva de aprendizaje](#11-curva-de-aprendizaje)
  - [1.2 Rendimiento](#12-rendimiento)
  - [1.3 Manejo de ORM / SQL](#13-manejo-de-orm--sql)
  - [1.4 Estructura de proyectos](#14-estructura-de-proyectos)
  - [1.5 Resumen Backend](#15-resumen-backend)
- [2. Frontend — React vs Vue 3](#2-frontend)
  - [2.1 Reactividad](#21-reactividad)
  - [2.2 Manejo de estado global](#22-manejo-de-estado-global)
  - [2.3 Integración con Phaser 3](#23-integración-con-phaser-3)
  - [2.4 Resumen Frontend](#24-resumen-frontend)
- [3. Conclusión técnica](#3-conclusión-técnica)
  - [3.1 Combinaciones evaluadas](#31-combinaciones-evaluadas)
  - [3.2 Recomendación](#32-recomendación)

---

## 1. Backend

### Comparativa: Express (Node.js) vs FastAPI (Python) vs Django (Python)

#### 1.1 Curva de aprendizaje

| Aspecto | Express (Node.js) | FastAPI (Python) | Django (Python) |
|---|---|---|---|
| Curva inicial | Baja — minimalista, poco boilerplate | Baja-Media — sintaxis moderna, tipado con Pydantic | Media-Alta — "batteries included", muchos conceptos nuevos |
| Documentación oficial | Buena, ejemplos abundantes | Excelente, con ejemplos interactivos (Swagger automático) | Extensa pero densa para principiantes |
| Ecosistema de plugins | Enorme (npm) | Creciente, enfocado en async | Enorme (PyPI), muchos paquetes maduros |
| Tiempo para primer endpoint funcional | ~5 minutos | ~10 minutos | ~20 minutos |
| Complejidad percibida por un equipo nuevo | Muy baja | Baja | Media |

**Express** es ideal para equipos que quieren empezar rápido sin overhead. **FastAPI** es más declarativo y requiere comprender Python type hints y Pydantic, pero a cambio ofrece validación automática. **Django** tiene la curva más pronunciada por su cantidad de componentes integrados (ORM, admin, auth, migraciones), pero una vez aprendido, agiliza el desarrollo a largo plazo.

#### 1.2 Rendimiento

| Métrica | Express | FastAPI | Django |
|---|---|---|---|
| Requests/segundo (hello world) | ~15,000 | ~18,000 | ~3,000 |
| Latencia promedio (ms) | ~2ms | ~1.5ms | ~8ms |
| Manejo de concurrencia | Single-thread event loop (Node.js) | Async/await nativo (Starlette + Uvicorn) | Sync por defecto, async experimental (Django 4.1+) |
| Consumo de memoria (MB) | ~50 | ~40 | ~80 |
| WebSockets nativos | Sí (ws, Socket.IO) | Sí (Starlette WebSockets) | Sí (Django Channels, requiere Redis) |

> ⚡ **Para un juego cooperativo**, el soporte nativo de WebSockets es crítico. Express (con Socket.IO) y FastAPI (con Starlette) lo manejan de forma más directa que Django, que requiere Django Channels + un broker como Redis.

- **Express + Socket.IO**: Solución madura y probada para chat en tiempo real y sincronización de estado de juego. Socket.IO maneja reconexiones, salas y broadcasting automáticamente.
- **FastAPI**: WebSockets nativos de Starlette, más ligeros pero sin la abstracción de salas que ofrece Socket.IO. Se puede combinar con `websockets` library.
- **Django Channels**: Potente pero requiere configuración adicional (ASGI server, Redis como layer de canales). Más pesado para un caso de uso de juego real-time.

#### 1.3 Manejo de ORM / SQL

| Aspecto | Express (Node.js) | FastAPI (Python) | Django (Python) |
|---|---|---|---|
| ORM principal | Sequelize, Prisma, Knex.js | SQLAlchemy 2.0, Tortoise ORM | Django ORM (integrado) |
| Tipo de enfoque | Query builder / Schema-first | Core + ORM híbrido, async nativo | ORM completo, migration system integrado |
| Raw SQL | Fácil (pg, mysql2 drivers) | Fácil (asyncpg, databases) | Soportado pero se desaconseja |
| Migraciones | Sequelize CLI, Prisma Migrate | Alembic (manual, flexible) | `makemigrations` / `migrate` (automático) |
| Relaciones N:N | Configuración explícita | Declarativo con `relationship()` | `ManyToManyField` (muy simple) |
| JSONB / JSON columns | Soporte variable según ORM | Soporte nativo en SQLAlchemy | Soporte nativo en Django ORM |

**Express** no tiene un ORM propio — se elige entre varias opciones. **Prisma** es la más moderna (schema-first, type-safe), mientras **Knex.js** es un query builder más flexible. **SQLAlchemy 2.0** (FastAPI) es el estándar de Python, con soporte async y un modelo híbrido que permite usarlo como ORM completo o como query builder. **Django ORM** es el más integrado del mercado: las migraciones se generan automáticamente al detectar cambios en los modelos.

Para este proyecto, que ya usa PostgreSQL con `init.sql` y `seed.sql`, cualquiera de las tres opciones puede conectarse directamente. La ventaja de Django es que las migraciones se generan desde el código Python, eliminando la necesidad de mantener `init.sql` manualmente.

#### 1.4 Estructura de proyectos

**Express (típico):**
```
backend/
├── src/
│   ├── controllers/     # Lógica de rutas
│   ├── models/          # Modelos de datos
│   ├── routes/          # Definición de endpoints
│   ├── middleware/       # Auth, validación, CORS
│   ├── services/        # Lógica de negocio
│   ├── config/          # DB, env vars
│   └── app.js           # Entry point
├── package.json
└── .env
```
- **Ventaja**: Flexibilidad total para organizar como se quiera.
- **Desventaja**: No hay convención oficial, cada proyecto es diferente.

**FastAPI (típico):**
```
backend/
├── app/
│   ├── api/             # Routers organizados por dominio
│   │   ├── routes/
│   │   └── deps.py      # Dependency injection
│   ├── core/            # Config, seguridad
│   ├── models/          # SQLAlchemy models
│   ├── schemas/         # Pydantic schemas (validación)
│   ├── services/        # Lógica de negocio
│   └── main.py          # Entry point
├── alembic/             # Migraciones
├── pyproject.toml
└── .env
```
- **Ventaja**: Separación clara entre modelos, schemas y rutas. Dependency injection nativa.
- **Desventaja**: Más archivos para una API simple.

**Django (típico):**
```
backend/
├── config/              # Settings globales
├── apps/
│   ├── users/
│   │   ├── models.py
│   │   ├── views.py
│   │   ├── urls.py
│   │   ├── serializers.py
│   │   └── migrations/
│   └── game/
│       ├── models.py
│       ├── views.py
│       └── ...
├── manage.py
└── requirements.txt
```
- **Ventaja**: Convención establecida, admin panel automático, auth integrado.
- **Desventaja**: Más rígido, harder de adaptar a patrones no convencionales.

#### 1.5 Resumen Backend

| Criterio | Express | FastAPI | Django |
|---|---|---|---|
| Curva de aprendizaje | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| Rendimiento | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| WebSockets / Real-time | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| ORM / SQL | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Estructura de proyectos | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Ecosistema para juegos | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐ |
| **Ideal para** | APIs rápidas, prototipado | APIs modernas, async-heavy | Apps complejas, CRUD pesado |

---

## 2. Frontend

### Comparativa: React vs Vue 3

#### 2.1 Reactividad

| Aspecto | React 18+ | Vue 3 (Composition API) |
|---|---|---|
| Modelo de reactividad | Virtual DOM + reconciliación (Fiber) | Proxy-based reactividad fine-grained |
| Actualizaciones | Batch rendering, concurrent mode | Compiler-optimized, reactive proxies |
| Rendering condicional | JSX condicional (`{condition && <Comp/>}`) | `v-if` / `v-show` directivas |
| Listas | `map()` con `key` prop | `v-for` con `:key` |
| Side effects | `useEffect`, `useLayoutEffect` | `watch`, `watchEffect`, `onMounted` |
| Performance por defecto | Buena (requiere `React.memo`, `useMemo` para optimizar) | Excelente (el compilador optimiza automáticamente) |

**React** usa un modelo basado en JSX donde el developer describe la UI como función del estado. Las actualizaciones se propagan por el árbol de componentes, y la optimización depende del developer (`React.memo`, `useCallback`, `useMemo`).

**Vue 3** con Composition API usa proxies reactivos: cuando una variable reactiva cambia, solo los componentes que la usan se re-renderizan, sin necesidad de optimización manual. El compilador de Vue transforma el template en código optimizado en tiempo de compilación.

Para un juego donde el DOM del overlay (HUD, menús, leaderboard) se actualiza frecuentemente pero el canvas de Phaser no debería re-renderizarse innecesariamente, la reactividad fine-grained de Vue es una ventaja significativa.

#### 2.2 Manejo de estado global

| Aspecto | React (Context API / Zustand) | Vue 3 (Pinia) |
|---|---|---|
| API oficial | Context API (incorporado) | Pinia (state manager oficial de Vue) |
| Alternativa popular | Zustand, Jotai, Redux Toolkit | Vuex (legacy), Pinia |
| Sintaxis | Hooks (`useContext`, `createContext`) | `defineStore()` con Composition API |
| DevTools | React DevTools | Vue DevTools (excelente integración) |
| Persistencia | Middleware de Zustand (`persist`) | Plugin `pinia-plugin-persistedstate` |
| TypeScript | Excelente (nativo) | Excelente (nativo) |
| Boilerplate | Context: providers anidados. Zustand: mínimo | Pinia: mínimo, stores declarativos |

**React Context API** es suficiente para estado ligero, pero causa re-renders innecesarios cuando el contexto cambia. **Zustand** resuelve esto con un store minimalista (una función `create()`) que solo re-renderiza los componentes que consumen el estado específico que cambió. Es la opción más popular para juegos en React.

**Pinia** es el state manager oficial de Vue 3 (reemplaza Vuex). Su API es más limpia que Vuex: cada store se define con `defineStore()` y expone state, getters y actions directamente. La integración con Vue DevTools permite inspeccionar el estado del juego en tiempo real.

Para el estado del juego (posición de jugadores, nivel actual, scores), ambos ecosistemas tienen soluciones maduras:

```javascript
// Zustand (React) — store para el juego
const useGameStore = create((set) => ({
  players: {},
  currentLevel: null,
  scores: {},
  setPlayerPosition: (id, pos) =>
    set((state) => ({
      players: { ...state.players, [id]: pos }
    }))
}))
```

```javascript
// Pinia (Vue 3) — store para el juego
export const useGameStore = defineStore('game', () => {
  const players = ref({})
  const currentLevel = ref(null)
  const scores = ref({})

  function setPlayerPosition(id, pos) {
    players.value[id] = pos
  }

  return { players, currentLevel, scores, setPlayerPosition }
})
```

#### 2.3 Integración con Phaser 3

| Aspecto | React + Phaser 3 | Vue 3 + Phaser 3 |
|---|---|---|
| Comunidad de integración | Amplia (`react-phaser`, Phaser + React templates) | Creciente, menos templates disponibles |
| Inicialización del canvas | `useEffect` para montar/desmontar Phaser.Game | `onMounted` / `onUnmounted` lifecycle hooks |
| Comunicación React ↔ Phaser | Zustand stores compartidos, refs, custom events | Pinia stores, `provide/inject`, custom events |
| Mantenimiento de Phaser | Independiente del framework frontend | Independiente del framework frontend |
| Separación UI overlay / Canvas | Natural: React para HUD, Phaser para canvas | Natural: Vue para HUD, Phaser para canvas |
| State synchronization | Zustand store como "single source of truth" entre React y Phaser scenes | Pinia store como "single source of truth" entre Vue y Phaser scenes |

**Ambos frameworks se integran con Phaser 3 de forma similar.** Phaser maneja su propio canvas de forma independiente, y el framework frontend se encarga del overlay (menús, HUD, leaderboard). La comunicación se hace compartiendo un store global:

```javascript
// Patrón de integración (válido para React y Vue)
// 1. El framework frontend crea el store
// 2. Phaser escenas leen y escriben al store
// 3. El HUD se actualiza reactivamente cuando el store cambia

// React + Zustand
const gameStore = useGameStore()
// En Phaser scene: gameStore.getState().setPlayerPosition(...)
// En React HUD: const players = useGameStore(s => s.players)

// Vue + Pinia
const gameStore = useGameStore()
// En Phaser scene: gameStore.setPlayerPosition(...)
// En Vue HUD: const { players } = storeToRefs(gameStore)
```

La diferencia principal es que **React + Zustand** tiene más ejemplos y templates disponibles en la comunidad, mientras **Vue + Pinia** tiene una API más directa para la sincronización de estado.

#### 2.4 Resumen Frontend

| Criterio | React 18+ | Vue 3 |
|---|---|---|
| Curva de aprendizaje | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| Reactividad | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Estado global (store) | ⭐⭐⭐⭐⭐ (Zustand) | ⭐⭐⭐⭐⭐ (Pinia) |
| Integración Phaser 3 | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Ecosistema / comunidad | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Documentación oficial | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Ideal para** | Equipos grandes, ecosistema amplio | Prototipado rápido, apps de tamaño mediano |

---

## 3. Conclusión técnica

### 3.1 Combinaciones evaluadas

| # | Backend | Frontend | Pros | Contras |
|---|---|---|---|---|
| A | **Express + Socket.IO** | **React + Zustand** | Ecosistema más amplio, más templates de Phaser+React disponibles, Socket.IO probado para real-time | Más boilerplate en Express, React requiere optimización manual de renders |
| B | **Express + Socket.IO** | **Vue 3 + Pinia** | Curva de aprendizaje baja, Pinia es más limpio que Zustand para stores complejos, reactividad automática | Menos templates Phaser+Vue disponibles, comunidad más chica |
| C | **FastAPI + Starlette WS** | **React + Zustand** | Mejor rendimiento backend, async nativo, type safety completo | Menos ejemplos de integración WebSocket para juegos, más configuración inicial |
| D | **FastAPI + Starlette WS** | **Vue 3 + Pinia** | Rendimiento backend + reactividad frontend óptima, Django ORM no necesario | WebSocket management más manual que Socket.IO, menos comunidad para gaming |
| E | **Django + Channels** | **React/Vue** | ORM completo, admin panel, auth integrado | Más pesado para un juego real-time, Django Channels requiere Redis, overkill para el caso de uso |

### 3.2 Recomendación

**Para Coop-Jump, la combinación recomendada es: Express (Node.js) + Socket.IO + React (Zustand) o Vue 3 (Pinia).**

**Justificación:**

1. **Backend — Express con Socket.IO** es la opción más madura para sincronización de estado de juego en tiempo real. Socket.IO provee abstracciones que ahorrarán tiempo significativo: salas (rooms), reconexión automática, broadcasting, y fallback a polling si WebSockets no están disponibles. Para un juego cooperativo donde dos jugadores deben sincronizar posiciones y estado del nivel, esto es fundamental.

2. **Frontend — La elección entre React y Vue depende del equipo:**
   - Si el equipo tiene experiencia con React o prefiere un ecosistema más grande → **React + Zustand**
   - Si el equipo busca curva de aprendizaje más baja y reactividad más natural → **Vue 3 + Pinia**

   Ambas combinaciones funcionan bien con Phaser 3. La diferencia está en la experiencia del equipo, no en una ventaja técnica definitiva de una sobre otra.

3. **FastAPI** sería la segunda opción para backend si se prioriza rendimiento puro sobre ecosistema de herramientas para real-time. **Django** no se recomienda para este caso de uso por ser más pesado de lo necesario y requerir configuración adicional (Django Channels + Redis) para WebSockets.

---

*Documento generado como parte del análisis técnico del proyecto Coop-Jump.*
*Referencias: documentación oficial de [Express](https://expressjs.com/), [FastAPI](https://fastapi.tiangolo.com/), [Django](https://docs.djangoproject.com/), [React](https://react.dev/), [Vue 3](https://vuejs.org/), [Phaser 3](https://phaser.io/), [Socket.IO](https://socket.io/), [Zustand](https://github.com/pmndrs/zustand), [Pinia](https://pinia.vuejs.org/).*
