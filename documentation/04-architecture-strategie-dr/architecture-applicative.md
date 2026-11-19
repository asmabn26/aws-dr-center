\# Architecture applicative AWS



\## Objectif



L’objectif est de concevoir une petite application de démonstration

dont les composants seront protégés par AWS Backup.



Le Jour 4 est une étape de conception. Aucune ressource AWS réelle

n’est créée pendant cette étape.



\## Ressources applicatives



| Ressource | Utilisation | Emplacement logique |

|---|---|---|

| Amazon EC2 | Hébergement de l’application de démonstration | Sous-réseau public |

| Amazon EBS | Stockage des fichiers applicatifs | Attaché à EC2 |

| Amazon RDS | Stockage des données structurées | Sous-réseaux privés |

| Amazon S3 | Stockage des documents, rapports et journaux | Hors du VPC |

| Amazon VPC | Isolation réseau de l’infrastructure | Région principale |

| Security Groups | Filtrage des communications | Associés à EC2 et RDS |



\## Services de sauvegarde et de sécurité



| Service | Utilisation |

|---|---|

| AWS Backup | Centralisation des sauvegardes |

| Backup Vault principal | Conservation des recovery points |

| Backup Vault secondaire | Conservation des copies DR |

| IAM | Gestion des identités et des autorisations |

| AWS KMS | Chiffrement des données |

| Amazon CloudWatch | Supervision et métriques |

| Amazon EventBridge | Détection des événements de sauvegarde |

| Amazon SNS | Envoi des notifications |

| AWS CloudTrail | Audit des actions AWS |



\## Architecture professionnelle cible



L’architecture professionnelle cible comprend :



\- une région principale ;

\- une région secondaire ;

\- un coffre de sauvegarde principal ;

\- un coffre DR secondaire ;

\- des copies interrégionales ;

\- une politique de rétention quotidienne, hebdomadaire et mensuelle.



\## Architecture économique du laboratoire



L’architecture réellement testée avec le Free account plan sera limitée à :



\- une région réellement accessible ;

\- une petite instance de démonstration lors des jours pratiques ;

\- un petit volume EBS ;

\- des sauvegardes de courte durée ;

\- aucune copie interrégionale si aucune seconde région gratuite n’est accessible ;

\- aucune NAT Gateway.

