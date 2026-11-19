\# Flux de sauvegarde et de restauration



\## 1. Objectif



Ce document décrit les flux logiques entre les ressources du projet,

AWS Backup, les coffres de sauvegarde, les services de supervision et

les procédures de restauration.



Le Jour 4 est une étape de conception. Aucun job AWS Backup réel ne doit

être lancé pendant cette journée.



\---



\## 2. Acteurs et services



| Élément | Rôle |

|---|---|

| EC2 | Serveur applicatif à protéger |

| EBS | Stockage des fichiers applicatifs |

| RDS | Stockage des données structurées |

| S3 | Stockage des documents et journaux |

| AWS Backup | Orchestration des sauvegardes |

| Backup Plan | Définition des règles de sauvegarde |

| Backup Vault principal | Conservation des recovery points |

| Backup Vault secondaire | Conservation des copies DR |

| EventBridge | Détection des événements AWS Backup |

| SNS | Envoi des notifications |

| CloudWatch | Supervision et métriques |

| CloudTrail | Journalisation des actions |

| IAM | Contrôle des accès |

| KMS | Chiffrement des sauvegardes |



\---



\## 3. Flux de sauvegarde



\### Étapes



1\. La ressource reçoit les tags du projet.

2\. Le tag `backup=daily` indique que la ressource doit être protégée.

3\. AWS Backup identifie la ressource.

4\. Le Backup Plan applique la règle correspondante.

5\. AWS Backup démarre un job de sauvegarde.

6\. Un recovery point est créé.

7\. Le recovery point est enregistré dans le Backup Vault principal.

8\. Le statut du job est transmis à EventBridge.

9\. EventBridge déclenche une notification SNS.

10\. CloudWatch collecte les métriques du job.

11\. CloudTrail journalise les actions réalisées.

12\. Asma et Ikram vérifient le résultat du job.



\### Schéma logique



```text

EC2 ───────┐

EBS ───────┤

RDS ───────┼──────────────► AWS Backup

S3 ────────┘                      │

&#x20;                                 ▼

&#x20;                          Backup Plan

&#x20;                                 │

&#x20;                                 ▼

&#x20;                    Backup Vault principal

&#x20;                                 │

&#x20;                                 ▼

&#x20;                        Recovery Points

```



\### Flux de supervision



```text

AWS Backup ─────────────► EventBridge

EventBridge ────────────► SNS

SNS ────────────────────► Asma et Ikram



AWS Backup ─────────────► CloudWatch

Actions AWS ────────────► CloudTrail

IAM ────────────────────► Contrôle des accès

KMS ────────────────────► Chiffrement

```



\---



\## 4. Flux détaillé par ressource



\### Amazon EC2



```text

EC2

&#x20;│

&#x20;│ Sauvegarde de l’instance

&#x20;▼

AWS Backup

&#x20;│

&#x20;▼

Recovery point EC2

```



La sauvegarde EC2 doit permettre de conserver la configuration nécessaire

à la restauration du serveur applicatif.



\### Amazon EBS



```text

Volume EBS

&#x20;│

&#x20;│ Snapshot géré par AWS Backup

&#x20;▼

AWS Backup

&#x20;│

&#x20;▼

Recovery point EBS

```



Le volume restauré devra être créé dans une zone de disponibilité compatible

avec l’instance EC2.



\### Amazon RDS



```text

Base RDS

&#x20;│

&#x20;│ Sauvegarde RDS

&#x20;▼

AWS Backup

&#x20;│

&#x20;▼

Recovery point RDS

```



La restauration RDS crée généralement une nouvelle instance de base de données.



\### Amazon S3



```text

Bucket S3

&#x20;│

&#x20;│ Sauvegarde ou versioning

&#x20;▼

Recovery point ou version d’objet

```



La stratégie exacte dépendra des fonctionnalités disponibles dans le

Free account plan.



\---



\## 5. Flux de copie interrégionale



\### Architecture professionnelle cible



1\. Un recovery point valide existe dans le coffre principal.

2\. AWS Backup lance un job de copie.

3\. Le recovery point est copié vers la région secondaire.

4\. La copie est enregistrée dans le Backup Vault secondaire.

5\. Le statut du job de copie est vérifié.

6\. EventBridge détecte le résultat.

7\. SNS envoie une notification.

8\. CloudTrail conserve la trace de l’opération.

9\. Une preuve du succès est enregistrée.



\### Schéma logique



```text

Backup Vault principal

Région principale

&#x20;       │

&#x20;       │ Job de copie interrégionale

&#x20;       ▼

Backup Vault secondaire

Région DR

```



\### Limitation du laboratoire



Si aucune deuxième région gratuite n’est accessible :



\- aucune copie interrégionale ne sera lancée ;

\- aucune région verrouillée ne sera activée ;

\- le compte ne sera pas mis à niveau ;

\- la copie restera représentée dans l’architecture cible ;

\- seule la restauration dans la région accessible sera testée.



\---



\## 6. Flux de restauration



\### Étapes générales



1\. Déclarer le sinistre.

2\. Identifier la ressource affectée.

3\. Ouvrir AWS Backup.

4\. Sélectionner le Backup Vault approprié.

5\. Identifier le recovery point valide.

6\. Vérifier la date et l’heure du recovery point.

7\. Vérifier que le recovery point est antérieur à l’incident.

8\. Lancer le job de restauration.

9\. Créer une nouvelle ressource restaurée.

10\. Reconnecter les dépendances réseau.

11\. Associer les Security Groups appropriés.

12\. Tester les données restaurées.

13\. Comparer les hashes si nécessaire.

14\. Tester l’application.

15\. Mesurer le RPO réel.

16\. Mesurer le RTO réel.

