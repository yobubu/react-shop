FROM mongo

COPY . /

CMD mongoimport --uri "mongodb://sammy:dummy@mongo:27017/test?authSource=admin" --collection users --type json --file /admin.json && \
    mongoimport --uri "mongodb://sammy:dummy@mongo:27017/test?authSource=admin" --collection games --type json --file /games.json