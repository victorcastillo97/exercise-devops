FROM postgres:13.8

EXPOSE 5432

COPY /app/config/init.sql /docker-entrypoint-initdb.d/init.sql
