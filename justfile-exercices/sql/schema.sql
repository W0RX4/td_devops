-- Tables de base (just db-tables)

CREATE TABLE IF NOT EXISTS clients (
    id       SERIAL PRIMARY KEY,
    nom      VARCHAR(100) NOT NULL,
    email    VARCHAR(255) NOT NULL UNIQUE,
    cree_le  TIMESTAMP    NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS produits (
    id    SERIAL PRIMARY KEY,
    nom   VARCHAR(100)  NOT NULL UNIQUE,
    prix  NUMERIC(10,2) NOT NULL CHECK (prix >= 0)
);

CREATE TABLE IF NOT EXISTS commandes (
    id          SERIAL PRIMARY KEY,
    client_id   INTEGER   NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
    produit_id  INTEGER   NOT NULL REFERENCES produits(id),
    quantite    INTEGER   NOT NULL CHECK (quantite > 0),
    passee_le   TIMESTAMP NOT NULL DEFAULT now()
);
