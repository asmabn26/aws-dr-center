\# Validation sécurité EC2 — J8



\## Responsable



Asma



\## Vérification du Security Group EC2



| Contrôle | Résultat |

|---|---|

| SSH ouvert uniquement sur l’IP admin `/32` | Oui |

| SSH ouvert à `0.0.0.0/0` | Non |

| Port 80 ouvert à Internet | Non |

| Port 443 ouvert à Internet | Non |

| Port 3389 ouvert | Non |

| Règle All traffic entrante | Non |

| Sortie autorisée | Oui |

| RDS accessible depuis Internet | Non |



\## Vérification Terraform



| Élément | Résultat |

|---|---|

| EC2 créée par Terraform | Oui |

| Key Pair créée par Terraform | Oui |

| Clé privée absente de GitHub | Oui |

| `terraform.tfvars` absent de GitHub | Oui |

| Aucune Elastic IP créée | Oui |

| Aucun NAT Gateway créé | Oui |

| Aucun RDS créé | Oui |

| Aucun AWS Backup lancé | Oui |



\## Validation du plan



\- Plan Terraform relu : Oui

\- SSH limité à une seule IP : Oui

\- Ports inutiles fermés : Oui

\- Ressource coûteuse inutile détectée : Non



\## Tests observés



\- Connexion SSH réussie : Oui

\- Utilisateur `ec2-user` confirmé : Oui

\- IP privée observée : `10.10.1.10`

\- Service `pfa-demo.service` actif : Oui

\- Test `curl http://localhost:8080` réussi : Oui

\- Instance arrêtée après les tests : Oui



\## Informations EC2



| Élément | Valeur |

|---|---|

| Région | `eu-west-3` |

| Instance ID | `i-0353f82e44533c6c3` |

| IP publique testée | `13.38.92.103` |

| IP privée | `10.10.1.10` |

| VPC | `vpc-012056b38e554cabf` |

| Security Group EC2 | `sg-0516405df481ceb74` |



\## Conclusion



\- EC2 sécurisée : Oui

\- Autorisation pour `terraform apply` : Oui

\- Corrections demandées :

&#x20; - Aucune

