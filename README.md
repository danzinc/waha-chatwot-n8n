# WAHA & Chatwoot Self-Hosted Stack

This repository provides a complete, Docker-based stack for self-hosting [WAHA (WhatsApp HTTP API)](https://github.com/devlikeapro/waha) and [Chatwoot](https://www.chatwoot.com/), with [Nginx Proxy Manager](https://nginxproxymanager.com/) for easy domain management and SSL termination.

This setup is designed for developers and businesses looking to have a robust, private, and scalable customer communication platform.

## 🚀 Components

This stack includes:

*   **Chatwoot**: Open-source customer engagement platform.
*   **WAHA (WhatsApp HTTP API)**: A reliable and feature-rich WhatsApp API gateway.
*   **Nginx Proxy Manager**: A user-friendly interface for managing reverse proxy hosts and SSL certificates.
*   **PostgreSQL**: Database for Chatwoot.
*   **Redis**: In-memory data store, required by Chatwoot.
*   **MySQL**: Database service, available for use by WAHA or other services.

## ✅ Prerequisites

Before you begin, ensure you have the following:

*   Docker and Docker Compose installed on your server.
*   A Linux server (VPS or dedicated) with a public IP address.
*   At least one domain name (e.g., `chat.yourdomain.com`) pointed to your server's IP.

## 🛠️ Installation & Setup

Follow these steps to get your stack up and running.

### 1. Clone the Repository

```bash
git clone <your-repository-url>
cd devops-waha-nginx-chatwoot
```

### 2. Initialize the Environment

Run the setup script to create the necessary directory structure and set file permissions. This prepares the project for configuration and data storage.

```bash
bash scripts/setup-environment.sh
```

### 3. Configure Environment Variables

This is a critical security step. You must update the placeholder passwords and configurations in the environment files. **Do not use the default values in production.**

You will likely need to edit the following files:
*   `./.env` - Main environment file for database passwords and common settings.
*   `./chatwoot/.env` - Specific configurations for Chatwoot.
*   `./waha/.env` - Specific configurations for WAHA.

> **🔒 Security Warning:** Never commit your `.env` files to a Git repository. The `.gitignore` file in this project should already be configured to ignore them.

### 4. Start the Services

Once the environment files are configured, start all services using the provided script.

```bash
bash scripts/start-all.sh
```

This command will pull the required Docker images and start all the containers in detached mode.

## ⚙️ Post-Installation Configuration

After the containers are running, you need to configure the Nginx proxy to make your services accessible via your domain.

1.  **Nginx Proxy Manager Setup:**
    *   Access the Nginx Proxy Manager web UI by navigating to `http://<your-server-ip>:81`.
    *   Default login credentials:
        *   Email: `admin@example.com`
        *   Password: `changeme`
    *   You will be forced to change these credentials on your first login.

2.  **Configure Proxy Hosts & SSL:**
    *   Inside Nginx Proxy Manager, go to `Hosts` -> `Proxy Hosts`.
    *   Add a new proxy host for Chatwoot (e.g., `chat.yourdomain.com`) pointing to the service name `chatwoot` on port `3000`.
    *   Add another proxy host for WAHA (e.g., `waha.yourdomain.com`) pointing to the service name `waha` on its configured port.
    *   In the `SSL` tab for each host, request a new "Let's Encrypt" certificate to enable HTTPS.

3.  **Webhook Configuration:**
    *   To integrate WAHA with Chatwoot, you need to configure webhooks.
    *   In Chatwoot, create a new WhatsApp channel via an "API" inbox. This will provide you with an `Endpoint URL`, `Account ID`, and `Access Token`.
    *   In your WAHA configuration, set the webhook endpoint to the URL provided by Chatwoot to forward incoming messages.

## 🎛️ Usage

*   **Start all services:** `./scripts/start-all.sh`
*   **Stop all services:** `docker-compose down`
*   **View logs for a specific service:** `docker-compose logs -f <service_name>` (e.g., `chatwoot`, `waha`)

## 🗄️ Backup and Restore

The `backups` directory is created for storing backups. You should implement a regular backup strategy for your persistent data. This includes:

*   PostgreSQL database (for Chatwoot)
*   MySQL database (if used)
*   Nginx Proxy Manager data (`./nginx-proxy/data` and `./nginx-proxy/letsencrypt`)

## 🔐 Security Checklist

Please review the security recommendations from the setup script:

*   [ ] **Update all default passwords** in `.env` files.
*   [ ] Use strong, unique passwords (minimum 16 characters recommended).
*   [ ] **Never commit `.env` files to Git.**
*   [ ] Set up SSL certificates for all public-facing services.
*   [ ] Configure your server's firewall to only allow necessary ports (e.g., 80, 443, 81).

## 📂 Directory Structure

```
.
├── backups/                # For storing service backups
├── chatwoot/               # Chatwoot configuration and data
├── infrastructure/         # Database configurations and init scripts
├── nginx-proxy/            # Nginx Proxy Manager data and certificates
├── scripts/                # Helper scripts for managing the stack
└── waha/                   # WAHA configuration and data
```

---

Happy hosting!