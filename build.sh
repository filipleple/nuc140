#!/bin/bash

PROJECT="$1"
TARGET="${2:-all}"

# Name of Docker image
IMAGE="nuvoton-dev-env"

# Check if image exists
if ! docker image inspect "$IMAGE" > /dev/null 2>&1; then
  echo "[INFO] Docker image '$IMAGE' not found. Building it now..."
  docker build -t "$IMAGE" "$(dirname "$0")" || {
    echo "[ERROR] Failed to build Docker image '$IMAGE'."
    exit 1
  }
  echo "[INFO] Docker image '$IMAGE' built successfully."
fi

# Run build inside the container
docker run --rm -u $UID -v "$(pwd)":/workdir -w "/workdir/$PROJECT/Build" "$IMAGE" make "$TARGET"
