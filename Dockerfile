FROM nginx:alpine

RUN apk add --no-cache git

WORKDIR /repo
RUN git clone --depth 1 https://github.com/soy-juandi/recreolab-data.git .

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN rm -rf /usr/share/nginx/html && ln -s /repo /usr/share/nginx/html

ENTRYPOINT ["/entrypoint.sh"]
