CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY 'wp_password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';
CREATE USER IF NOT EXISTS 'wp_user'@'localhost' IDENTIFIED BY 'wp_password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'localhost';
ALTER USER 'wp_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'wp_password';
ALTER USER 'root'@'localhost' IDENTIFIED BY 'qwer' USING 'mysql_native_password';
FLUSH PRIVILEGES;
