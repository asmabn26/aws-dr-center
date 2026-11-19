\# Analyse RPO et rétention — J13



\## Objectif



Définir le RPO théorique du laboratoire et comparer la politique cible avec la politique réellement appliquée.



\## Définition du RPO



Le RPO représente la perte maximale de données acceptable en cas d’incident.



Dans notre laboratoire :



\- Sauvegarde quotidienne = RPO théorique maximum de 24 heures.

\- Sauvegarde hebdomadaire = RPO théorique maximum de 7 jours.



\## RPO théorique par ressource



| Ressource | Fréquence | RPO théorique | Rétention labo |

|---|---|---:|---:|

| EBS | Quotidienne | 24 h | 7 jours |

| EC2 | Quotidienne | 24 h | 7 jours |

| RDS | Quotidienne | 24 h | 7 jours |

| S3 | Quotidienne / versioning | 24 h | 7 jours |

| Sauvegarde hebdomadaire | Hebdomadaire | 7 jours | 30 jours |



\## Politique cible vs politique laboratoire



| Élément | Politique cible professionnelle | Politique laboratoire |

|---|---|---|

| Sauvegarde quotidienne | Oui | Oui |

| Sauvegarde hebdomadaire | Oui | Oui |

| Rétention quotidienne | 30 jours | 7 jours |

| Rétention hebdomadaire | 3 mois ou plus | 30 jours |

| Copie interrégionale | Oui | Non, reportée pour limiter les coûts |

| Chiffrement | KMS | KMS |

| Sélection ressources | Tags + criticité | Tag `backup=daily` |

| Tests restauration | Réguliers | Test manuel prévu |



\## Justification



La politique laboratoire utilise une rétention courte afin de limiter les coûts AWS pendant le PFA.  

Elle reste suffisante pour démontrer le fonctionnement d’AWS Backup : planification, coffre chiffré, sélection automatique par tag et création de points de restauration.



\## Conclusion



Le RPO théorique du laboratoire est de 24 heures pour les ressources taguées `backup=daily`.  

La règle hebdomadaire sert de point de restauration plus long, avec une rétention de 30 jours.

