# Operations

Where and how tilloh.dev runs (D-031). Update this file in the same PR as any
change to operations.

| Topic | State |
|---|---|
| **Runs on** | Uberspace: frontend as static files in `~/html`, backend in `~/api` as supervisor service `tilloh-api-daemon` |
| **Database** | MongoDB — location open, Tim to fill in |
| **Deploy** | GitHub Actions on push to `main`: `frontend_deployment.main.yml`, `backend_deployment.main.yml`; manual restart via `backend_restart.yml` |
| **Monitoring** | `/health` and `/metrics` (Prometheus) exist; who checks availability, logs and errors: open |
| **Backup** | MongoDB holds user data; backup open |
| **Secrets in CI** | GitHub Environments, protected branches only: `production` → `main` |
| **Secrets at runtime** | `backend/.env` on the Uberspace host; never in the repo |

## Minimum Rules for Tier 2

- Deploy only via CI from `main`, never by hand.
- Secrets never in the repo; CI secrets only in environments.
- Backup for everything that holds user data.
- Availability is monitored.
- Logs and errors are monitored.

## Deploy Flow

**Frontend** (changes in `frontend/**`):

1. Build static SPA, zip `dist/`.
2. `scp` to Uberspace, copy into `~/html`.

**Backend** (changes in `backend/**`):

1. Lint, test, build with NX; copy `package.json` next to the build.
2. `scp` to Uberspace, copy into `~/api`.
3. `npm i` on the host (deliberate deviation, see `AGENTS.md`).
4. Restart `tilloh-api-daemon` via `supervisorctl`.
