# cablemess

<!-- One paragraph: what it does, for whom, how often. -->

Started from the launchpad's `python-job` template: a small Python job in one container (the media audit's pattern).
Standard library first; add a `requirements.txt` (and a `pip install` line in the Dockerfile) only when needed.

## Run it here

```sh
cp .env.example .env        # fill it in
python3 app.py --once       # one run, then exit
```

## Deploy

- WOPR (home): `deploy/to-wopr.sh` → `/share/CACHEDEV2_DATA/DockerData/cablemess/`
- VPS (public): `deploy/to-vps.sh` → `apps@VPS:/srv/apps/cablemess/` (rootless Docker)

Keep the one that applies and delete the other. Settings live in `.env` beside the compose file on the server
(copied from `.env.example` on the first deploy); never in git.

## Where things are

| What | Where |
|:---|:---|
| Code | `beertastic/cablemess`, box `~/web/cablemess` |
| Runs on | (WOPR / VPS) |
| Data | `<stack>/data/` → `/data` in the container |
| Wiki | `cablemess.md` |
