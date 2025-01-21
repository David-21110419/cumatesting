# Menggunakan image PHP dengan Apache
FROM php:7.4-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    zip \
    unzip

# Install ekstensi PHP yang diperlukan
RUN docker-php-ext-install mysqli pdo_mysql
RUN docker-php-ext-install gd

# Enable mod_rewrite untuk Apache
RUN a2enmod rewrite

# Salin semua file proyek ke folder kerja di Docker
COPY . /var/www/html/

# Buat folder uploaded_img jika belum ada
RUN mkdir -p /var/www/html/uploaded_img

# Beri izin pada folder upload
RUN chmod -R 755 /var/www/html/uploaded_img
RUN chown -R www-data:www-data /var/www/html/

# Configure Apache untuk handle file .htaccess
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf