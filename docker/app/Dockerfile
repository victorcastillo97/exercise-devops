FROM node:12.22.1-alpine3.11 as base

WORKDIR /app

COPY app /app/

FROM base as test

RUN npm install

CMD [ "npm", "run", "test" ]

FROM base as prod

RUN npm install --production

HEALTHCHECK --interval=3s --timeout=5s \
  CMD node /app/config/healthcheck.js

CMD [ "node", "/app/server.js" ]
