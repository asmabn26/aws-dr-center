# Classification des actifs

## Échelle de criticité

| Niveau | Signification |
|---|---|
| Faible | La perte de l’actif ne bloque pas le service et peut être corrigée facilement. |
| Moyenne | La perte provoque une perturbation limitée, sans interruption complète du service. |
| Haute | La perte interrompt une fonction importante ou complique fortement la reprise. |
| Critique | La perte bloque le service ou rend la reprise impossible sans restauration. |

## Classification retenue

| Actif | Criticité | Justification |
|---|---|---|
| Amazon EC2 | Haute | L’instance héberge l’application. Sa perte interrompt le service, mais elle peut être recréée avec Terraform. |
| Amazon EBS | Critique | Le volume contient les fichiers et données applicatives. Sa perte peut empêcher le fonctionnement du service. |
| Amazon S3 | Haute | Le bucket contient des documents, rapports et preuves nécessaires au projet. |
| Amazon RDS | Critique | La base contient les données structurées utilisées par l’application. |
| Backup Vault principal | Critique | Il contient les points de récupération nécessaires aux restaurations locales. |
| Backup Vault secondaire | Critique | Il permet la reprise après une indisponibilité de la région principale. |
| Terraform | Haute | Il permet de reconstruire rapidement l’infrastructure AWS. |
| GitHub | Haute | Il contient le code Terraform, les scripts et la documentation versionnée. |
| IAM / IAM Identity Center | Critique | Une mauvaise configuration peut empêcher l’accès ou exposer les ressources. |
| AWS KMS | Critique | Les clés permettent de chiffrer et déchiffrer les données et sauvegardes. |
| CloudWatch / EventBridge / SNS | Moyenne | Leur perte limite la supervision et les notifications, sans bloquer immédiatement le service. |
| AWS CloudTrail | Haute | Il assure la traçabilité des actions et fournit les preuves d’audit. |
| Documentation DRP et runbooks | Haute | Elle guide les opérations de restauration et la reprise après sinistre. |

## Règle de validation

La criticité d’un actif est validée lorsque :

1. l’impact de sa perte est expliqué ;
2. ses dépendances sont identifiées ;
3. une stratégie de sauvegarde ou de reconstruction existe ;
4. Asma et Ikram valident ensemble la classification.
