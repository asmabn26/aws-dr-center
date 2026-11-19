# Conventions de tags AWS

## Objectif

Les tags permettent d’identifier les ressources du projet, de suivre
les coûts, de sélectionner les ressources à sauvegarder et de faciliter
leur suppression.

## Tags obligatoires

| Clé | Valeur autorisée | Exemple |
|---|---|---|
| `project` | Nom du projet | `pfa-drp-aws` |
| `environment` | `dev`, `test` ou `dr` | `dev` |
| `owner` | Responsable | `asma-ikram` |
| `managed-by` | Outil de gestion | `terraform` |
| `backup` | `daily`, `weekly` ou `none` | `daily` |
| `criticality` | `low`, `medium`, `high`, `critical` | `critical` |
| `expiration-date` | Date de suppression | `2026-08-31` |

## Exemple pour une instance EC2

| Clé | Valeur |
|---|---|
| `project` | `pfa-drp-aws` |
| `environment` | `dev` |
| `owner` | `asma-ikram` |
| `managed-by` | `terraform` |
| `backup` | `daily` |
| `criticality` | `high` |
| `expiration-date` | `2026-08-31` |

## Règles

- Utiliser uniquement des minuscules.
- Séparer les mots avec des tirets.
- Ne jamais placer de donnée sensible dans un tag.
- Ajouter les tags au moment de la création de la ressource.
- Vérifier les tags avant de lancer un plan de sauvegarde.
- Utiliser les mêmes clés dans Terraform et dans la console AWS.
