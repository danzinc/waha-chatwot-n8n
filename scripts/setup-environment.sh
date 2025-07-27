#!/bin/bash
# scripts/setup-environment.sh

echo "🔧 Setting up environment files..."

# Create directories if they don't exist
mkdir -p infrastructure/mysql-init infrastructure/postgres-init
mkdir -p nginx-proxy/{data,letsencrypt}
mkdir -p waha chatwoot
mkdir -p backups scripts

# Set executable permissions
chmod +x scripts/*.sh

echo "📝 Environment files created. Please update passwords in .env files!"
echo ""
echo "🔐 Security checklist:"
echo "   ✅ Update all passwords in .env files"
echo "   ✅ Use strong passwords (min 16 characters)"
echo "   ✅ Never commit .env files to git"
echo "   ✅ Set up SSL certificates in production"
echo "   ✅ Configure firewall rules"
echo ""
echo "📋 Next steps:"
echo "   1. Update environment variables in all .env files"
echo "   2. Run: ./scripts/start-all.sh" 
echo "   3. Configure domains in Nginx Proxy Manager (localhost:81)"
echo "   4. Set up SSL certificates"
echo "   5. Configure webhooks between services"