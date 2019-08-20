FROM node:10.16.0-alpine

RUN mkdir -p /srv/app/bgshop
WORKDIR /srv/app/bgshop

COPY package.json /srv/app/bgshop

RUN yarn install

COPY . ./

EXPOSE 3000
CMD ["yarn", "start"]
