-- Nouvelle table + clé étrangère + migration des données existantes
CREATE TABLE categories (
    id   SERIAL PRIMARY KEY,
    nom  VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO categories (nom) VALUES ('Périphériques'), ('Affichage');

ALTER TABLE produits ADD COLUMN categorie_id INTEGER REFERENCES categories(id);

UPDATE produits SET categorie_id = (SELECT id FROM categories WHERE nom = 'Périphériques')
WHERE nom IN ('Clavier', 'Souris');
UPDATE produits SET categorie_id = (SELECT id FROM categories WHERE nom = 'Affichage')
WHERE nom = 'Écran';
