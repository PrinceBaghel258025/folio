FROM node:20-alpine AS build-stage
WORKDIR /app
COPY package.json  ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=build-stage /app/out .
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]