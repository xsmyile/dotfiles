# SearXNG

Personal SearXNG settings and a Docker Compose stack with Valkey. Both images
follow `latest`; updates are explicit, and upstream breaking changes are fixed
as they arise. `use_default_settings: true` keeps the settings file limited to
personal overrides. There is deliberately no version pin or `SEARXNG_VERSION`
override.

Requires Docker Compose, GNU Stow and OpenSSL. Run Stow from `~/dotfiles`.

## New machine

```sh
cd ~/dotfiles
stow searxng
cd ~/docker/searxng
cp -i .env.example .env
openssl rand -hex 32
```

Set `SEARXNG_SECRET` in `.env` to the generated value, then run `./update.sh`.
The default address is <http://localhost:8080>. Change the host and port in `.env`
as needed; the default host only allows connections from this machine.

## Migrate an existing ~/docker/searxng

Back up the existing directory, then deploy the package and reuse the local
environment. This preserves the existing secret and port. With no
`SEARXNG_HOST` set, the new Compose file binds to `127.0.0.1`.

```sh
cd ~/dotfiles
backup_dir="$HOME/docker/searxng.backup-$(date +%Y%m%d-%H%M%S)"
mv "$HOME/docker/searxng" "$backup_dir"
stow searxng
cp -i "$backup_dir/.env" "$HOME/docker/searxng/.env"
cd ~/docker/searxng
./update.sh
```

Remove `SEARXNG_VERSION` from the reused `.env` if present; it is no longer used.
The Compose project name and volume names match the existing setup, so Docker
reuses its named volumes. Recreating the service also refreshes its configuration
mount after the directory move. Keep the backup until the service works.

## Updates and troubleshooting

```sh
cd ~/docker/searxng
./update.sh
docker compose logs --tail 100 core valkey
```

`update.sh` pulls both latest images, recreates changed services and waits for
their health checks. It exits with an error if startup fails. A `latest` tag
does not update running containers automatically. Old images are left available
for troubleshooting; clean them up manually when desired.

Edit `core-config/settings.yml` to change preferences, then run
`docker compose restart core` to reload them. Files under `~/docker/searxng`
are linked to this package by Stow. `.env` and `*.bak*` are ignored by Git;
cache and Valkey data live in Docker named volumes.

The configuration directory is mounted read-only, and `FORCE_OWNERSHIP=false`
prevents SearXNG from changing ownership of the files in this repository.
The cache and Valkey volumes remain writable.

Upstream documentation:
[container installation](https://docs.searxng.org/admin/installation-docker.html)
and [settings](https://docs.searxng.org/admin/settings/settings.html).
