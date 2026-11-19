\# Stratégie de sauvegarde et de reprise après sinistre



\## 1. Objectif



Cette stratégie définit les ressources à protéger, leur niveau de

priorité, les fréquences de sauvegarde, les durées de conservation

et l’ordre de restauration après un sinistre.



Le projet distingue deux environnements :



\- l’architecture professionnelle cible ;

\- l’architecture économique réellement testée avec le Free account plan.



Aucune copie interrégionale ne sera exécutée si aucune deuxième région

gratuite n’est accessible. Le compte ne doit pas être mis à niveau vers

un plan payant pour réaliser cette démonstration.



\---



\## 2. Ressources à protéger



| Ressource | Donnée protégée | Criticité | Méthode de protection |

|---|---|---|---|

| Amazon EC2 | Configuration et serveur applicatif | Haute | Sauvegarde EC2 avec AWS Backup |

| Amazon EBS | Fichiers applicatifs et données locales | Critique | Sauvegarde du volume EBS |

| Amazon RDS | Données structurées de l’application | Critique | Sauvegarde RDS avec AWS Backup |

| Amazon S3 | Documents, rapports et journaux | Haute | Versioning et sauvegarde S3 |

| Terraform | Code de l’infrastructure | Haute | Versionnement dans GitHub |

| Documentation | DRP, procédures et runbooks | Haute | GitHub et copie externe |

| CloudTrail | Traces des actions AWS | Moyenne | Conservation des journaux |

| CloudWatch | Métriques, alarmes et journaux | Moyenne | Configuration reproductible |



\---



\## 3. Niveaux de priorité



| Priorité | Signification |

|---|---|

| `P1` | Ressource critique à restaurer en premier |

| `P2` | Ressource à restaurer après les composants critiques |

| `P3` | Ressource pouvant attendre la reprise du service principal |



\### Classement des ressources



| Ressource | Priorité | Justification |

|---|---|---|

| Infrastructure Terraform | `P1` | Permet de recréer le réseau et les ressources de base |

| Amazon RDS | `P1` | Contient les données structurées nécessaires à l’application |

| Amazon EBS | `P1` | Contient les fichiers applicatifs et les données locales |

| Amazon EC2 | `P2` | Peut être recréée avec Terraform puis reconnectée aux données |

| Amazon S3 | `P2` | Contient les documents, rapports et journaux |

| CloudTrail | `P2` | Nécessaire pour l’audit et l’analyse de l’incident |

| CloudWatch | `P3` | Important pour la supervision, mais ne bloque pas la reprise initiale |

| Rapports historiques | `P3` | Leur indisponibilité temporaire ne bloque pas l’application |



\---



\## 4. Architecture professionnelle cible



La stratégie professionnelle représente la politique qu’une entreprise

pourrait appliquer dans un environnement de production.



\### Nom logique du plan



`pfa-drp-backup-plan-target`



\### Coffres de sauvegarde



| Coffre | Rôle |

|---|---|

| `pfa-drp-vault-primary` | Conservation des recovery points dans la région principale |

| `pfa-drp-vault-secondary` | Conservation des copies dans la région secondaire |



\### Politique cible



| Règle | Fréquence | Rétention | Copie DR |

|---|---|---:|---|

| `Daily` | Tous les jours | 30 jours | Oui |

| `Weekly` | Chaque semaine | 3 mois | Oui |

| `Monthly` | Chaque mois | 12 mois | Selon la criticité |



\### Principes professionnels



\- Centraliser les sauvegardes avec AWS Backup.

\- Chiffrer les sauvegardes.

\- Séparer le coffre principal du coffre secondaire.

\- Copier les sauvegardes critiques vers une autre région.

\- Contrôler les accès au moyen d’IAM.

\- Journaliser les opérations avec CloudTrail.

\- Superviser les jobs avec CloudWatch et EventBridge.

\- Envoyer les notifications avec SNS.

\- Tester régulièrement les restaurations.

\- Vérifier périodiquement les valeurs RPO et RTO.



\---



\## 5. Architecture économique du laboratoire



Le laboratoire utilise des ressources minimales afin de limiter la

consommation des crédits AWS.



\### Nom logique du plan



`pfa-drp-backup-plan-lab`



\### Politique du laboratoire



