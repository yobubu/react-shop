ARG NODE_TAG=10-alpine
ARG NGINX_TAG=stable-alpine

FROM node:${NODE_TAG} as Yarn

RUN mkdir -p /app/bgshop
WORKDIR /app/bgshop
ENTRYPOINT ["yarn"]

COPY package.json yarn.lock ./
RUN yarn
COPY . .

ARG REACT_APP_BASE_URL="https://backend.shop.devops.codes"
ENV REACT_APP_BASE_URL="${REACT_APP_BASE_URL}"

RUN yarn build

FROM nginx:stable-alpine

COPY docker/nginx /etc/nginx
RUN rm -rf /usr/share/nginx/html/*
COPY --from=Yarn /app/bgshop/build /usr/share/nginx/html