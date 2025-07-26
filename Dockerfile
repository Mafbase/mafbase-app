# Stage 1 - Install dependencies and build the app in a build environment
ARG REGISTRY_HOST
FROM instrumentisto/flutter:3.29.2-androidsdk34-r0 as build-env

RUN mkdir /app/
COPY . /app/
WORKDIR /app/

RUN flutter build web --release

# Stage 2 - Create the run-time image
FROM nginx:1.21.1-alpine
EXPOSE 80

# Copy the built application from the build environment
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Copy the custom NGINX configuration file
COPY nginx.conf /etc/nginx/nginx.conf