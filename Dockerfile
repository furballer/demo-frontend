
# build stage
FROM node:lts-alpine3.16 as builder

RUN npm install -g pnpm

WORKDIR '/app'

COPY package*.json .

RUN pnpm install

COPY . .

RUN pnpm run build



# run stage
FROM nginx:1.23.3-alpine

COPY --from=builder /app/build /usr/share/nginx/html/

COPY ./nginx.conf /etc/nginx/conf.d/

EXPOSE 7001