# tilloh.dev

This is the source code for my personal website, [tilloh.dev](https://tilloh.dev).

This monorepo is divided into two main parts: frontend and backend and is powered by nx.

## Frontend

The frontend is a single-page application that serves as a portfolio for my projects and useful features for Friends and Family. Furthermore it is a place for me to experiment with new technologies and ideas. At the moment it consists of the memorandum, a joke library, a chat, a todo list a brick breaker game, a food scanner and a showcase how to sort uno cards.

It is built with SvelteKit and Carbon Design System.

### Run with docker

To run the frontend using Docker, you can use the provided Dockerfile. First, ensure Docker is installed on your system. Then, navigate to the root directory of the project and execute the following commands:

1. Build the frontend project

`pnpm --filter ./frontend build`

2. Build the image

`docker build -t tilloh-dev-frontend -f Frontend.Dockerfile .`

2. Run the container (in single-mode else see below)

`docker run -d -p 5173:5173 tilloh-dev-frontend`

## Backend

The backend is a REST API that powers the frontend. It consists of generated identifiers for user sessions, an ocr feature, a joke scraper and a key-value store to store link information.

The backend is built with NestJS and Swagger.

### Run with docker

To run the backend using Docker, you can use the provided Dockerfile. Just like with the frontend, ensure Docker is installed on your system. Then, navigate to the root directory of the project and execute the following commands:

1. Build the backend project

`pnpm --filter ./backend build`

2. Build the image

`docker build -t tilloh-dev-backend -f Backend.Dockerfile .`

2. Run the container (in single mode else see below)

`docker run -d -p 61154:61154 tilloh-dev-backend`

## Start all together

This project supports docker composeby using the provided `docker-compose.yaml` file. This file defines the services, networks, and volumes required to run the application. Before running see the instructions in the [backend/README.md](./backend/README.md#environment-variables) file in order to set up the necessary environment variables and ensure that MongoDB is running. Once these prerequisites are met, you can proceed with the following steps.

To start all services, navigate to the root directory of the project and execute the following command:

1. Build the frontend project

`pnpm --filter ./frontend build`

2. Build the image

`docker build -t tilloh-dev-frontend -f Frontend.Dockerfile .`

3. Build the backend project

`pnpm --filter ./backend build`

4. Build the image

`docker build -t tilloh-dev-backend -f Backend.Dockerfile .`

5. Start all services using Docker Compose

`docker-compose up -d`

### Usage

After starting all services contained in docker-compose file the first user must be created manually.

Use a tool like Postman or do a POST http://localhost:61154/v1/identifiers request the way you like. It is important to provide an Authrization: Bearer <ADMIN_IDENTIFIER> header in the request to authorize. After that you will get an identifier id that can be used for further usage in the application user interface login screen.

## E2E Tests

E2E tests run locally with [Playwright](https://playwright.dev/) against a real backend + MongoDB. Backend (port 61155) and frontend (port 5173) are started **automatically** — no manual startup required.

### Setup (one-time)

```bash
# 1. Start MongoDB
pnpm --filter ./backend start:db

# 2. Install E2E dependencies and Chromium
pnpm e2e:install

# 3. Create and fill .env.test
pnpm e2e:setup
# Open e2e/.env.test and set E2E_ADMIN_IDENTIFIER (= ADMIN_IDENTIFIER from backend/.env)
```

### Running tests

```bash
pnpm e2e            # Headless (fast)
pnpm e2e:headed     # With visible browser
pnpm e2e:ui         # Playwright UI (interactive, with timeline and traces)
```

### Structure

```
e2e/
  playwright.config.ts          # Config: Chromium, webServer, global setup/teardown
  .env.test.example             # Template for local config (committed)
  global-setup.ts               # Creates test identifier + seed joke in DB
  global-teardown.ts            # Cleans up test data
  fixtures/
    authenticated.fixture.ts    # localStorage injection for auth bypass
  helpers/
    api.ts                      # HTTP helpers for setup/teardown
    constants.ts                # URLs, identifiers
  tests/
    auth/login.spec.ts          # Login gate and login flow
    navigation/home.spec.ts     # Header, nav grid, tile navigation
    features/about.spec.ts      # Static content, i18n DE/EN
    features/uno-sort.spec.ts   # Card drawing, reset (no backend)
    features/jokes.spec.ts      # Random joke, FAB modal
    features/admin.spec.ts      # Two-step auth, dashboard
```

## Development

Before committing changes it is necessary to fix all linting errors. After cloning this repository, `pnpm install` will automatically install a pre-commit hook that will run the linter before committing changes!

Start frontend and backend development server with `pnpm dev`.

### Gitmoji

This repository uses [gitmoji](https://gitmoji.dev/) to categorize commits. By installing dependencies with pnpm in the root of this repository, a post-commit hook will automatically add a gitmoji to your commit message. If you want to disable this feature, you can remove the post-commit hook by running `rm .git/hooks/post-commit`.
