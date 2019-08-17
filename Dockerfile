FROM node:10.16.0-alpine

RUN mkdir -p /srv/app/bgshop-api
WORKDIR /srv/app/bgshop-api

COPY package.json /srv/app/bgshop-api

ADD . /srv/app/bgshop-api
RUN yarn install
EXPOSE 2370
CMD yarn start
