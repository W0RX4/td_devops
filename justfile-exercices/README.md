# DevOps – Exercices justfile

Prérequis : [`just`](https://github.com/casey/just) ≥ 1.17, `git`, et un serveur PostgreSQL local (pour l'exercice 5).
Les recettes multi-lignes utilisent `bash` (Linux, macOS, WSL ou Git Bash sous Windows).

```
.
├── justfile
├── .env.example                 # paramètres de connexion PostgreSQL
├── sql/
│   ├── schema.sql               # tables de base
│   ├── seed.sql                 # entités (données de test)
│   └── drop.sql                 # suppression des tables de base
└── migrations/
    ├── 001_ajout_telephone_clients.up.sql / .down.sql
    └── 002_categories_produits.up.sql     / .down.sql
```

`just` sans argument affiche la liste des recettes.

## Exercice 1 – Hello world

```bash
just hello
```

## Exercice 2 – Initialiser un dépôt et le synchroniser

Créer d'abord un dépôt vide sur GitHub/GitLab, puis :

```bash
just init-repo git@github.com:<utilisateur>/<projet>.git
just sync        # ensuite, pour resynchroniser (pull --rebase + push)
```

`init-repo` fait `git init`, ajoute le distant `origin`, récupère son historique s'il en a déjà un, crée un premier commit si besoin, puis `git push -u origin main`. Elle peut être relancée sans casse.

## Exercice 3 – Workflow git

```bash
just init
just status
# ... modifier des fichiers ...
just add                              # ou : just add fichier1 fichier2
just commit "Ajout de la fonctionnalité"
just log
```

## Exercice 4 – Nettoyage

```bash
just clean-v1    # version 1 : rm tmp.txt   -> erreur si tmp.txt n'existe pas
just clean       # version 2 : rm -f tmp.txt -> jamais d'erreur
```

Autre solution possible : préfixer la ligne par `-` (`-rm tmp.txt`), ce qui dit à `just` d'ignorer l'échec de la commande (le message d'erreur de `rm` s'affiche quand même).

## Exercice 5 – Base SQL (PostgreSQL)

Copier `.env.example` en `.env` et l'adapter (nom de la base, utilisateur, mot de passe…).

| Étape | Recette |
|---|---|
| Création de la base | `just db-create` |
| Insertion des tables | `just db-tables` |
| Insertion des entités | `just db-seed` |
| Migration de la base | `just db-migrate` |
| Annuler la dernière migration | `just db-rollback` |
| Downgrade vers une base vide | `just db-downgrade` |
| Tout d'un coup (création → migrations) | `just db-setup` |
| Voir l'état | `just db-status` |
| Supprimer la base | `just db-drop` |

Fonctionnement des migrations : chaque fichier `NNN_nom.up.sql` a son inverse `NNN_nom.down.sql`. Les versions appliquées sont enregistrées dans la table `schema_migrations`, donc `db-migrate` n'applique que les nouvelles. Chaque migration tourne dans une transaction : si elle échoue, rien n'est appliqué.
`db-downgrade` annule les migrations de la plus récente à la plus ancienne, supprime les tables de base, puis vérifie qu'il reste 0 table. Elle demande une confirmation (`just --yes db-downgrade` pour la passer).

Démo complète :

```bash
just db-setup
just db-status
just db-downgrade
just db-status
```
