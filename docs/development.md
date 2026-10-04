# Development

Architecture, conventions and local setup for tilloh.dev.

## Architecture

```
/
├── frontend/   # SvelteKit 2 SPA (Svelte 5, Carbon Components, Socket.io client, sveltekit-i18n)
├── backend/    # NestJS 11 API (Fastify, Mongoose, Socket.io, Swagger, Pino, Prometheus)
│   ├── apps/tilloh-dev/   # main application entry
│   └── libs/              # feature modules (NX libraries)
├── e2e/        # Playwright E2E tests (local only, Chromium)
├── docs/       # feature and infrastructure docs
└── git-hooks/  # pre-/post-commit hooks, installed by `pnpm install`
```

**Backend libs** (`backend/libs/`, aliases `@backend/…`):

- Features: `admin`, `memorandum`, `chat`, `todo`, `jokes`, `ocr`, `catch-em-all`
- `shared/common/types`, `shared/common/texts` — shared types and strings
- `shared/provider/identifiers`, `shared/provider/keystore-persistence`, `shared/provider/ocr` — shared services
- `shared/controller/health`, `shared/controller/metrics` — common controllers
- `shared/util/` — guards, filters, middleware

**Frontend** (`frontend/src/`):

| Folder | Content |
|---|---|
| `routes/` | SvelteKit pages and routing |
| `lib/api/` | backend API calls |
| `lib/components/` | reusable Svelte components |
| `lib/config/` | i18n translations (de, en) |
| `lib/types/` | TypeScript definitions |
| `lib/util/` | helper functions |

## Coding Conventions

- **Frontend placement:** API calls only in `lib/api/`, types only in `lib/types/`.
- **Functions:** always lambda consts (`const myFunction = () => { … }`).
- **Naming:** service functions get descriptive names (`listIdentifiers`,
  `removeMessage`); MongoDB layer functions get CRUD names (`findAll`,
  `findById`, `update`, `remove`).
- **Formatting:** Prettier with `singleQuote: true`.

**Svelte 5 script order:**

1. imports
2. props (`$props()`)
3. constants
4. state (`$state`)
5. derived (`$derived`)
6. effects (`$effect`)
7. lifecycle (`onMount`)
8. functions

Components not yet migrated: `export let` props, constants, `let`, `$:`,
`onMount`, functions.

## Git Hooks

`pnpm install` copies `git-hooks/` into `.git/hooks/`.

- **pre-commit:** lint and tests for frontend and backend; a failure rejects the commit.
- **post-commit:** prefixes a gitmoji from keywords: fix 🐛, add ✨, remove 🔥,
  refactor ♻️, docs/readme 📝, config 🔧, security 🔒, workflow/deployment 💚,
  dependencies 📌, otherwise 🚀.

## CHANGELOG

Every PR adds entries under `## [Unreleased]` in `CHANGELOG.md`:

```markdown
### Added | Changed | Fixed
- [module] Description.
```

Modules, for example: `[memorandum]`, `[global]`, `[admin]`, `[backend]`, `[frontend]`.

## Environment

`backend/.env` (never committed):

```env
SERVER_ADDRESS="localhost"         # "0.0.0.0" for Docker
GLOBAL_PREFIX="v1"
PORT="61154"
MONGO_DB_URL="mongodb://localhost/tilloh-dev"
ADMIN_IDENTIFIER="<secret>"
OCR_SPACE_URL="https://api.ocr.space/parse/image"
OCR_SPACE_API_KEY="<api-key>"
```

First-time MongoDB: `pnpm --filter ./backend build:db`, afterwards `start:db` / `stop:db`.

## API

- Base URL `http://localhost:61154/v1`, Swagger at the base URL
- Chat uses Socket.io for real-time messages
- Throttling: 500 requests per 5 minutes

## E2E Tests

Run locally only. Playwright starts the backend (port 61155) and frontend
(port 5173) itself.

**Prerequisites:**

- local MongoDB running (`pnpm --filter ./backend start:db`)
- `e2e/.env.test` exists: `pnpm e2e:setup`, then fill in the values
- Chromium installed once: `pnpm e2e:install`

| Command | Purpose |
|---|---|
| `pnpm e2e` | headless |
| `pnpm e2e:headed` | visible browser |
| `pnpm e2e:ui` | Playwright UI |

**`e2e/.env.test`:**

- `E2E_ADMIN_IDENTIFIER` — must match `ADMIN_IDENTIFIER` in `backend/.env`
- `E2E_MONGO_DB_URL` — separate database `tilloh-dev-e2e`
- `E2E_BACKEND_URL` — port 61155, no conflict with the dev backend on 61154

**Auth:** tests inject the identifier via `localStorage.setItem('identifier', id)`
in `addInitScript()`, bypassing the GlobalLogin gate.

**Setup/teardown:** global setup creates a test identifier and a seed joke in
the E2E database; teardown removes them.
