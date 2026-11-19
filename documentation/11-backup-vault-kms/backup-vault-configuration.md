\# Configuration du coffre AWS Backup — J12



\## Objectif



Créer un coffre AWS Backup principal sécurisé pour stocker les futurs points de restauration du projet.



\## Ressources Terraform



| Ressource | Rôle |

|---|---|

| `aws\_backup\_vault.primary` | Coffre AWS Backup principal |

| `aws\_kms\_key.backup` | Clé KMS de chiffrement |

| `aws\_kms\_alias.backup` | Alias de la clé KMS |

| `aws\_iam\_role.aws\_backup` | Rôle utilisé par AWS Backup |

| `aws\_iam\_policy.backup\_vault\_limited\_access` | Politique IAM limitée pour validation |



\## Configuration



| Élément | Valeur |

|---|---|

| Région | `eu-west-3` |

| Coffre | `pfa-drp-aws-dev-backup-vault-primary` |

| Chiffrement | KMS |

| Rotation KMS | Activée |

| Tags | Projet, environnement, owner, criticité |

| Rôle service | AWS Backup Role |



\## Conclusion



Le coffre principal est créé, chiffré et prêt pour les plans de sauvegarde.

