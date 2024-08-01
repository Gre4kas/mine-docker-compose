#!/bin/bash

set -euo pipefail

# Global variables
APT_KEYRING_DIR="/etc/apt/keyrings"
DOCKER_KEY_FILE="${APT_KEYRING_DIR}/docker.asc"
DOCKER_REPO_LIST="/etc/apt/sources.list.d/docker.list"
DOCKER_REPO_URL="https://download.docker.com/linux/ubuntu"
GIT_REPO_URL="https://github.com/Gre4kas/mine-docker-compose.git"
CLONE_DIR="mine-docker-compose"

# Function to install necessary packages
install_packages() {
    echo "Installing necessary packages..."
    sudo apt-get update -y
    sudo apt-get install -y ca-certificates curl gnupg
}

# Function to add Docker's GPG key
add_docker_gpg_key() {
    echo "Adding Docker's GPG key..."
    sudo install -m 0755 -d "$APT_KEYRING_DIR"
    if ! sudo curl -fsSL "$DOCKER_REPO_URL/gpg" -o "$DOCKER_KEY_FILE"; then
        printf "Error: Failed to download Docker's GPG key.\n" >&2
        return 1
    fi
    sudo chmod a+r "$DOCKER_KEY_FILE"
}

# Function to add Docker's repository
add_docker_repo() {
    echo "Adding Docker's repository..."
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
    echo "Installing Docker packages..."
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

# Function to configure Docker group and user permissions
configure_docker_permissions() {
    echo "Configuring Docker group and user permissions..."
    if ! getent group docker > /dev/null; then
        sudo groupadd docker
    fi
    sudo usermod -aG docker "$USER"
}

# Function to clone the Git repository
clone_repo() {
    echo "Cloning the Git repository..."
    if [[ -d "$CLONE_DIR" ]]; then
        printf "Directory %s already exists. Skipping clone.\n" "$CLONE_DIR"
        return 0
    fi
    
    if ! git clone "$GIT_REPO_URL" "$CLONE_DIR"; then
        printf "Error: Failed to clone the Git repository.\n" >&2
        return 1
    fi
}

main() {
    install_packages
    add_docker_gpg_key
    add_docker_repo
    install_docker
    configure_docker_permissions

    clone_repo

    printf "Docker installation and configuration complete.\n"
    printf "Starting Docker Compose as the 'docker' group...\n"
    
    cd "$CLONE_DIR" || { printf "Error: Directory %s does not exist or cannot be accessed.\n" "$CLONE_DIR" >&2; return 1; }

    chmod +x ./start.sh
    ./start.sh
}

main "$@"
