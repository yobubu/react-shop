FROM node:10

RUN mkdir -p /srv/app/bgshop
WORKDIR /srv/app/bgshop

COPY package.json /srv/app/bgshop
COPY yarn.lock /srv/app/bgshop

RUN yarn install
COPY ./ /srv/app/bgshop
RUN yarn build
EXPOSE 3000
CMD yarn start
