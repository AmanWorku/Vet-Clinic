/* Populate database with sample data. */

INSERT INTO animals VALUES (1,'Agumon', 'Feb 3, 2020', 0, TRUE, 10.23);
INSERT INTO animals VALUES (2,'Gabumon', 'Nov 15, 2018', 2, TRUE, 8);
INSERT INTO animals VALUES (3,'Pikachu', 'Jan 7, 2021', 1, FALSE, 15.04);
INSERT INTO animals VALUES (4,'Devimon', 'May 12, 2017', 5, TRUE, 11);
INSERT INTO animals VALUES (5,'Charmander', 'Feb 8, 2020', 0, FALSE, -11);
INSERT INTO animals VALUES (6,'Plantmon', 'Nov 15, 2021', 2, TRUE, -5.7);
INSERT INTO animals VALUES (7,'Squirtle', 'Apr 2, 1993', 3, FALSE, -12.13);
INSERT INTO animals VALUES (8,'Angemon', 'Jul 12, 2005', 1, TRUE, -45);
INSERT INTO animals VALUES (9,'Boarmon', 'Jun 7, 2005', 7, TRUE, 20.4);
INSERT INTO animals VALUES (10,'Blossom', 'Oct 13, 1998', 3, TRUE, 17);
INSERT INTO animals VALUES (11,'Ditto', 'May 14, 2022', 4, TRUE, 22);

INSERT INTO owners (full_name, age) VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES ('Pokemon'),('Digimon');

UPDATE animals SET species_id =
CASE WHEN name LIKE '%mon' then (SELECT id FROM species WHERE name = 'Digimon')
ELSE (SELECT id FROM species WHERE name = 'Pokemon') END;

UPDATE animals SET owner_id = CASE
    WHEN name = 'Agumon' then (SELECT id FROM owners WHERE full_name = 'Sam Smith')
    WHEN name = 'Gabumon' OR name = 'Pikachu' then (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
    WHEN name = 'Devimon' OR name = 'Plantmon' then (SELECT id FROM owners WHERE full_name = 'Bob')
    WHEN name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom' then (SELECT id FROM owners WHERE full_name = 'Melody Pond')
    WHEN name = 'Boarmon' OR name = 'Angemon' then (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
END;