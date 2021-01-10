# STAGE 1 
# at stage 1, we will build shizz, and store it in build directories
# at stage 2, the original container will close and a new container will be built, that will run a lighter container and serve the app

FROM node:12-alpine AS build

WORKDIR /app

COPY package.json ./

RUN yarn  install

COPY . /app

RUN yarn build

# STAGE 2

FROM nginx:stable-alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
