FROM nginx:alpine

# Copy custom nginx config if you have one
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built assets from build stage
COPY --from=build /app/dist/angular-17-crud /usr/share/nginx/html

# Expose the port (can be overridden with --build-arg)
ARG NGINX_PORT=80
ENV PORT=$NGINX_PORT
EXPOSE $PORT

CMD ["nginx", "-g", "daemon off;"]