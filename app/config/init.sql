DROP DATABASE IF EXISTS devops;

CREATE DATABASE devops;

\c devops;

CREATE TABLE Results(
    value1 integer NOT NULL,
    value2 integer NOT NULL,
    result integer NOT NULL
);