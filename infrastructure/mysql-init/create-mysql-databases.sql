CREATE DATABASE IF NOT EXISTS npm_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 

-- Create users for MySQL applications
CREATE USER IF NOT EXISTS 'npm_user'@'%' IDENTIFIED BY 'npm_password_2024'; 

-- Grant permissions
GRANT ALL PRIVILEGES ON npm_db.* TO 'npm_user'@'%';
GRANT ALL PRIVILEGES ON your_app_db.* TO 'your_app_user'@'%';

FLUSH PRIVILEGES;
