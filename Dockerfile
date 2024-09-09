#phase 1
FROM node:16-alpine AS builder
USER node
WORKDIR /home/node/app
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./
RUN npm run build

# /app/build <--- contiene todo lo que queremos exponer

#phase 2
FROM nginx
COPY --from=builder /home/node/app/build /user/share/nginx/html
# no tenemos que especificar RUN porque la imagen nginx ya lo hace por nosotros

