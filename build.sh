#!/bin/bash
set -e

# If no argument or help requested
if [ $# -eq 0 ] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    echo "Usage: ./build.sh <ProjectName> [make_target]"
    echo
    echo "Examples:"
    echo "  ./build.sh FirstExample            # build default target"
    echo "  ./build.sh FirstExample clean      # clean build output"
    echo
    exit 0
fi

PROJECT=$1
TARGET=${2:-all}

# Build Docker image if not present
if ! docker image inspect nuvoton-dev-env &> /dev/null; then
    echo "[*] Building Docker image 'nuvoton-dev-env'..."
    docker build -t nuvoton-dev-env .
fi

# Run build
docker run --rm -u $UID -v "$(pwd)":/workdir -w "/workdir/$PROJECT/Build" nuvoton-dev-env make $TARGET
