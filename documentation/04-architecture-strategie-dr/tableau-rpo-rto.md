\# Tableau RPO et RTO



\## 1. Objectif



Ce document définit les objectifs provisoires de reprise pour les

ressources du projet AWS Backup et DRP.



Ces valeurs seront comparées aux mesures obtenues pendant les futurs

tests pratiques de sauvegarde et de restauration.



\---



\## 2. Définition du RPO



Le RPO, ou Recovery Point Objective, représente la quantité maximale de

données que le projet accepte de perdre après un incident.



Il correspond à la différence entre l’heure de l’incident et l’heure du

dernier point de récupération utilisable.



```text

RPO réel = heure de l’incident - heure du dernier point récupérable

```



\### Exemple



\- Heure de l’incident : 15 h 00

\- Heure de la dernière sauvegarde valide : 12 h 00

\- RPO réel : 3 heures



Dans cet exemple, les données créées entre 12 h 00 et 15 h 00 peuvent être

perdues.



\---



\## 3. Définition du RTO



Le RTO, ou Recovery Time Objective, représente la durée maximale acceptée

pour restaurer une ressource ou remettre le service en fonctionnement.



```text

RTO réel = heure de fin de restauration - heure de début de reprise

```



\### Exemple



\- Début de la reprise : 15 h 10

\- Fin de la restauration : 15 h 50

\- RTO réel : 40 minutes



\---



\## 4. Objectifs provisoires



| Ressource | Priorité | RPO cible | RTO cible | Méthode de restauration |

|---|---|---:|---:|---|

| Infrastructure Terraform | `P1` | 1 h | 30 min | Redéployer le code Terraform |

| Amazon EBS | `P1` | 24 h | 1 h | Restaurer un nouveau volume |

| Amazon RDS | `P1` | 24 h | 2 h | Restaurer une nouvelle instance RDS |

| Amazon EC2 | `P2` | 24 h | 2 h | Recréer EC2 et rattacher le volume EBS |

| Amazon S3 | `P2` | 24 h | 1 h | Restaurer les objets ou les versions |

| CloudTrail | `P2` | 24 h | 2 h | Restaurer ou consulter les journaux conservés |

| CloudWatch | `P3` | 24 h | 4 h | Recréer les alarmes et configurations |

| Documentation | `P2` | 24 h | 1 h | Restaurer depuis GitHub ou le stockage externe |

| Reprise régionale | `P1` | 7 jours pour le laboratoire | 4 h | Restaurer dans la région DR disponible |



\---



\## 5. Justification des objectifs



\### Infrastructure Terraform



L’infrastructure Terraform est classée `P1`, car elle permet de recréer

rapidement le réseau et les composants AWS.



\- RPO cible : 1 heure

\- RTO cible : 30 minutes



Le code est stocké dans GitHub et doit être poussé régulièrement.



\### Amazon EBS



Le volume EBS contient les fichiers applicatifs.



\- RPO cible : 24 heures

\- RTO cible : 1 heure



Une sauvegarde quotidienne limite la perte maximale théorique à une journée.



\### Amazon RDS



RDS contient les données structurées de l’application.



\- RPO cible : 24 heures

\- RTO cible : 2 heures



Le RTO tient compte de la création d’une nouvelle instance RDS et de son

initialisation.



\### Amazon EC2



EC2 peut être recréée avec Terraform ou à partir d’une sauvegarde.



\- RPO cible : 24 heures

\- RTO cible : 2 heures



La priorité est inférieure à RDS et EBS, car les données doivent être

restaurées avant le serveur applicatif.



\### Amazon S3



S3 contient les documents, les rapports et certains journaux.



\- RPO cible : 24 heures

\- RTO cible : 1 heure



La restauration pourra utiliser le versioning ou un recovery point AWS Backup.



\### Reprise régionale



La reprise régionale complète représente le scénario DR le plus important.



\- RPO du laboratoire : jusqu’à 7 jours

\- RTO cible : 4 heures



Le RPO est volontairement plus large dans le laboratoire pour limiter les

coûts et le nombre de copies interrégionales.



\---



\## 6. Tableau de mesure des tests



Ce tableau sera complété pendant les tests réels.



| Test | Ressource | Heure de l’incident | Dernier recovery point | Début de reprise | Fin de restauration | RPO réel | RTO réel | Résultat |

|---|---|---|---|---|---|---|---|---|

| Test 1 | EBS | À compléter | À compléter | À compléter | À compléter | À calculer | À calculer | À compléter |

| Test 2 | RDS | À compléter | À compléter | À compléter | À compléter | À calculer | À calculer | À compléter |

| Test 3 | EC2 | À compléter | À compléter | À compléter | À compléter | À calculer | À calculer | À compléter |

| Test 4 | S3 | À compléter | À compléter | À compléter | À compléter | À calculer | À calculer | À compléter |

| Test 5 | Reprise complète | À compléter | À compléter | À compléter | À compléter | À calculer | À calculer | À compléter |



\---



\## 7. Exemple de calcul pendant un test



\### Données du test



\- Incident simulé : 18 h 00

\- Dernière sauvegarde valide : 17 h 30

\- Début de la restauration : 18 h 10

\- Fin de la restauration : 18 h 45



\### RPO réel



```text

18 h 00 - 17 h 30 = 30 minutes

```



Le RPO réel est donc de 30 minutes.



\### RTO réel



```text

18 h 45 - 18 h 10 = 35 minutes

```



Le RTO réel est donc de 35 minutes.



\---



\## 8. Critères de réussite



| Ressource | Critère |

|---|---|

| Terraform | Infrastructure redéployée en moins de 30 minutes |

| EBS | Volume restauré et lisible en moins d’une heure |

| RDS | Base restaurée et accessible en moins de deux heures |

| EC2 | Instance recréée et application fonctionnelle en moins de deux heures |

| S3 | Objets restaurés et vérifiés en moins d’une heure |

| Reprise complète | Service remis en fonctionnement en moins de quatre heures |



\---



\## 9. Gestion des écarts



Si le RPO ou le RTO réel dépasse l’objectif :



1\. identifier la cause du retard ;

2\. vérifier la durée du job AWS Backup ;

3\. vérifier la taille de la ressource ;

4\. vérifier les permissions IAM ;

5\. vérifier les dépendances réseau ;

6\. vérifier les Security Groups ;

7\. vérifier les étapes manuelles ;

8\. proposer une action corrective ;

9\. mettre à jour la procédure de restauration ;

10\. refaire le test si le budget le permet.



\---



\## 10. Statut actuel



\- Valeurs RPO cibles définies : Oui

\- Valeurs RTO cibles définies : Oui

\- Tests pratiques exécutés : Non

\- Valeurs réelles mesurées : Non

\- Validation finale : À réaliser pendant les tests de restauration

