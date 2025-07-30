# Matrix-Synapse-deployment

## Overview

This project automates the deployment of a secure Matrix Synapse homeserver on Akamai Linode, including infrastructure provisioning, Dockerized Synapse, NGINX reverse proxy, and SSL certificate automation using Ansible and Terraform.

---

## Features

- **Automated Linode VM provisioning** with Terraform
- **Matrix Synapse deployment** in Docker
- **NGINX reverse proxy** for secure HTTPS access
- **Let's Encrypt SSL certificate** automation with Ansible
- **Sensitive data protection** via `.gitignore`

---

## Deployment Steps

### 1. Infrastructure Provisioning

- Use Terraform to create a Linode VM (Ubuntu 22.04).
- Example: `terraform apply` provisions the server.

### 2. Matrix Synapse Deployment

- SSH into the server.
- Generate Synapse config:
  ```sh
  docker run -it --rm \
    -e SYNAPSE_SERVER_NAME=fidevops.xyz \
    -e SYNAPSE_REPORT_STATS=yes \
    -v /opt/synapse/data:/data \
    matrixdotorg/synapse:latest generate
  ```
- Start Synapse:
  ```sh
  docker run -d \
    --name synapse \
    -v /opt/synapse/data:/data \
    -p 8008:8008 \
    matrixdotorg/synapse:latest
  ```

### 3. NGINX Reverse Proxy & SSL Automation

- Run the Ansible playbook to install NGINX, configure the reverse proxy, and obtain a Let's Encrypt SSL certificate:
  ```sh
  ansible-playbook -i inventory.ini nginx_ssl_playbook.yml
  ```
- Your Matrix server is now accessible at:  
  `https://fidevops.xyz`

### 4. User Creation

- Register an admin user:
  ```sh
  docker exec -it synapse register_new_matrix_user -c /data/homeserver.yaml http://localhost:8008
  ```
- Use [Element Web](https://app.element.io/#/login) to log in with your domain as the homeserver.

---

## Security & Best Practices

- Sensitive files (`terraform.tfvars`, `inventory.ini`, etc.) are excluded from version control via `.gitignore`.
- All secrets and credentials should be managed securely and never committed.

---

## Next Steps

- [ ] Set up social media bridges (Mautrix)
- [ ] Add frontend (React/Next.js)
- [ ] Implement AI features (summarization, intent parsing, etc.)

---

## Resources

- [Matrix Synapse Documentation](https://matrix-org.github.io/synapse/latest/)
- [Docker Synapse Image](https://hub.docker.com/r/matrixdotorg/synapse)
- [NGINX Reverse Proxy Guide](https://matrix-org.github.io/synapse/latest/reverse_proxy.html#nginx)
- [Certbot Docs](https://certbot.eff.org/instructions)
- [Element Client](https://element.io/get-started)

---

**Project by Sofoniasm**
