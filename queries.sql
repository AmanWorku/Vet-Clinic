/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN 'Jan 1, 2016' AND 'Jan 1, 2020';
SELECT * FROM animals WHERE neutered IS TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered IS TRUE;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT (id, name, species) from animals;
ROLLBACK;
SELECT (id, name, species) from animals;

BEGIN;
UPDATE animals SET species = 'digmon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;

BEGIN;
TRUNCATE animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > 'Jan 1, 2022';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;

SELECT COUNT(*) AS "Number of Animals" FROM animals;
SELECT COUNT(*) AS "Number of Animals no escape" FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= 'Jan 1, 1990' AND date_of_birth < 'Jan 1, 2000' GROUP BY species;


SELECT name FROM animals
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name = 'Melody Pond';

SELECT A.name FROM animals A
JOIN species ON species.id = A.species_id
WHERE species.name = 'Pokemon';

SELECT name, full_name FROM animals
RIGHT JOIN owners ON owners.id = animals.owner_id;

SELECT S.name, COUNT(*) "Number of Animals per Species" FROM animals
JOIN species S ON S.id = animals.species_id GROUP BY S.name;

SELECT name, full_name FROM animals
JOIN owners ON owners.id = animals.owner_id WHERE name = 'Digimon' AND full_name = 'Jennifer Orwell';

SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id WHERE escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

SELECT owners.full_name, COUNT(animals.id) AS count FROM animals
JOIN owners ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY count DESC LIMIT 1;


SELECT vets.name, animals.name, visits.date FROM vets 
JOIN visits ON vets.id = visits.id 
JOIN animals ON animals.id = visits.animal_id
WHERE vets.name = 'William Tatcher' 
ORDER BY visits.date DESC LIMIT 1;


SELECT vets.name, species.name FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON species.id = specializations.species_id;

SELECT COUNT(DISTINCT animals.id) AS number_of_animals FROM animals 
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

SELECT animals.name, visits.date FROM animals 
JOIN visits  ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
AND visits.date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name, COUNT(visits.animal_id) as number_of_visits
FROM animals
JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.id ORDER BY number_of_visits
DESC LIMIT 1; 

SELECT animals.name, visits.date
FROM animals
JOIN visits ON animals.id = visits.animal_id
WHERE visits.vet_id IN(SELECT id FROM vets WHERE name = 'Maisy Smith')
ORDER BY visits.date ASC LIMIT 1;

