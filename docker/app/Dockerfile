FROM node:12.22.1-alpine3.11

WORKDIR /app

COPY app /app/

RUN npm install

CMD ["node", "/app/server.js"]