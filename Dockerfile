FROM node:10.16.0-alpine

RUN mkdir -p /srv/app/bgshop
WORKDIR /srv/app/bgshop

COPY package.json /srv/app/bgshop

RUN yarn install

COPY . ./
RUN yarn build
RUN yarn global add serve
EXPOSE 5000
CMD ["serve", "-s", "build"]
