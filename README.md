# Coop-Jump — Documentación de Orquestación

Repositorio central de infraestructura y documentación del proyecto **Coop-Jump**, un juego cooperativo por niveles. Este repositorio contiene la configuración de orquestación (Docker Compose), el esquema de base de datos, los datos iniciales y la documentación necesaria para levantar el ecosistema completo.

---

## Tabla de contenidos

- [Prerrequisitos](#prerrequisitos)
- [Inicio rápido](#inicio-rápido)
- [Estructura del repositorio](#estructura-del-repositorio)
- [Variables de entorno](#variables-de-entorno)
- [Servicios y arquitectura](#servicios-y-arquitectura)
- [Esquema de base de datos](#esquema-de-base-de-datos)
- [Comandos útiles](#comandos-útiles)
- [Troubleshooting](#troubleshooting)

---

## Prerrequisitos

Antes de comenzar, asegurate de tener instaladas las siguientes herramientas en tu sistema:

| Herramienta | Versión mínima | Propósito | Instalación |
|---|---|---|---|
| **Docker** | 24.0+ | Ejecutar contenedores de la base de datos | [docs.docker.com/get-docker](https://docs.docker.com/get-docker/) |
| **Docker Compose** | v2+ | Orquestar servicios multi-contenedor | Incluido con Docker Desktop. Para Linux: [docs.docker.com/compose/install](https://docs.docker.com/compose/install/) |
| **Git** | 2.30+ | Clonar el repositorio | [git-scm.com](https://git-scm.com/) |
| **Node.js** | 18+ LTS | Desarrollo del frontend del juego | [nodejs.org](https://nodejs.org/) |
| **Python** | 3.10+ | Desarrollo del backend / servicios de IA | [python.org](https://www.python.org/downloads/) |

### Verificar instalación

```bash
docker --version        # Docker version 24.x o superior
docker compose version  # Docker Compose version v2.x
git --version           # git version 2.30+
node --version          # v18.x o superior
python3 --version       # Python 3.10.x o superior
```

---

## Inicio rápido

### 1. Clonar el repositorio

```bash
git clone git@github.com:Coop-Jump/Docs.git
cd Docs
```

### 2. Configurar variables de entorno

```bash
cp .env.example .env
```

Editá el archivo `.env` con tus valores seguros:

```bash
# Abrilo con tu editor favorito
nano .env
```

> ⚠️ **Importante:** Nunca compartas el archivo `.env` ni lo subas a control de versiones. Contiene credenciales sensibles.

### 3. Levantar el ecosistema

```bash
docker compose up -d
```

Este comando:
- Descarga la imagen `postgres:16-alpine` (si no la tenés localmente).
- Crea el contenedor `game_db` con la base de datos configurada.
- Ejecuta automáticamente `init.sql` (esquema) y `seed.sql` (datos iniciales) en el primer arranque.
- Crea un volumen persistente `postgres_data` para no perder datos entre reinicios.

### 4. Verificar que funcione

```bash
# Ver el estado de los contenedores
docker compose ps

# Verificar que PostgreSQL acepta conexiones
docker exec game_db pg_isready -U game_user -d game_db
```

Si todo está correcto, verás:

```
game_db:5432 - accepting connections
```

### 5. Conectarse a la base de datos

```bash
# Usando el cliente psql desde el contenedor
docker exec -it game_db psql -U game_user -d game_db
```

---

## Estructura del repositorio

```
Docs/
├── .env                          # Variables de entorno (no commitear)
├── .env.example                  # Template de variables de entorno
├── .github/
│   └── CODEOWNERS                # Propietarios del código
├── docker-compose.yml            # Orquestación de servicios
├── init.sql                      # Esquema de base de datos (se ejecuta al iniciar)
├── seed.sql                      # Datos iniciales: 4 niveles predefinidos
├── docs/
│   └── levels/                   # Definiciones JSON de los niveles
│       ├── level_01_easy.json    # Nivel 1 — "Primeros Pasos"
│       ├── level_02_medium.json  # Nivel 2 — "El Ascenso"
│       ├── level_03_hard.json    # Nivel 3 — "Precisión Letal"
│       └── level_04_expert.json  # Nivel 4 — "El Desafío Supremo"
└── README.md                     # Este archivo
```

---

## Variables de entorno

Las variables de entorno se cargan desde el archivo `.env` en la raíz del proyecto. Si alguna variable no está definida, Docker Compose usa el valor por defecto indicado en `docker-compose.yml`.

### Configuración de PostgreSQL

| Variable | Descripción | Valor por defecto | Obligatoria |
|---|---|---|---|
| `POSTGRES_USER` | Usuario principal de PostgreSQL | `game_user` | Sí |
| `POSTGRES_PASSWORD` | Contraseña del usuario de PostgreSQL | `game_pass` | **Sí — cambiá el valor por defecto** |
| `POSTGRES_DB` | Nombre de la base de datos | `game_db` | Sí |

### Configuración de conexión (opcional)

| Variable | Descripción | Ejemplo |
|---|---|---|
| `DATABASE_URL` | URL completa de conexión para aplicaciones | `postgresql://game_user:password@localhost:5432/game_db` |

### Ejemplo de archivo `.env`

```env
POSTGRES_USER=game_user
POSTGRES_PASSWORD=tu_contraseña_segura_aquí
POSTGRES_DB=game_db

# Para uso de la aplicación (opcional)
DATABASE_URL=postgresql://game_user:tu_contraseña_segura_aquí@localhost:5432/game_db
```

> 💡 **Tip para evaluadores:** Para pruebas locales rápidas, podés dejar los valores por defecto del `.env.example`. Para un entorno de staging o producción, generá contraseñas seguras con `openssl rand -base64 32`.

---

## Servicios y arquitectura

### PostgreSQL 16 (Alpine)

| Propiedad | Valor |
|---|---|
| Imagen | `postgres:16-alpine` |
| Nombre del contenedor | `game_db` |
| Puerto expuesto | `5432:5432` |
| Volumen de datos | `postgres_data` (persistente) |
| Healthcheck | `pg_isready` cada 10s, timeout 5s, 5 reintentos |
| Política de reinicio | `unless-stopped` |

**Archivos de inicialización** (se ejecutan en orden alfabético al primer arranque):
1. `init.sql` → Crea el esquema (tablas, índices, comentarios)
2. `seed.sql` → Inserta los 4 niveles iniciales

---

## Esquema de base de datos

### Tablas principales

```
┌──────────┐       ┌──────────┐       ┌──────────┐
│  users   │──1:N──│   runs   │──N:1──│  levels  │
└──────────┘       └──────────┘       └──────────┘
```

#### `users`
| Columna | Tipo | Descripción |
|---|---|---|
| `id` | UUID (PK) | Identificador único del usuario |
| `username` | VARCHAR(50) | Nombre de usuario (único) |
| `password_hash` | VARCHAR(255) | Hash de la contraseña |
| `created_at` | TIMESTAMP | Fecha de creación |

#### `levels`
| Columna | Tipo | Descripción |
|---|---|---|
| `id` | UUID (PK) | Identificador único del nivel |
| `title` | VARCHAR(100) | Nombre del nivel |
| `grid_json` | JSONB | Layout del nivel (plataformas, hazards, collectibles) |
| `difficulty` | VARCHAR(20) | Dificultad: `easy`, `medium`, `hard`, `expert` |
| `created_by` | UUID (FK) | Referencia al usuario creador |
| `created_at` | TIMESTAMP | Fecha de creación |

#### `runs`
| Columna | Tipo | Descripción |
|---|---|---|
| `id` | UUID (PK) | Identificador único de la partida |
| `user_id` | UUID (FK) | Jugador que realizó la partida |
| `level_id` | UUID (FK) | Nivel jugado |
| `completion_time_ms` | BIGINT | Tiempo de completado en milisegundos |
| `deaths` | INTEGER | Cantidad de muertes durante la partida |
| `created_at` | TIMESTAMP | Fecha de la partida |

### Niveles iniciales

| # | Nombre | Dificultad | Tamaño del grid | Plataformas | Hazards | Coleccionables |
|---|---|---|---|---|---|---|
| 1 | Primeros Pasos | `easy` | 20×15 | 6 | 0 | 0 |
| 2 | El Ascenso | `medium` | 24×18 | 10 | 2 | 3 |
| 3 | Precisión Letal | `hard` | 28×20 | 14 | 8 | 7 |
| 4 | El Desafío Supremo | `expert` | 32×22 | 18 | 12 | 9 |

---

## Comandos útiles

### Gestión del contenedor

```bash
# Levantar servicios (en segundo plano)
docker compose up -d

# Detener servicios (preserva los datos)
docker compose down

# Detener y eliminar volvumen (BORRA TODOS LOS DATOS)
docker compose down -v

# Ver logs en tiempo real
docker compose logs -f postgres

# Ver logs de los últimos 50 registros
docker compose logs --tail 50 postgres
```

### Consultas de base de datos

```bash
# Conectarse a la consola psql
docker exec -it game_db psql -U game_user -d game_db

# Listar tablas
\dt

# Ver estructura de una tabla
\d users

# Ver todos los niveles
SELECT id, title, difficulty FROM levels ORDER BY created_at;

# Ver estadísticas de partidas
SELECT u.username, l.title, r.deaths, r.completion_time_ms
FROM runs r
JOIN users u ON r.user_id = u.id
JOIN levels l ON r.level_id = l.id;
```

---

## Troubleshooting

### El contenedor no arranca

```bash
# Ver logs de errores
docker compose logs postgres
```

Causa común: el puerto 5432 ya está en uso por otra instancia de PostgreSQL.

```bash
# Verificar si el puerto está ocupado
lsof -i :5432
# o
sudo ss -tlnp | grep 5432
```

**Solución:** Cambiá el puerto en `docker-compose.yml`:

```yaml
ports:
  - "5433:5432"  # Usar 5433 en vez de 5432 en el host
```

### El healthcheck falla (estado unhealthy)

```bash
# Ver el estado del healthcheck
docker inspect --format='{{json .State.Health}}' game_db
```

**Solución:** Esperá unos segundos, el contenedor se reinicia automáticamente con la política `unless-stopped`. Si persiste:

```bash
docker compose down -v
docker compose up -d
```

### Quiero resetear la base de datos desde cero

```bash
docker compose down -v
docker compose up -d
```

Esto elimina el volumen de datos y recrea todo desde `init.sql` + `seed.sql`.

### El archivo `.env` no está siendo leído

Verificá que `.env` esté en la raíz del proyecto (junto a `docker-compose.yml`) y que tenga el formato correcto (sin espacios alrededor del `=`).

---

## Contribuyentes

Este repositorio es mantenido por el equipo **@dqmdz-etec** (ver [CODEOWNERS](.github/CODEOWNERS)).

---

## Licencia

Consultar el archivo de licencia del repositorio para más información.
