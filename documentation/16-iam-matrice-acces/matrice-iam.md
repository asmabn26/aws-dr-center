\# Matrice IAM finale — J17



\## Objectif



Définir les permissions finales du projet AWS Backup \& DRP selon le principe du moindre privilège.



\## Rôles fonctionnels



| Rôle | Objectif | Droits principaux | Interdictions |

|---|---|---|---|

| Backup Operator | Lancer et suivre les sauvegardes | `backup:StartBackupJob`, `backup:DescribeBackupJob`, lecture des ressources protégées | Suppression de coffres, suppression de recovery points, modification IAM |

| Restore Operator | Lancer et suivre les restaurations | `backup:StartRestoreJob`, `backup:DescribeRestoreJob`, attacher/détacher volume restauré | Suppression de sauvegardes, modification des plans |

| ReadOnly Auditor | Audit et validation | Lecture Backup, EC2, EBS, RDS, S3, KMS | Toute action de création, modification ou suppression |



\## Matrice d’accès



| Action | Backup Operator | Restore Operator | ReadOnly Auditor |

|---|---:|---:|---:|

| Lire coffre Backup | Oui | Oui | Oui |

| Lister recovery points | Oui | Oui | Oui |

| Lancer backup job | Oui | Non | Non |

| Lancer restore job | Non | Oui | Non |

| Lire EC2/EBS/RDS/S3 | Oui | Oui | Oui |

| Attacher volume restauré | Non | Oui | Non |

| Supprimer coffre Backup | Non | Non | Non |

| Supprimer recovery point | Non | Non | Non |

| Créer VPC/EC2/RDS/S3 | Non | Non | Non |

| Modifier IAM/KMS | Non | Non | Non |



\## Conclusion



Les permissions finales limitent les actions selon le rôle opérationnel et réduisent les privilèges excessifs utilisés au début du laboratoire.

