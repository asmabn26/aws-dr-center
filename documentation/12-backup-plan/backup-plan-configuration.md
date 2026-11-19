\# Configuration du Backup Plan — J13



\## Objectif



L’objectif du J13 est de créer un Backup Plan AWS Backup actif afin de protéger automatiquement les ressources critiques du projet PFA AWS Backup \& DRP.



Ce plan utilise le coffre sécurisé créé au J12 :



`pfa-drp-aws-dev-backup-vault-primary`



Le Backup Plan permet de centraliser les sauvegardes des ressources AWS sélectionnées par tags.



\## Ressources Terraform créées



| Ressource Terraform | Rôle |

|---|---|

| `aws\_backup\_plan.main` | Plan principal de sauvegarde AWS Backup |

| `aws\_backup\_selection.tagged\_resources` | Sélection automatique des ressources par tag |

| `aws\_backup\_vault.primary` | Coffre principal utilisé comme destination |

| `aws\_iam\_role.aws\_backup` | Rôle IAM utilisé par AWS Backup |

| `aws\_kms\_key.backup` | Clé KMS utilisée pour le chiffrement du coffre |



\## Nom du Backup Plan



```text

pfa-drp-aws-dev-backup-plan-main

