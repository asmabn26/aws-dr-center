# Sécurisation du compte AWS

## Compte root

- MFA activée : Oui
- Clé d’accès root présente : Non
- Utilisation quotidienne du compte root : Interdite
- Informations de récupération vérifiées : Oui

## Identités du projet

| Identité | Méthode | MFA | Accès |
|---|---|---|---|
| Asma | IAM | Activée | Console AWS |
| Ikram | IAM | Activée | Console AWS |

## Groupe

`pfa-drp-team`

## Permission initiale

`PFA-Project-Administrator`

Cette permission administrative est temporaire. Elle sera remplacée
progressivement par des permissions respectant le principe du moindre
privilège.

## Règles de sécurité

- Ne jamais partager les mots de passe.
- Ne jamais utiliser le compte root quotidiennement.
- Ne jamais créer de clé d’accès root.
- Ne jamais publier des identifiants AWS dans GitHub.
- Activer la MFA pour toutes les identités humaines.
- Utiliser des identités distinctes pour Asma et Ikram.
- Auditer régulièrement les permissions.
