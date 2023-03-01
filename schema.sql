/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT,
    name VARCHAR(50),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL (3,2),
    PRIMARY KEY (id)
);

ALTER TABLE animals ADD species varchar(150);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(150),
    age INT
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150)
);

CREATE SEQUENCE IF NOT EXISTS animals_id_seq;
SELECT SETVAL('animals_id_seq',(SELECT max(id) FROM animals));
ALTER TABLE animals
ALTER COLUMN id
SET DEFAULT nextval('animals_id_seq'::regclass);
ALTER SEQUENCE animals_id_seq OWNED BY animals.id;

