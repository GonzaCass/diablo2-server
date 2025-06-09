#!/bin/bash

CONTAINER_NAME="diablo2-server"
HOST_DIR="."

docker compose up -d

echo "📥 Copiando configuraciones desde el container al host..."

docker cp "$CONTAINER_NAME:/pvpgn/etc/pvpgn/" "$HOST_DIR/etc"
docker cp "$CONTAINER_NAME:/pvpgn/var/pvpgn/" "$HOST_DIR/var"
docker cp "$CONTAINER_NAME:/root/.wine/drive_c/d2gs/d2gs.reg" "$HOST_DIR/conf"

docker compose down

echo "✅ Configuraciones copiadas al host."

