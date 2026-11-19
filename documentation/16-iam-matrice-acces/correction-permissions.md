\# Correction des permissions IAM — J17



\## Objectif



Corriger les politiques IAM sans redonner de privilèges excessifs.



\## Problèmes observés



| Problème | Cause | Correction |

|---|---|---|

| Accès trop large | Politique AWS managed trop permissive | Remplacer par politique personnalisée |

| Test négatif réussi au lieu d’être refusé | Utilisateur possède encore une politique large | Détacher la politique excessive |

| Action légitime refusée | Permission minimale manquante | Ajouter uniquement l’action nécessaire |

| Erreur `iam:PassRole` | Rôle AWS Backup non passable | Ajouter `iam:PassRole` limité à `backup.amazonaws.com` |



\## Règle appliquée



Ne jamais corriger une erreur en donnant `AdministratorAccess`.



\## Conclusion



Les permissions sont corrigées selon le principe du moindre privilège.

