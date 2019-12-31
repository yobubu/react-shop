FROM node:10.16.0-alpine

RUN mkdir -p /app/bgshop-api
WORKDIR /app/bgshop-api

COPY package.json .
RUN yarn install
COPY . ./

EXPOSE 2370
CMD yarn start
