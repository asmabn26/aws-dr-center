\# Configuration RDS — J11



\## Objectif



Créer une base de données RDS privée et sécurisée dans le VPC du projet.



\## Ressources Terraform



| Ressource | Rôle |

|---|---|

| `aws\_db\_subnet\_group.rds` | Groupe de subnets privés pour RDS |

| `aws\_db\_instance.main` | Instance RDS principale |



\## Configuration



| Élément | Valeur |

|---|---|

| Région | `eu-west-3` |

| Moteur | MySQL |

| Base | `pfadrpdb` |

| Public access | Désactivé |

| Multi-AZ | Désactivé pour le laboratoire |

| Chiffrement | Activé |

| Subnets | Privés |

| Security Group | Autorise uniquement EC2 vers RDS |

| Port | 3306 |



\## Conclusion



La base RDS est privée, chiffrée et accessible uniquement depuis l’instance EC2.

