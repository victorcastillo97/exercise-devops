DROP DATABASE IF EXISTS devops;

CREATE DATABASE devops;

\c devops;

CREATE TABLE Results(
    sumando01 integer NOT NULL,
    sumando02 integer NOT NULL,
    resultado integer NOT NULL
);