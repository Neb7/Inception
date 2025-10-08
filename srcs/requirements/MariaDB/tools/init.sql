CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY 'wp_password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';
CREATE USER IF NOT EXISTS 'wp_user'@'localhost' IDENTIFIED BY 'wp_password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'localhost';
FLUSH PRIVILEGES;
--ALTER USER 'root'@'localhost' IDENTIFIED BY 'qwer';
--FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'qwer' USING 'mysql_native_password';
FLUSH PRIVILEGES;

