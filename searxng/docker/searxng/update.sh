#!/usr/bin/env sh
set -eu
cd "$(dirname "$0")"
docker compose pull
docker compose up -d --wait --wait-timeout 180
docker compose ps
