# Cadrage du projet

## 1. Titre du projet

**Conception et mise en place d’une solution cloud de sauvegarde et de reprise après sinistre avec AWS Backup**

## 2. Contexte

Les systèmes d’information des entreprises hébergent des données et des services critiques qui peuvent être exposés à plusieurs types d’incidents :

- suppression accidentelle de fichiers ;
- corruption de données ;
- panne d’un serveur ;
- erreur humaine ;
- cyberattaque ;
- ransomware ;
- défaillance matérielle ;
- indisponibilité d’une région cloud.

La perte de ces données peut entraîner une interruption des activités, une baisse de productivité et des conséquences financières importantes.

Il est donc nécessaire de mettre en place une stratégie de sauvegarde et de reprise après sinistre permettant de restaurer les données et les services dans des délais acceptables.

## 3. Problématique

Comment concevoir et mettre en place une solution AWS sécurisée, automatisée et mesurable permettant :

- de sauvegarder les ressources critiques ;
- de protéger les points de récupération ;
- de superviser les opérations de sauvegarde ;
- de restaurer les données après un incident ;
- d’assurer la continuité du service ;
- de respecter des objectifs RPO et RTO définis ?

## 4. Objectif général

L’objectif général du projet est de concevoir et déployer une architecture de sauvegarde et de reprise après sinistre sur AWS.

Cette architecture devra permettre de protéger et restaurer plusieurs types de ressources AWS :

- Amazon EC2 ;
- Amazon EBS ;
- Amazon S3 ;
- Amazon RDS.

## 5. Objectifs spécifiques

Le projet doit permettre de :

1. déployer une infrastructure de démonstration sur AWS ;
2. automatiser la création de l’infrastructure avec Terraform ;
3. centraliser les sauvegardes avec AWS Backup ;
4. créer un coffre de sauvegarde principal ;
5. créer un coffre de sauvegarde dans une région secondaire ;
6. configurer une politique de rétention ;
7. chiffrer les données et les sauvegardes ;
8. appliquer le principe du moindre privilège avec IAM ;
9. superviser les sauvegardes et les restaurations ;
10. envoyer des notifications en cas de succès ou d’échec ;
11. journaliser les actions sensibles avec CloudTrail ;
12. automatiser certaines opérations avec Python et Boto3 ;
13. simuler plusieurs scénarios de sinistre ;
14. mesurer les RPO et RTO réels ;
15. rédiger un plan de reprise après sinistre.

## 6. Résultats attendus

À la fin du projet, les résultats suivants devront être obtenus :

- une infrastructure AWS fonctionnelle ;
- des sauvegardes automatiques et planifiées ;
- un Backup Vault principal sécurisé ;
- un Backup Vault secondaire dans une autre région ;
- une copie interrégionale des sauvegardes ;
- des restaurations testées et validées ;
- des alertes en cas d’échec ;
- un tableau de bord de supervision ;
- une journalisation des actions ;
- des scripts d’automatisation ;
- un tableau des RPO et RTO ;
- un document DRP ;
- des runbooks de restauration ;
- un rapport final ;
- une démonstration fonctionnelle.

## 7. Membres du projet

- **Asma**
- **Ikram**

## 8. Méthode de travail

Le projet sera réalisé selon une méthode pilote/copilote :

- une membre réalise principalement une tâche ;
- l’autre membre vérifie et teste le résultat ;
- les rôles sont régulièrement inversés ;
- chaque fonctionnalité doit être comprise par les deux membres ;
- aucune tâche n’est considérée comme terminée sans preuve et validation.