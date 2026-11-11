# Reserva de Horas Médicas — Proyecto DevOps

Servicio web estático de reserva de horas médicas para una empresa del rubro salud
(**Centro de Salud Vida Plena**, ficticio). El sitio se sirve con **Nginx** dentro de un
contenedor **Docker** y se levanta localmente con **Docker Compose** en el puerto **8080**.

> Proyecto académico. No contiene API, base de datos, credenciales reales ni datos personales.

## Estructura

```
reserva-horas-devops/
├── src/
│   ├── index.html          # Formulario de reserva, datos de atención y estado del servicio
│   └── styles.css          # Hoja de estilos
├── Dockerfile              # Imagen basada en nginx:alpine
├── docker-compose.yml      # Servicio "web" publicado en el puerto 8080
├── .env.example            # Variables de ejemplo (sin valores sensibles)
├── .gitignore              # Excluye .env, logs, claves y temporales
├── README.md
└── .github/workflows/
    └── devops-automation.yml   # (Complementario) validación automática con GitHub Actions
```

## Requisitos

- Git
- Docker Desktop iniciado (incluye Docker Compose)
- Navegador web

## Instalación

```bash
git clone https://github.com/jsalloc1-design/reserva-horas-devops.git
cd reserva-horas-devops
cp .env.example .env        # En Windows PowerShell: copy .env.example .env
```

## Ejecución

```bash
docker compose up -d --build
```

## Verificación

| Acción | Comando |
|---|---|
| Ver contenedores activos | `docker ps` / `docker compose ps` |
| Abrir el servicio | http://localhost:8080 |
| Probar por terminal | `curl -I http://localhost:8080` |
| Revisar logs | `docker logs reserva-horas-web` |
| Ver métricas | `docker stats --no-stream` |
| Detener el servicio | `docker compose stop` |
| Detener y eliminar | `docker compose down` |

## Flujo de trabajo con Git

- `main`: rama estable, solo recibe cambios mediante Pull Request.
- `feature/<nombre>`: ramas de trabajo por funcionalidad.
- Commits con prefijos convencionales: `feat:`, `fix:`, `docs:`, `chore:`, `ci:`.

## Seguridad

- El archivo `.env` está en `.gitignore` y nunca se sube al repositorio.
- `.env.example` solo contiene nombres de variables y valores de ejemplo.
- El formulario es una simulación: no envía ni almacena datos.
- Se usa una imagen oficial y liviana (`nginx:alpine`) para reducir la superficie de ataque.
- Antes de cada commit se revisa con `git status` / `git diff` que no existan datos sensibles.

## Automatización (complementaria)

El flujo `.github/workflows/devops-automation.yml` se ejecuta en cada push y Pull Request:
verifica la estructura del proyecto, comprueba que no exista `.env` versionado, construye la
imagen, levanta el contenedor, valida la respuesta HTTP en el puerto 8080 y lo detiene.
