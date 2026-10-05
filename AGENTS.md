# AGENTS.md — tilloh.dev

Personal portfolio and tool collection for Tim and a small, known group of
users: SvelteKit SPA frontend, NestJS API with MongoDB, NX monorepo.

Prozessstand: tide 0.7.0 (2026-10-06)
Sicherheitsstufe: 2 — login via identifier, personal data (bookmarks, todos, chat), known user group only.

This file is the project's contract: it applies to everyone working here,
human or AI. How the AI works with Tim comes with the tide plugin; without
tide, only this file applies.

## Rules

- Every change comes as a PR, never directly to `main`. A PR is merged only
  when the `gate` check is green and Tim has approved.
- No `docs/DESIGN.md` yet (`/tide:design`); until then the existing styles
  are the reference. New design values (colour, font size) only after asking.
- Dependencies: as few as possible; every new one is justified in the PR.
- Tests: unit tests for logic; E2E for login and the core flows (run locally,
  see deviations).
- Secrets never go into the repo; `.env` files stay local.
- Every PR updates `CHANGELOG.md` under `## [Unreleased]` (Renovate PRs
  excepted).

## Language

| Text type | Language |
|---|---|
| Code, identifiers, tests | English |
| Code comments | English |
| Commit messages | English |
| CHANGELOG entries | English |
| PR texts | English |
| Docs in `docs/` | English |
| UI texts | German and English via i18n (`de.json`, `en.json`) |

## Requirements

Features are described before implementation in
`docs/requirements/F-<nr>-<name>.md`, from the template `F-000-template.md`.
After implementation the document is frozen; it gets the line
`Umgesetzt: PR #<nr> (<date>)`. If a later feature changes the behaviour, the
new document names it: `Ersetzt: F-<nr> FA-<n>`.

## Project Docs

- [`docs/requirements/`](docs/requirements/) — requirements `F-<nr>`, frozen
  after approval.
- [`docs/features/`](docs/features/) — feature explanations, kept current with
  the code.
- [`docs/shared/`](docs/shared/) — shared infrastructure (auth guard,
  keystore, identifiers, i18n, stores, NX scaffold, route pattern).
- [`docs/development.md`](docs/development.md) — architecture, coding
  conventions, environment, E2E setup.
- [`docs/backlog.md`](docs/backlog.md) — accepted observations.
- [`docs/betrieb.md`](docs/betrieb.md) — where and how the project runs,
  deploy, monitoring, backup, location of secrets.
- `docs/DESIGN.md` — not created yet; run `/tide:design` first.

## Commands

| Purpose | Command |
|---|---|
| Install dependencies | `pnpm install` |
| Dev server (frontend + backend) | `pnpm dev` |
| Start local MongoDB | `pnpm --filter ./backend start:db` |
| Tests | `pnpm test` |
| E2E tests (local only) | `pnpm e2e` |
| Lint | `pnpm lint` |
| Type check | `pnpm check` |
| Build | `pnpm build` |

## Gotchas

- `frontend/` and `backend/` are separate NX workspaces with their own
  `nx.json`; run `nx` from inside the package.
- Backend libs use `@backend/` path aliases; new libs follow
  [`docs/shared/nx-library-scaffold.md`](docs/shared/nx-library-scaffold.md).
- Endpoints need a bearer token unless marked `@Public()`
  ([`docs/shared/auth-guard.md`](docs/shared/auth-guard.md)).

## Bewusste Abweichungen

Vom Prozess bewusst abweichend entschieden, eine Zeile pro Punkt mit Grund.
Der Bootstrap lässt diese Punkte in Ruhe.

- Uberspace installiert Backend-Dependencies weiter mit `npm i` aus
  `backend/package.json` — pnpm gilt nur im Repo und in der CI, der Host
  bleibt ohne pnpm.
- E2E-Tests laufen nur lokal, kein CI-Job `e2e` — sie brauchen MongoDB und
  eine Admin-ID; ein Mongo-Service in der CI ist eine eigene Aufgabe.
- Jeder PR aktualisiert `CHANGELOG.md`, geprüft vom CI-Job `changelog` — der
  CHANGELOG ist die Release-Historie des Projekts.
- `pnpm audit` in der CI prüft nur Produktions-Dependencies (`--prod`) —
  kritische Lücken gibt es zurzeit nur in Dev-Werkzeugen, wie schon vor tide.
