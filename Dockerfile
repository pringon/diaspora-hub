FROM node AS builder

WORKDIR /app
COPY . .

RUN npm ci
RUN npm run build

FROM nginx:stable

COPY --from=builder /app/build/ /var/www
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD nginx -g 'daemon off;'
