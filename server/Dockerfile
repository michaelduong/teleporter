#FROM alfg/nginx-rtmp
FROM tiangolo/nginx-rtmp

# Add user and group first to ensure IDs get assigned consistently
#RUN groupadd -r app && useradd -r -g app app
# when launching docker through docker run, use:
# docker run \
#   -u app \

# Copy configuration
# COPY ./tools/config/nginx/nginx.conf /etc/nginx/nginx.conf

# COPY ./dist /var/www/html
# WORKDIR /etc/nginx

# RUN chown -R www-data:www-data /var/www/html

# CMD nginx

# Setup ports to be used by app
EXPOSE 1935
EXPOSE 80
