\# Tests d’accès IAM — J17



\## Responsable



Ikram



\## Objectif



Vérifier que les permissions finales autorisent les actions nécessaires et refusent les actions dangereuses.



\## Tests autorisés



| Test | Commande | Résultat |

|---|---|---|

| Identité IAM | `aws sts get-caller-identity` | Succès |

| Lister coffres Backup | `aws backup list-backup-vaults` | Succès |

| Lister backup jobs | `aws backup list-backup-jobs` | Succès |

| Lister recovery points | `aws backup list-recovery-points-by-backup-vault` | Succès |



\## Tests refusés



| Test | Commande | Résultat attendu | Résultat obtenu |

|---|---|---|---|

| Supprimer coffre Backup | `delete-backup-vault` | Refus | À compléter |

| Créer VPC | `ec2 create-vpc --dry-run` | Refus | À compléter |

| Créer bucket S3 | `s3api create-bucket` | Refus | À compléter |

| Créer utilisateur IAM | `iam create-user` | Refus | À compléter |

| Supprimer recovery point | `delete-recovery-point` | Refus | À compléter |



\## Conclusion



Les tests sont validés si les actions nécessaires sont autorisées et si les actions dangereuses sont refusées.

