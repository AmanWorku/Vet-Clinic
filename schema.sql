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

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals
    ADD COLUMN IF NOT EXISTS species_id INT;

ALTER TABLE animals
    ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals
    ADD COLUMN IF NOT EXISTS owner_id INT;
    
ALTER TABLE animals
    ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
id SERIAL PRIMARY KEY,
name VARCHAR(150),
age INT,
date_of_graduation DATE);

CREATE TABLE sepecializations (
species_id INT REFERENCES species(id),
vet_id INT REFERENCES vets(id),
PRIMARY KEY(species_id,vet_id));

CREATE TABLE visits (
animal_id INT REFERENCES animals(id),
vet_id INT REFERENCES vets(id), date DATE,
PRIMARY KEY(animal_id,vet_id));
