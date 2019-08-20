FROM node:10.16.0-alpine

RUN mkdir -p /app/bgshop
WORKDIR /app/bgshop

COPY . ./

EXPOSE 3000
CMD ["yarn", "start"]