| Règle | Fréquence | Rétention réelle |

|---|---|---:|

| `On-demand` | Pendant les tests | 1 à 3 jours |

| `Daily-lab` | Une fois par jour pendant la démonstration | 3 jours |

| `Weekly-lab` | Une seule démonstration | 7 jours |

| `Cross-region-lab` | Une copie uniquement si possible | Durée minimale utile |



\### Règles économiques



\- Utiliser une instance et un volume de petite taille.

\- Utiliser uniquement de petits fichiers de démonstration.

\- Ne pas sauvegarder toutes les ressources du compte.

\- Sélectionner uniquement les ressources appartenant au PFA.

\- Vérifier le budget avant chaque test.

\- Vérifier le budget après chaque test.

\- Supprimer les ressources restaurées après validation.

\- Supprimer les recovery points de démonstration devenus inutiles.

\- Ne pas créer de NAT Gateway.

\- Ne pas créer d’adresse Elastic IP inutile.

\- Ne pas utiliser de clé KMS personnalisée pendant le premier laboratoire.

\- Ne pas effectuer de copie interrégionale si aucune deuxième région gratuite n’est accessible.

\- Ne jamais cliquer sur `Upgrade plan` sans validation commune.



\---



\## 6. Sélection des ressources par tags



AWS Backup utilisera des tags pour sélectionner uniquement les ressources

du projet.



\### Tag principal



```text

backup = daily

```



\### Tags complémentaires



```text

project         = pfa-drp-aws

environment     = dev

owner           = asma-ikram

managed-by      = terraform

criticality     = high

expiration-date = 2026-08-31

```



\### Règles



\- Les tags doivent être ajoutés au moment de la création de la ressource.

\- Les clés doivent rester en minuscules.

\- Les mêmes clés doivent être utilisées dans Terraform et dans la console.

\- Aucun mot de passe ou secret ne doit être placé dans un tag.

\- Le tag `backup=daily` ne doit être appliqué qu’aux ressources réellement protégées.

\- La sélection des ressources doit être vérifiée avant chaque lancement de sauvegarde.



\---



\## 7. Stratégie de copie interrégionale



\### Architecture professionnelle cible



```text

Backup Vault principal

Europe — Paris

eu-west-3

&#x20;       │

&#x20;       │ Copie interrégionale

&#x20;       ▼

Backup Vault secondaire

Europe — Stockholm

eu-north-1

```



Cette architecture représente la cible professionnelle du projet.



\### Architecture pratique du laboratoire



\- Région principale réellement accessible : `À compléter`

\- Deuxième région accessible : `À compléter`

\- Copie interrégionale pratique possible : `Oui / Non`

\- Décision finale : `À compléter`



\### Si une seule région est accessible



La copie interrégionale est conservée dans l’architecture cible, mais elle

ne sera pas exécutée dans le laboratoire gratuit.



Le prototype testera :



\- la création d’une sauvegarde ;

\- la conservation d’un recovery point ;

\- la restauration dans la région accessible ;

\- la validation des données restaurées ;

\- la mesure du RPO et du RTO.



La procédure de copie interrégionale restera documentée sans être exécutée.



\### Si deux régions sont accessibles



Une seule copie de démonstration pourra être réalisée sous les conditions

suivantes :



\- vérifier le budget avant la copie ;

\- utiliser une ressource de taille minimale ;

\- conserver la copie pendant une durée courte ;

\- vérifier le statut du job de copie ;

\- enregistrer une preuve ;

\- supprimer la copie après validation ;

\- vérifier de nouveau le budget.



\---



\## 8. Ordre de reprise après sinistre



\### Étape 1 — Déclarer l’incident



\- Enregistrer l’heure de détection.

\- Identifier la personne ayant signalé l’incident.

\- Décrire les symptômes.

\- Identifier les ressources potentiellement affectées.



\### Étape 2 — Limiter les dégâts



\- Isoler une ressource compromise si nécessaire.

\- Bloquer les accès suspects.

\- Conserver les journaux CloudTrail et CloudWatch.

\- Éviter toute modification pouvant détruire les preuves.



\### Étape 3 — Vérifier les recovery points



\- Ouvrir AWS Backup.

\- Identifier le coffre principal.

\- Vérifier les recovery points disponibles.

