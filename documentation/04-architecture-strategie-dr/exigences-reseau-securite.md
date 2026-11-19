\# Exigences réseau et sécurité



\## Security Group EC2



Nom logique :



`sg-ec2-app`



\### Règles entrantes prévues



| Protocole | Port | Source | Utilisation |

|---|---:|---|---|

| SSH | 22 | Adresse IP publique temporaire d’Asma ou Ikram | Administration |

| HTTP | 80 | Selon les besoins de la démonstration | Accès à l’application |

| HTTPS | 443 | Selon les besoins de la démonstration | Accès sécurisé |



\### Règles de sécurité



\- Ne jamais autoriser SSH depuis `0.0.0.0/0`.

\- Limiter SSH à une adresse IP connue.

\- Supprimer les règles temporaires après les tests.

\- Ne pas autoriser `All traffic` sans justification.

\- Utiliser HTTPS si l’application est exposée.

\- Vérifier les règles après chaque modification.



\## Security Group RDS



Nom logique :



`sg-rds-db`



\### Règle entrante prévue



| Moteur | Port | Source |

|---|---:|---|

| MySQL | 3306 | `sg-ec2-app` |

| PostgreSQL | 5432 | `sg-ec2-app` |



Un seul port sera conservé selon le moteur choisi pendant

l’implémentation.



\## Principes RDS



\- RDS ne doit pas être publiquement accessible.

\- RDS accepte uniquement les connexions provenant de `sg-ec2-app`.

\- Aucun accès direct depuis Internet n’est autorisé.

\- Les mots de passe de base de données ne doivent jamais être placés dans GitHub.



\## Flux autorisés



```text

Asma / Ikram

&#x20;     │

&#x20;     │ SSH, HTTP ou HTTPS

&#x20;     ▼

&#x20;    EC2

&#x20;     │

&#x20;     ├── Lecture et écriture ──► EBS

&#x20;     ├── Requêtes SQL ─────────► RDS

&#x20;     └── Rapports et fichiers ─► S3

