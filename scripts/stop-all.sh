echo "🛑 Stopping all services..."
 
cd n8n && docker compose down && cd ..
cd chatwoot && docker compose down && cd ..
cd waha && docker compose down && cd ..
cd nginx-proxy && docker compose down && cd ..
cd infrastructure && docker compose down && cd ..

echo "✅ All services stopped!"
