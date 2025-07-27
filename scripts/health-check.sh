#!/bin/bash
# scripts/health-check.sh

echo "🏥 Health Check for All Services"
echo "================================"

# Check if containers are running
echo "📋 Container Status:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep -E "(mysql|postgres|redis|nginx|waha|chatwoot|n8n)"

echo ""
echo "🔌 Port Connectivity:"

# Check MySQL
if nc -z localhost 3306; then
    echo "✅ MySQL (3306) - Connected"
else
    echo "❌ MySQL (3306) - Not accessible"
fi

# Check PostgreSQL  
if nc -z localhost 5432; then
    echo "✅ PostgreSQL (5432) - Connected"
else
    echo "❌ PostgreSQL (5432) - Not accessible"
fi

# Check Redis
if nc -z localhost 6379; then
    echo "✅ Redis (6379) - Connected"
else
    echo "❌ Redis (6379) - Not accessible"
fi

# Check Nginx Proxy Manager
if nc -z localhost 81; then
    echo "✅ Nginx Proxy Manager (81) - Connected"
else
    echo "❌ Nginx Proxy Manager (81) - Not accessible"
fi

echo ""
echo "💾 Database Status:"

# Check MySQL databases
echo "📊 MySQL Databases:"
docker exec infrastructure_mysql_1 mysql -u root -p$MYSQL_ROOT_PASSWORD -e "SHOW DATABASES;" 2>/dev/null | grep -E "(npm_db|your_app_db)" || echo "❌ MySQL connection failed"

# Check PostgreSQL databases
echo "🐘 PostgreSQL Databases:"
docker exec infrastructure_postgres_1 psql -U postgres -c "\l" 2>/dev/null | grep -E "(waha_db|chatwoot_db|n8n_db)" || echo "❌ PostgreSQL connection failed"

echo ""
echo "🚀 Service URLs (configure in Nginx Proxy Manager):"
echo "   - Waha API: http://waha:3000"
echo "   - Chatwoot: http://chatwoot-web:3000"  
echo "   - N8N: http://n8n:5678"
echo "   - Your App: http://web-app:80"

