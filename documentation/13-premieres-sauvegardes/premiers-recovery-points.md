\# Premiers points de récupération — J14



\## Objectif



Lancer les premières sauvegardes à la demande et vérifier la création de recovery points dans le coffre AWS Backup principal.



\## Coffre utilisé



`pfa-drp-aws-dev-backup-vault-primary`



\## Résultat des sauvegardes



| Ressource | Type | Job ID | Statut | Recovery point obtenu |

|---|---|---|---|---|

| Volume EBS | EBS | À compléter | COMPLETED / FAILED | Oui / Non |

| Instance EC2 | EC2 | À compléter | COMPLETED / FAILED | Oui / Non |

| Base RDS | RDS | À compléter | COMPLETED / FAILED | Oui / Non |

| Bucket S3 | S3 | À compléter | COMPLETED / FAILED | Oui / Non |



\## Observations



\- Les sauvegardes à la demande ont été lancées avec AWS Backup.

\- Les statuts ont été vérifiés avec `describe-backup-job`.

\- Les recovery points ont été vérifiés dans le coffre principal.



\## Conclusion



Le livrable J14 est validé si au moins les premières sauvegardes critiques génèrent des recovery points exploitables.

