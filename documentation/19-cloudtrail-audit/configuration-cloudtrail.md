\# Configuration CloudTrail — J20



\## Objectif



Configurer CloudTrail afin de tracer les actions importantes du projet AWS Backup \& DRP.



\## Ressources créées



| Ressource | Rôle |

|---|---|

| `aws\_cloudtrail.audit` | Journalisation des événements AWS |

| `aws\_s3\_bucket.cloudtrail\_logs` | Stockage des logs CloudTrail |

| `aws\_s3\_bucket\_policy.cloudtrail\_logs` | Autorisation d’écriture CloudTrail |

| `aws\_s3\_bucket\_public\_access\_block.cloudtrail\_logs` | Blocage accès public |

| `aws\_s3\_bucket\_versioning.cloudtrail\_logs` | Versioning des logs |

| `aws\_s3\_bucket\_lifecycle\_configuration.cloudtrail\_logs` | Rétention des logs |



\## Configuration



| Élément | Valeur |

|---|---|

| Région principale | `eu-west-3` |

| Multi-région | Oui |

| Log file validation | Activée |

| Bucket public | Non |

| Chiffrement S3 | AES256 |

| Rétention laboratoire | 30 jours |



\## Conclusion



CloudTrail permet de conserver un journal d’audit exploitable pour les actions critiques du projet.

