FROM nginx:alpine

# COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY ./dist/angular-17-crud/browser /usr/share/nginx/html

# Expose the port (can be overridden with --build-arg)
ARG NGINX_PORT=4200
ENV PORT=$NGINX_PORT
EXPOSE $PORT

CMD ["nginx", "-g", "daemon off;"]