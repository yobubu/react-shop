FROM node:10.16.0-alpine

RUN mkdir -p /app/bgshop-api

WORKDIR /app/bgshop-api

COPY package.json .
RUN yarn install
COPY . ./
RUN wget https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem -P src/

EXPOSE 2370
CMD yarn start