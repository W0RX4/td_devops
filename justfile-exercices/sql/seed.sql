-- Entités de test (just db-seed)
-- On repart de tables vides pour pouvoir relancer la recette sans doublons.
TRUNCATE commandes, produits, clients RESTART IDENTITY CASCADE;

INSERT INTO clients (nom, email) VALUES
    ('Alice Martin',  'alice@example.com'),
    ('Bob Durand',    'bob@example.com'),
    ('Chloé Bernard', 'chloe@example.com');

INSERT INTO produits (nom, prix) VALUES
    ('Clavier',  49.90),
    ('Souris',   19.90),
    ('Écran',   189.00);

INSERT INTO commandes (client_id, produit_id, quantite) VALUES
    (1, 1, 1),
    (1, 2, 2),
    (2, 3, 1),
    (3, 2, 1);
