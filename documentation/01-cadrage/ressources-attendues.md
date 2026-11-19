# Ressources et technologies prévues

## 1. Ressources AWS principales

| Catégorie | Service | Utilisation dans le projet |
|---|---|---|
| Calcul | Amazon EC2 | Hébergement du serveur Linux et de l’application de démonstration |
| Stockage bloc | Amazon EBS | Stockage des fichiers et données de l’application |
| Stockage objet | Amazon S3 | Stockage des documents, journaux et rapports |
| Base de données | Amazon RDS | Stockage des données structurées de démonstration |
| Sauvegarde | AWS Backup | Centralisation et automatisation des sauvegardes |
| Coffre | AWS Backup Vault | Conservation sécurisée des points de récupération |
| Chiffrement | AWS KMS | Chiffrement des données et des sauvegardes |
| Identités | IAM / IAM Identity Center | Gestion des utilisateurs, rôles et permissions |
| Supervision | Amazon CloudWatch | Collecte des métriques et création des tableaux de bord |
| Événements | Amazon EventBridge | Détection des événements de sauvegarde et restauration |
| Notifications | Amazon SNS | Envoi de notifications par e-mail |
| Audit | AWS CloudTrail | Journalisation des actions effectuées dans le compte AWS |
| Automatisation | AWS Lambda | Automatisation optionnelle de certaines tâches |

## 2. Outils d’automatisation

| Outil | Utilisation |
|---|---|
| Terraform | Création reproductible de l’infrastructure AWS |
| AWS CLI | Administration des services AWS en ligne de commande |
| Python | Développement des scripts d’automatisation |
| Boto3 | Interaction entre Python et les services AWS |
| Git | Gestion des versions |
| GitHub | Hébergement du code et de la documentation |

## 3. Outils de documentation

| Outil | Utilisation |
|---|---|
| Markdown | Documentation technique dans GitHub |
| Draw.io | Création des schémas d’architecture |
| Microsoft Word ou LaTeX | Rédaction du rapport |
| Excel ou Google Sheets | Tableaux RPO/RTO, risques et inventaire |
| PowerPoint | Présentation de soutenance |

## 4. Ressources obligatoires du prototype

Les ressources obligatoires sont :

- une instance EC2 Linux ;
- un volume EBS ;
- un bucket S3 ;
- une base RDS de démonstration ;
- un Backup Vault principal ;
- un Backup Vault secondaire ;
- un plan AWS Backup ;
- une politique IAM ;
- une clé KMS ou un chiffrement géré par AWS ;
- une supervision avec CloudWatch ;
- des notifications SNS ;
- un audit CloudTrail ;
- du code Terraform ;
- des scripts Python/Boto3.

## 5. Ressources optionnelles

Les éléments suivants pourront être ajoutés si le temps et le budget le permettent :

- AWS Lambda ;
- AWS Backup Audit Manager ;
- AWS Config ;
- restauration automatisée complète ;
- tableau de bord web personnalisé ;
- architecture multi-comptes ;
- Load Balancer ;
- Auto Scaling.