17\. Valider la restauration.

18\. Enregistrer les preuves.

19\. Supprimer la ressource temporaire après validation.

20\. Vérifier les coûts.



\### Schéma général



```text

Recovery Point

&#x20;     │

&#x20;     ▼

AWS Backup Restore Job

&#x20;     │

&#x20;     ▼

Ressource restaurée

&#x20;     │

&#x20;     ├── Vérification technique

&#x20;     ├── Vérification réseau

&#x20;     ├── Vérification applicative

&#x20;     ├── Contrôle des données

&#x20;     ├── Mesure du RPO

&#x20;     └── Mesure du RTO

```



\---



\## 7. Flux de restauration EBS



```text

Recovery point EBS

&#x20;       │

&#x20;       ▼

Création d’un nouveau volume EBS

&#x20;       │

&#x20;       ▼

Vérification de la zone de disponibilité

&#x20;       │

&#x20;       ▼

Rattachement à EC2

&#x20;       │

&#x20;       ▼

Montage du système de fichiers

&#x20;       │

&#x20;       ▼

Vérification des fichiers

```



\### Contrôles



\- Le volume doit être disponible.

\- Le volume doit se trouver dans la même zone que l’instance EC2.

\- Le système de fichiers doit être monté.

\- Les fichiers doivent être lisibles.

\- Les hashes peuvent être comparés avec les valeurs de référence.



\---



\## 8. Flux de restauration RDS



```text

Recovery point RDS

&#x20;       │

&#x20;       ▼

Création d’une nouvelle instance RDS

&#x20;       │

&#x20;       ▼

Association au DB Subnet Group

&#x20;       │

&#x20;       ▼

Association à sg-rds-db

&#x20;       │

&#x20;       ▼

Connexion depuis EC2

&#x20;       │

&#x20;       ▼

Validation des données

```



\### Contrôles



\- RDS doit rester dans les sous-réseaux privés.

\- L’accès public doit être désactivé.

\- `sg-rds-db` doit autoriser uniquement `sg-ec2-app`.

\- Les données doivent être accessibles depuis l’application.

\- Les enregistrements de test doivent être présents.



\---



\## 9. Flux de restauration EC2



```text

Infrastructure Terraform

&#x20;       │

&#x20;       ▼

Création de l’instance EC2

&#x20;       │

&#x20;       ▼

Association à sg-ec2-app

&#x20;       │

&#x20;       ▼

Rattachement du volume EBS restauré

&#x20;       │

&#x20;       ▼

Démarrage de l’application

&#x20;       │

&#x20;       ▼

Test HTTP ou HTTPS

```



\### Contrôles



\- EC2 doit être dans le sous-réseau public.

\- Le Security Group doit être correctement associé.

\- SSH ne doit pas être ouvert à `0.0.0.0/0`.

\- Le volume restauré doit être correctement rattaché.

\- L’application doit démarrer.

\- La connexion vers RDS doit fonctionner.



\---



\## 10. Flux de restauration S3



```text

Objet supprimé ou altéré

&#x20;       │

&#x20;       ▼

Identification de la version ou du recovery point

&#x20;       │

&#x20;       ▼

Restauration de l’objet

&#x20;       │

&#x20;       ▼

Vérification du contenu

&#x20;       │

&#x20;       ▼

Validation de l’intégrité

```



\### Contrôles



\- Le nom de l’objet doit être correct.

\- Le contenu doit être lisible.

\- Les métadonnées importantes doivent être vérifiées.

\- Le hash peut être comparé à la valeur initiale.

\- Les permissions d’accès doivent être contrôlées.



\---



\## 11. Notifications



\### Événements à surveiller



\- Job de sauvegarde réussi.

\- Job de sauvegarde échoué.

\- Job de copie réussi.

\- Job de copie échoué.

\- Job de restauration réussi.

\- Job de restauration échoué.



\### Flux de notification



```text

AWS Backup

&#x20;   │

&#x20;   ▼

EventBridge

&#x20;   │

&#x20;   ▼

SNS

&#x20;   │

&#x20;   ├──► E-mail Asma

&#x20;   └──► E-mail Ikram

```



\---



\## 12. Preuves à conserver



Pour chaque test, enregistrer :



\- identifiant ou nom du job ;

\- type de ressource ;

\- heure de début ;

\- heure de fin ;

\- statut du job ;

\- recovery point utilisé ;

\- région utilisée ;

\- résultat du test ;

\- RPO réel ;

\- RTO réel ;

\- capture non sensible ;

\- coût avant le test ;

\- coût après le test.



Ne jamais capturer :



\- mot de passe ;

\- QR code MFA ;

\- Access Key ;

\- Secret Access Key ;

\- token de session ;

\- numéro complet du compte ;

\- données bancaires.



\---



\## 13. Nettoyage après restauration



Après la validation :



1\. arrêter la ressource temporaire si nécessaire ;

2\. supprimer l’instance restaurée devenue inutile ;

3\. supprimer les volumes EBS temporaires non attachés ;

4\. supprimer les copies de test devenues inutiles ;

5\. supprimer les snapshots inutiles ;

6\. vérifier les ressources dans chaque région ;

7\. vérifier les adresses IPv4 publiques ;

8\. vérifier les recovery points ;

9\. vérifier la facture ;

10\. noter le résultat dans le journal du projet.



\---



\## 14. Statut actuel



\- Flux de sauvegarde conçu : Oui

\- Flux de copie DR conçu : Oui

\- Flux de restauration conçu : Oui

\- Jobs AWS Backup lancés : Non

\- Tests pratiques réalisés : Non

\- Captures de jobs réels : Non

\- Validation finale : À réaliser pendant l’implémentation

