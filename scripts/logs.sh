#!/bin/bash
# scripts/logs.sh

if [ -z "$1" ]; then
    echo "Usage: ./logs.sh [infrastructure|nginx|waha|chatwoot|n8n|your-app]"
    echo ""
    echo "Available services:"
    echo "  infrastructure - MySQL, PostgreSQL, Redis"
    echo "  nginx         - Nginx Proxy Manager"
    echo "  waha          - WhatsApp HTTP API"
    echo "  chatwoot      - Customer Support Platform"
    echo "  n8n           - Workflow Automation"
    echo "  your-app      - Custom Application"
    exit 1
fi

case $1 in
    infrastructure)
        cd infrastructure && docker-compose logs -f
        ;;
    nginx)
        cd nginx-proxy && docker-compose logs -f
        ;;
    waha)
        cd waha && docker-compose logs -f
        ;;
    chatwoot)
        cd chatwoot && docker-compose logs -f
        ;;
    n8n)
        cd n8n && docker-compose logs -f
        ;;
    your-app)
        cd your-app && docker-compose logs -f
        ;;
    *)
        echo "Invalid service name"
        echo "Available: infrastructure, nginx, waha, chatwoot, n8n, your-app"
        ;;
esac