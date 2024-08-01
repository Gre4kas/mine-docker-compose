# Project Overview

This project now includes Infrastructure as Code (IaC) using Terraform to automate the deployment of a Minecraft server on AWS. It integrates a Docker Compose setup with monitoring and visualization tools, providing a seamless way to run and manage your Minecraft server. Upon starting the server, you can connect directly to your Minecraft instance.

## Purpose

The primary purpose of this project is to simplify the setup and management of a Minecraft server, utilizing Terraform to deploy the necessary infrastructure on AWS. This allows users to focus on the gaming experience without getting bogged down by complex technical configurations.

## Installation

### Prerequisites

Make sure you have the following installed on your machine:

- [Terraform](https://www.terraform.io/downloads)
- [Git](https://git-scm.com/downloads)

### Clone the Repository

Clone the project's GitHub repository to your local machine using the following command:

```bash
git clone https://github.com/Gre4kas/mine-docker-compose.git
```

### Navigate to the Project Directory

``` bash
cd mine-docker-compose
```

### Deploy the Minecraft Server with Terraform

Use the provided script to apply the Terraform configuration and launch the Minecraft server on AWS:

``` bash
./start.sh apply
```
This command will automatically provision the necessary AWS infrastructure and start the Minecraft server.Once the server is up and running, you can connect to your Minecraft server using the following IP address:

``` bash
<your_ip>:25565
```

### Monitor the Server

You can monitor the Minecraft server's performance and resource utilization using the Grafana web interface. To access Grafana, open a web browser and navigate to the following URL:

``` bash
http://<your_ip>:3000

```

### Destroy the AWS Infrastructure

When you're done with the server and want to tear down the infrastructure, use the following command:

``` bash
./start.sh destroy
```
