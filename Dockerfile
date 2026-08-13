FROM nginx:alpine
RUN wget -O /usr/share/nginx/html/index.html \
    https://raw.githubusercontent.com/soy-juandi/recreolab-data/main/index.html
