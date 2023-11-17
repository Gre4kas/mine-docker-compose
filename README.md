# Project Overview

This project provides a comprehensive Docker Compose setup for running a Minecraft server with integrated monitoring and visualization tools. It simplifies the deployment and management of a Minecraft server, ensuring a smooth and efficient gaming experience.

## Purpose

The primary purpose of this project is to streamline the setup and management of a Minecraft server, allowing users to focus on enjoying the game rather than dealing with complex technical configurations.

## Installation

#### Clone the Repository:

Clone the project's GitHub repository to your local machine using the following command:

```sh
git clone https://github.com/Gre4kas/mine-docker-compose.git
```

#### Navigate to the Project Directory:

Change your directory to the cloned project directory using the following command:

```sh
cd mine-docker-compose
```
#### Start the Minecraft Server:

```sh
docker-compose up -d
```
The `-d` flag tells Docker Compose to run the containers in detached mode, meaning they will continue running in the background even after you close the terminal window.

#### Monitor the Server:

You can monitor the Minecraft server's performance and resource utilization using the Grafana web interface. To access Grafana, open a web browser and navigate to the following URL:

```sh
http://localhost:3000
```

#### Stop the Server:

To stop the Minecraft server and its associated monitoring tools, run the following command:

```sh
docker compose down
```
