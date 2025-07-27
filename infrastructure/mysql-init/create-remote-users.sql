-- Create remote access users for MySQL

-- Root user dengan remote access
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY 'mysql_super_secure_root_2024';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;

-- Application users dengan remote access
CREATE USER IF NOT EXISTS 'remote_user'@'%' IDENTIFIED BY 'remote_secure_password_2024';
GRANT ALL PRIVILEGES ON *.* TO 'remote_user'@'%';

-- Read-only user untuk monitoring
CREATE USER IF NOT EXISTS 'readonly_user'@'%' IDENTIFIED BY 'readonly_password_2024';
GRANT SELECT ON *.* TO 'readonly_user'@'%';

-- Specific database user
CREATE USER IF NOT EXISTS 'app_remote'@'%' IDENTIFIED BY 'app_remote_password_2024';
CREATE DATABASE IF NOT EXISTS remote_app_db;
GRANT ALL PRIVILEGES ON remote_app_db.* TO 'app_remote'@'%';

FLUSH PRIVILEGES;

-- Show created users
SELECT user, host FROM mysql.user WHERE host = '%';