\- Sélectionner le dernier point de récupération valide.

\- Vérifier qu’il est antérieur au sinistre.



\### Étape 4 — Recréer l’infrastructure réseau



\- Récupérer le code Terraform depuis GitHub.

\- Vérifier la région cible.

\- Recréer le VPC.

\- Recréer les sous-réseaux.

\- Recréer les tables de routage.

\- Recréer les Security Groups.



\### Étape 5 — Restaurer Amazon RDS



\- Sélectionner le recovery point RDS.

\- Lancer la restauration.

\- Créer une nouvelle instance RDS.

\- Placer RDS dans les sous-réseaux privés.

\- Associer `sg-rds-db`.

\- Vérifier que l’accès public est désactivé.



\### Étape 6 — Restaurer Amazon EBS



\- Sélectionner le recovery point EBS.

\- Restaurer un nouveau volume.

\- Vérifier la zone de disponibilité.

\- Vérifier l’état du volume.

\- Préparer son rattachement à EC2.



\### Étape 7 — Recréer Amazon EC2



\- Recréer l’instance EC2.

\- Placer l’instance dans le sous-réseau public.

\- Associer `sg-ec2-app`.

\- Rattacher le volume EBS restauré.

\- Monter le système de fichiers.

\- Vérifier les fichiers applicatifs.



\### Étape 8 — Restaurer Amazon S3



\- Identifier les objets ou versions nécessaires.

\- Restaurer les objets supprimés ou endommagés.

\- Vérifier les métadonnées et les droits.

\- Contrôler l’intégrité des documents restaurés.



\### Étape 9 — Reconnecter les composants



\- Vérifier la connexion EC2 vers RDS.

\- Vérifier l’accès de l’application au volume EBS.

\- Vérifier l’accès à S3.

\- Vérifier les rôles IAM.

\- Vérifier les règles de sécurité.



\### Étape 10 — Tester l’application



\- Vérifier le démarrage de l’application.

\- Tester l’accès HTTP ou HTTPS.

\- Tester les requêtes vers RDS.

\- Vérifier les fichiers stockés sur EBS.

\- Vérifier les objets S3.



\### Étape 11 — Valider les données



\- Comparer les fichiers restaurés avec les fichiers de référence.

\- Comparer les hashes si nécessaire.

\- Vérifier les enregistrements RDS.

\- Vérifier l’absence de corruption.

\- Faire valider les résultats par Asma et Ikram.



\### Étape 12 — Mesurer la reprise



\- Calculer le RPO réel.

\- Calculer le RTO réel.

\- Comparer les résultats aux objectifs.

\- Documenter tout dépassement.



\### Étape 13 — Remettre le service en fonctionnement



\- Confirmer que tous les tests sont réussis.

\- Autoriser de nouveau l’accès aux utilisatrices.

\- Surveiller les journaux.

\- Informer les responsables de la reprise.



\### Étape 14 — Nettoyer le laboratoire



\- Supprimer les ressources temporaires.

\- Supprimer les restaurations devenues inutiles.

\- Vérifier les volumes non attachés.

\- Vérifier les adresses publiques.

\- Vérifier les recovery points.

\- Contrôler le budget AWS.



\---



\## 9. Responsabilités



| Activité | Responsable principal | Vérification |

|---|---|---|

| Architecture réseau | Asma | Ikram |

| Configuration AWS Backup | Ikram | Asma |

| Définition des RPO/RTO | Ikram | Asma |

| Validation des Security Groups | Asma | Ikram |

| Test de restauration | Ikram | Asma |

| Contrôle des coûts | Ikram | Asma |

| Nettoyage des ressources | Ikram et Asma | Validation commune |



\---



\## 10. Critères de validation



La stratégie sera considérée comme validée lorsque :



\- toutes les ressources critiques possèdent une méthode de protection ;

\- les priorités P1, P2 et P3 sont définies ;

\- le plan professionnel cible est documenté ;

\- le plan économique du laboratoire est documenté ;

\- les durées de rétention sont définies ;

\- les coffres sont nommés ;

\- la limitation du Free account plan est documentée ;

\- l’ordre de restauration est défini ;

\- les valeurs RPO et RTO sont définies ;

\- aucune ressource payante n’a été créée pendant le Jour 4.

