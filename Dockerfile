FROM node:10.16.0-alpine

RUN mkdir -p /srv/app/bgshop
WORKDIR /srv/app/bgshop

COPY package.json /srv/app/bgshop

ADD . /srv/app/bgshop
RUN yarn install
EXPOSE 3000
CMD yarn build
