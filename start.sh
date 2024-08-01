#!/bin/bash

set -euo pipefail

# Global variables
CLONE_DIR="mine-docker-compose"

# Function to start Docker Compose
start_docker_compose() {
    if [[ -d "$CLONE_DIR" ]]; then
        cd "$CLONE_DIR" || { printf "Error: Failed to change directory to %s\n" "$CLONE_DIR" >&2; exit 1; }
        if ! sudo docker compose up -d; then
            printf "Error: Failed to start Docker Compose.\n" >&2
            exit 1
        fi
    else
        printf "Error: Directory %s does not exist. Please ensure the repository is cloned.\n" "$CLONE_DIR" >&2
        exit 1
    fi
}

main() {
    start_docker_compose
}

main "$@"
