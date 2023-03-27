-- Populate tables

INSERT INTO country(id, name) VALUES (1, "Brasil");
INSERT INTO country(id, name) VALUES (2, "Estados Unidos");
INSERT INTO country(id, name) VALUES (3, "Canada");

-- Brasil from Brasil
INSERT INTO city(name, country_id) VALUES ("Belo Horizonte", 1);
INSERT INTO city(name, country_id) VALUES ("Ouro Branco", 1);
INSERT INTO city(name, country_id) VALUES ("Lafaiete", 1);
INSERT INTO city(name, country_id) VALUES ("Uberlandia", 1);

-- Brasil from Estados Unidos
INSERT INTO city(name, country_id) VALUES ("California", 2);
INSERT INTO city(name, country_id) VALUES ("Orlando", 2);
INSERT INTO city(name, country_id) VALUES ("Nova York", 2);
INSERT INTO city(name, country_id) VALUES ("Miami", 2);
