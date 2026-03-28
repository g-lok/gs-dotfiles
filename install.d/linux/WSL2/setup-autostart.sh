#!/usr/bin/env bash
## WSL2 Auto-Start Services Setup
## This script sets up systemd services for auto-starting Caddy and Docker

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYSTEMD_DIR="$HOME/.config/systemd/user"

echo "=========================================="
echo "WSL2 Auto-Start Services Setup"
echo "=========================================="

mkdir -p "$SYSTEMD_DIR"

# ==========================================
# CADDY SERVICE (Commented out by default)
# ==========================================

cat > "$SYSTEMD_DIR/caddy.service" << 'EOF'
# Caddy Web Server Service
# 
# To enable: uncomment the lines below and run:
#   systemctl --user enable caddy
#   systemctl --user start caddy

# [Unit]
# Description=Caddy Web Server
# After=network-online.target
# Wants=network-online.target

# [Service]
# Type=notify
# ExecStart=/home/linuxbrew/.linuxbrew/bin/caddy run --config /home/g/.config/caddy/Caddyfile
# ExecReload=/home/linuxbrew/.linuxbrew/bin/caddy reload --config /home/g/.config/caddy/Caddyfile
# TimeoutStopSec=5s
# LimitNOFILE=1048576
# LimitNPROC=512
# PrivateTmp=true
# AmbientCapabilities=CAP_NET_BIND_SERVICE

# [Install]
# WantedBy=multi-user.target
EOF

# ==========================================
# DOCKER SERVICE (Commented out by default)
# ==========================================

cat > "$SYSTEMD_DIR/docker.service" << 'EOF'
# Docker Service
#
# Note: Docker Desktop on Windows already runs Docker.
# This is for running Docker inside WSL2 directly.
#
# To enable: uncomment the lines below and run:
#   systemctl --user enable docker
#   systemctl --user start docker

# [Unit]
# Description=Docker Container Manager
# After=network-online.target
# Wants=network-online.target

# [Service]
# Type=oneshot
# ExecStart=/home/linuxbrew/.linuxbrew/bin/dockerd
# RemainAfterExit=yes
# ExecReload=/bin/kill -s HUP $MAINPID
# TimeoutSec=0
# RestartSec=2
# Restart=always
# StartLimitBurst=3
# StartLimitInterval=60s
# LimitNOFILE=infinity
# LimitNPROC=infinity
# LimitCORE=infinity
# TasksMax=infinity

# [Install]
# WantedBy=multi-user.target
EOF

# ==========================================
# DOCKER COMPOSE SERVICES (Commented)
# ==========================================

cat > "$SYSTEMD_DIR/docker-compose@.service" << 'EOF'
# Docker Compose Service Template
#
# Example: systemctl --user enable docker-compose@myproject
#
# Create a service for each compose project:
#   cp docker-compose@.service docker-compose@myproject.service
# Edit the service file to set your project path
#
# [Unit]
# Description=Docker Compose Project: %i
# Requires=docker.service
# After=docker.service

# [Service]
# Type=oneshot
# WorkingDirectory=/home/g/docker/%i
# ExecStart=/home/linuxbrew/.linuxbrew/bin/docker-compose up -d
# ExecStop=/home/linuxbrew/.linuxbrew/bin/docker-compose down
# RemainAfterExit=yes

# [Install]
# WantedBy=multi-user.target
EOF

echo ""
echo "Created systemd service files:"
echo "  - $SYSTEMD_DIR/caddy.service"
echo "  - $SYSTEMD_DIR/docker.service"
echo "  - $SYSTEMD_DIR/docker-compose@.service"
echo ""
echo "=========================================="
echo "To enable auto-start:"
echo "=========================================="
echo ""
echo "# For Caddy:"
echo "#   cp $SYSTEMD_DIR/caddy.service.bak \$SYSTEMD_DIR/caddy.service"
echo "#   systemctl --user enable caddy"
echo "#   systemctl --user start caddy"
echo ""
echo "# For Docker:"
echo "#   cp \$SYSTEMD_DIR/docker.service.bak \$SYSTEMD_DIR/docker.service"
echo "#   systemctl --user enable docker"
echo "#   systemctl --user start docker"
echo ""
echo "# For Docker Compose services:"
echo "#   cp \$SYSTEMD_DIR/docker-compose@.service.bak \$SYSTEMD_DIR/docker-compose@<project>.service"
echo "#   systemctl --user enable docker-compose@<project>"
echo ""
echo "Currently: ALL SERVICES ARE DISABLED (commented out)"
echo ""
echo "To enable, edit the .service files and uncomment the sections."
