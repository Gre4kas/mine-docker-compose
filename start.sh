#!/bin/bash

set -euo pipefail

# Global variables
GIT_REPO_URL="https://github.com/Gre4kas/mine-docker-compose.git"
CLONE_DIR="mine-docker-compose"

# Function to clone or update the Git repository and start Docker Compose
deploy_docker_compose() {
    if [[ -d "$CLONE_DIR" ]]; then
        printf "Directory %s already exists. Updating the repository...\n" "$CLONE_DIR"
        cd "$CLONE_DIR" || return 1
        if ! git pull; then
            printf "Error: Failed to update the Git repository.\n" >&2
            return 1
        fi
    else
        if ! git clone "$GIT_REPO_URL" "$CLONE_DIR"; then
            printf "Error: Failed to clone the Git repository.\n" >&2
            return 1
        fi
        cd "$CLONE_DIR" || return 1
    fi
    docker compose up -d
}

main() {
    deploy_docker_compose
    printf "Docker Compose has been started.\n"
}

main "$@"
