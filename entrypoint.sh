#!/bin/sh
set -e

# Mantiene /repo sincronizado con origin/main cada 60s -- el calendario lee los
# CSV/HTML directo de este checkout (mismo origen que nginx), en vez de que el
# navegador de cada visitante le pegue a raw.githubusercontent.com. Evita el
# cacheo de Fastly/GitHub sobre raw.githubusercontent.com, que ignora query
# strings de cache-busting y puede servir contenido de minutos/horas de
# antigüedad -- confirmado en vivo 2026-09-28 (eventos Playlab de octubre
# ausentes pese a estar ya pusheados). git fetch/reset habla con la
# infraestructura git normal de GitHub, no con ese CDN de contenido raw.
(
  cd /repo
  while true; do
    git fetch origin main --quiet 2>>/var/log/recreolab-sync.log || true
    git reset --hard origin/main --quiet 2>>/var/log/recreolab-sync.log || true
    sleep 60
  done
) &

exec nginx -g "daemon off;"
