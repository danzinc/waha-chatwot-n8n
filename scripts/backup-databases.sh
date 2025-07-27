BACKUP_DIR="./backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "💾 Creating database backups..."

# Load environment variables
source infrastructure/.env

# MySQL Backups
echo "📊 Backing up MySQL databases..."
docker exec infrastructure_mysql_1 mysqldump -u root -p$MYSQL_ROOT_PASSWORD --all-databases > "$BACKUP_DIR/mysql_all_databases.sql"
docker exec infrastructure_mysql_1 mysqldump -u root -p$MYSQL_ROOT_PASSWORD npm_db > "$BACKUP_DIR/mysql_npm_db.sql"
docker exec infrastructure_mysql_1 mysqldump -u root -p$MYSQL_ROOT_PASSWORD your_app_db > "$BACKUP_DIR/mysql_your_app_db.sql"

# PostgreSQL Backups
echo "🐘 Backing up PostgreSQL databases..."
docker exec infrastructure_postgres_1 pg_dumpall -U postgres > "$BACKUP_DIR/postgres_all_databases.sql"
docker exec infrastructure_postgres_1 pg_dump -U postgres -d waha_db > "$BACKUP_DIR/postgres_waha_db.sql"
docker exec infrastructure_postgres_1 pg_dump -U postgres -d chatwoot_db > "$BACKUP_DIR/postgres_chatwoot_db.sql"
docker exec infrastructure_postgres_1 pg_dump -U postgres -d n8n_db > "$BACKUP_DIR/postgres_n8n_db.sql"

# Redis Backup
echo "📝 Backing up Redis..."
docker exec infrastructure_redis_1 redis-cli --rdb /data/dump.rdb
docker cp infrastructure_redis_1:/data/dump.rdb "$BACKUP_DIR/redis_dump.rdb"

echo "✅ Backup completed: $BACKUP_DIR"
