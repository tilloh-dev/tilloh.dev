# AGENTS.md — tilloh.dev

Personal portfolio and tool collection for Tim and a small, known group of
users: SvelteKit SPA frontend, NestJS API with MongoDB, NX monorepo.

Prozessstand: tide 0.4.4 (2026-10-04)
Sicherheitsstufe: 2 — login via identifier, personal data (bookmarks, todos, chat), known user group only.

## Pflichtregeln

- Antworten im Chat: kurz und scanbar, Ergebnis oder nächste Handlung zuerst
  (Details: Skill `tide:klartext`).
- Texte für Menschen — Doku, PRs, Commits, Backlog: Antwort zuerst, Struktur
  statt Prosa, nur was der Leser braucht (Details: Skill `tide:leserfreundlich`).
- Sobald du etwas beantwortet hast, behandle diese Antwort als erledigt. Richte
  dein Nachdenken in späteren Beiträgen darauf, was die Person jetzt fragt, und
  gehe frühere Antworten nicht erneut durch, es sei denn, die Person fragt danach
  oder weist auf ein Problem damit hin, oder du selbst einen Fehler bemerkst.
- Lege bei der Ausführung einer Aufgabe zuerst eine Aufgabenliste an und halte
  sie aktuell. Eine Anfrage ist erst erledigt, wenn alle Punkte abgearbeitet
  sind. Ausnahme: Greift ein Stopp-Kriterium, nenne den Grund zuerst und liste
  die offenen Punkte auf.
- Zeit ist wichtig. Aufgabenliste und Checks bleiben davon unberührt.
- Git und GitHub nur als tilloh-bot. Nie direkt auf `main` pushen, jede
  Änderung kommt per PR.
- Sprache: siehe Abschnitt „Language“.

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

Die Pflichtregeln stehen immer auf Deutsch.

## Workflow

1. **Plan:** clarify the feature in conversation, write requirements from the
   template to `docs/requirements/F-<nr>-<name>.md`. Implement only after
   approval.
2. **Implement:** autonomously up to the PR. After approval, give Tim the ready
   line `/goal F-<nr>: alle FA umgesetzt, Checks grün, PR offen, oder
   Stopp-Grund genannt` to start the implementation. Test first, red, then
   green; purely visual changes are exempt.
3. **Stop and ask** on: gap in the requirements, new dependency, DB migration
   or different security tier, open UI taste question, gate not achievable,
   better idea for the current feature.
4. **Finish:** PR with closing overview (result, requirements, checks,
   changed, next step, observations). Name observations outside the feature
   with a recommendation; only accepted ones go into `docs/backlog.md`.
   Every PR updates `CHANGELOG.md` under `## [Unreleased]`.

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
