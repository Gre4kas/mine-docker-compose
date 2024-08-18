#!/bin/bash

set -euo pipefail

# Setting the USER variable manually or using whoami
USER=$(whoami)

# Global variables
APT_KEYRING_DIR="/etc/apt/keyrings"
DOCKER_KEY_FILE="${APT_KEYRING_DIR}/docker.asc"
DOCKER_REPO_LIST="/etc/apt/sources.list.d/docker.list"
DOCKER_REPO_URL="https://download.docker.com/linux/ubuntu"
GIT_REPO_URL="https://github.com/Gre4kas/mine-docker-compose.git"
CLONE_DIR="mine-docker-compose"

# Function to install necessary packages
install_packages() {
    printf "Installing necessary packages...\n"
    sudo apt-get update -y
    sudo apt-get install -y ca-certificates curl gnupg
}

# Function to add Docker's GPG key
add_docker_gpg_key() {
    printf "Adding Docker's GPG key...\n"
    sudo install -m 0755 -d "$APT_KEYRING_DIR"
    if ! sudo curl -fsSL "$DOCKER_REPO_URL/gpg" -o "$DOCKER_KEY_FILE"; then
        printf "Error: Failed to download Docker's GPG key.\n" >&2
        return 1
    fi
    sudo chmod a+r "$DOCKER_KEY_FILE"
}

# Function to add Docker's repository
add_docker_repo() {
    printf "Adding Docker's repository...\n"
    local codename; codename=$(source /etc/os-release && printf "%s" "$VERSION_CODENAME")
    if [[ -z "$codename" ]]; then
        printf "Error: Failed to determine Ubuntu codename.\n" >&2
        return 1
    fi
    
    printf "deb [arch=$(dpkg --print-architecture) signed-by=%s] %s %s stable\n" \
        "$DOCKER_KEY_FILE" "$DOCKER_REPO_URL" "$codename" | \
        sudo tee "$DOCKER_REPO_LIST" > /dev/null

    sudo apt-get update -y
}

# Function to install Docker packages
install_docker() {
    printf "Installing Docker packages...\n"
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

# Function to configure Docker group and user permissions
configure_docker_permissions() {
    printf "Configuring Docker group and user permissions...\n"
    if ! getent group docker > /dev/null; then
        sudo groupadd docker
    fi
    sudo usermod -aG docker "$USER"
}

# Function to enable and start Docker service, and set proper permissions on the Docker socket
setup_docker_service() {
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo chown "$USER" /var/run/docker.sock
}

# Function to clone the Git repository
clone_repo() {
    printf "Cloning the Git repository...\n"
    if [[ -d "$CLONE_DIR" ]]; then
        printf "Directory %s already exists. Skipping clone.\n" "$CLONE_DIR"
        return 0
    fi
    
    if ! git clone "$GIT_REPO_URL" "$CLONE_DIR"; then
        printf "Error: Failed to clone the Git repository.\n" >&2
        return 1
    fi
}

# Function to start Docker Compose
start_docker_compose() {
    local current_dir; current_dir=$(pwd)
    
    if [[ "$(basename "$current_dir")" != "$CLONE_DIR" ]]; then
        if [[ -d "$CLONE_DIR" ]]; then
            cd "$CLONE_DIR" || { printf "Error: Failed to change directory to %s\n" "$CLONE_DIR" >&2; return 1; }
        else
            printf "Error: Directory %s does not exist. Please ensure the repository is cloned.\n" "$CLONE_DIR" >&2
            return 1
        fi
    fi

    if ! sudo docker compose up -d; then
        printf "Error: Failed to start Docker Compose.\n" >&2
        return 1
    fi
}

main() {
    install_packages
    add_docker_gpg_key
    add_docker_repo
    install_docker
    configure_docker_permissions
    setup_docker_service

    clone_repo
    start_docker_compose

    printf "Docker installation, configuration, and Docker Compose startup complete.\n"
}

main "$@"
