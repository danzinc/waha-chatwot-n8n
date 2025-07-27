#!/bin/bash
# scripts/start-all.sh

echo "🚀 Starting infrastructure services (MySQL, PostgreSQL, Redis)..."
cd infrastructure && docker compose up -d && cd ..

echo "⏳ Waiting for databases to be ready..."
sleep 60

echo "🌐 Starting Nginx Proxy Manager..."
cd nginx-proxy && docker compose up -d && cd ..

echo "💬 Starting WhatsApp HTTP API (Waha)..."
cd waha && docker compose up -d && cd ..

echo "🎧 Starting Chatwoot Customer Support..."
cd chatwoot && docker compose up -d && cd ..

echo "🔄 Starting N8N Workflow Automation..."
cd n8n && docker compose up -d && cd ..


echo "✅ All services started!"
echo ""
echo "🔗 Access points:"
echo "   - Nginx Proxy Manager: http://domain:81"
echo "   - MySQL: localhost:3306"
echo "   - PostgreSQL: localhost:5432"
echo "   - Redis: localhost:6379"
echo "   - PgAdmin: Setup via NPM"
echo "   - PhpMyAdmin: Setup via NPM"
echo ""
echo "📋 Next steps:"
echo "   1. Configure domains in Nginx Proxy Manager"
echo "   2. Set up SSL certificates"
echo "   3. Configure webhooks between services"