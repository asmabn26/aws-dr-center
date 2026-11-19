\# Configuration de la région DR — J16



\## Objectif



Ajouter une région secondaire pour renforcer la résilience du projet AWS Backup \& DRP.



\## Régions



| Rôle | Région | Code |

|---|---|---|

| Région principale | Europe Paris | `eu-west-3` |

| Région DR | Europe Stockholm | `eu-north-1` |



\## Ressources créées en région DR



| Ressource | Rôle |

|---|---|

| `aws\_kms\_key.backup\_dr` | Clé KMS pour chiffrer les copies |

| `aws\_kms\_alias.backup\_dr` | Alias de la clé KMS |

| `aws\_backup\_vault.dr` | Coffre AWS Backup secondaire |



\## Coûts et rétention



La rétention des copies DR est fixée à 7 jours afin de limiter les coûts du laboratoire.



\## Conclusion



La région DR est préparée avec un coffre chiffré et tagué.

