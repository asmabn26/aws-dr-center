\# Fiche de traçabilité CloudTrail — J20



\## Objectif



Relier chaque action de test à une preuve CloudTrail exploitable.



\## Matrice de traçabilité



| ID | Scénario | Profil | Événement CloudTrail | Date/heure | Résultat | Preuve |

|---|---|---|---|---|---|---|

| AUD-01 | Lister les coffres AWS Backup | `asma-pfa` | `ListBackupVaults` | À compléter | Succès | À compléter |

| AUD-02 | Lire les instances EC2 | `asma-pfa` | `DescribeInstances` | À compléter | Succès | À compléter |

| AUD-03 | Tentative création VPC interdite | `ikram-pfa` | `CreateVpc` | À compléter | Refus | À compléter |

| AUD-04 | Tentative suppression coffre interdite | `ikram-pfa` | `DeleteBackupVault` | À compléter | Refus | À compléter |

| AUD-05 | Lancement d’un backup | `asma-pfa` | `StartBackupJob` | À compléter | Succès | À compléter |

| AUD-06 | Recherche désactivation CloudTrail | `asma-pfa` | `StopLogging` / `DeleteTrail` | À compléter | Aucun événement | À compléter |



\## Conclusion



La traçabilité est validée si chaque scénario possède une preuve CloudTrail associée.

