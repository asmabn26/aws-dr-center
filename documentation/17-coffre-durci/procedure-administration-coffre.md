\# Procédure d’administration sécurisée du coffre — J18



\## Objectif



Définir les règles d’administration du coffre AWS Backup principal.



\## Coffre concerné



`pfa-drp-aws-dev-backup-vault-primary`



\## Règles d’administration



1\. Ne pas supprimer un recovery point sans validation.

2\. Ne pas modifier la politique de rétention sans accord du binôme.

3\. Ne pas désactiver la clé KMS.

4\. Ne pas modifier le rôle AWS Backup sans test préalable.

5\. Ne pas activer Compliance mode sans validation de l’encadrant.

6\. Ne pas utiliser le compte root pour gérer les sauvegardes.

7\. Utiliser des rôles IAM limités.

8\. Documenter toute erreur ou refus d’accès.

9\. Capturer les preuves des tests.

10\. Vérifier Billing après les tests de sauvegarde/restauration.



\## Procédure de modification contrôlée



| Étape | Action |

|---|---|

| 1 | Décrire le changement demandé |

| 2 | Vérifier l’impact sur les sauvegardes existantes |

| 3 | Vérifier l’impact sur les coûts |

| 4 | Exécuter `terraform plan` |

| 5 | Valider avec le binôme |

| 6 | Appliquer avec `terraform apply` si le plan ne détruit rien |

| 7 | Tester lecture, sauvegarde et restauration |

| 8 | Documenter le résultat |



\## Commandes de contrôle



```bash

aws backup describe-backup-vault --backup-vault-name pfa-drp-aws-dev-backup-vault-primary

aws backup list-recovery-points-by-backup-vault --backup-vault-name pfa-drp-aws-dev-backup-vault-primary

aws kms describe-key --key-id alias/pfa-drp-aws-dev-backup





