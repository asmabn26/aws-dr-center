\# Plan d’adressage



\## Réseau principal



| Composant | CIDR | Type | Zone logique | Fonction |

|---|---|---|---|---|

| VPC | `10.10.0.0/16` | Réseau principal | Région principale | Contient l’infrastructure |

| Public Subnet A | `10.10.1.0/24` | Public | AZ A | Instance EC2 |

| Private Subnet A | `10.10.10.0/24` | Privé | AZ A | Base RDS |

| Private Subnet B | `10.10.20.0/24` | Privé | AZ B | DB Subnet Group RDS |

| Reserved Subnet | `10.10.30.0/24` | Réservé | AZ B | Extension éventuelle |



\## Table de routage publique



| Destination | Cible |

|---|---|

| `10.10.0.0/16` | Local |

| `0.0.0.0/0` | Internet Gateway |



\## Table de routage privée



| Destination | Cible |

|---|---|

| `10.10.0.0/16` | Local |



\## Principes



\- EC2 est placée dans le sous-réseau public.

\- RDS est placée dans les sous-réseaux privés.

\- RDS ne possède pas d’adresse publique.

\- Deux sous-réseaux privés sont prévus dans deux zones de disponibilité.

\- Aucun NAT Gateway n’est utilisé dans la version économique.

\- Le sous-réseau réservé reste vide pendant le premier prototype.

