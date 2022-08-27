FROM node:12.22.1-alpine3.11

WORKDIR /app

COPY app /app/

RUN npm install

HEALTHCHECK --interval=3s --timeout=5s \
  CMD node /app/config/healthcheck.js

CMD ["node", "/app/server.js"]