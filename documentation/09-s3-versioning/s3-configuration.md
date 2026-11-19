\# Configuration S3 — J10



\## Objectif



Créer un bucket S3 sécurisé avec Terraform pour stocker des fichiers de test utilisés dans le projet AWS Backup \& DRP.



\## Ressources Terraform



| Ressource | Rôle |

|---|---|

| `aws\_s3\_bucket.drp\_data` | Bucket principal |

| `aws\_s3\_bucket\_public\_access\_block.drp\_data` | Blocage d’accès public |

| `aws\_s3\_bucket\_ownership\_controls.drp\_data` | Contrôle de propriété |

| `aws\_s3\_bucket\_versioning.drp\_data` | Activation du versioning |

| `aws\_s3\_bucket\_server\_side\_encryption\_configuration.drp\_data` | Chiffrement côté serveur |

| `aws\_s3\_bucket\_lifecycle\_configuration.drp\_data` | Cycle de vie des anciennes versions |



\## Configuration



| Élément | Valeur |

|---|---|

| Région | `eu-west-3` |

| Versioning | Activé |

| Chiffrement | AES256 |

| Accès public | Bloqué |

| Lifecycle | Suppression des anciennes versions après 30 jours |

| Tags | Projet, environnement, owner, criticité |



\## Conclusion



Le bucket S3 est sécurisé et prêt pour les tests de versioning et de restauration d’objets.

