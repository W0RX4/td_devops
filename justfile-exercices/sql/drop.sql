-- Supprime les tables de base et la table de suivi des migrations
-- (utilisé par just db-downgrade, après l'annulation des migrations)
DROP TABLE IF EXISTS commandes, produits, clients, schema_migrations CASCADE;
