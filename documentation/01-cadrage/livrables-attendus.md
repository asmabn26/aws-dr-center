# Livrables attendus

## 1. Livrables de cadrage

- cahier des charges ;
- planification détaillée ;
- charte de travail du binôme ;
- inventaire des actifs ;
- registre des risques ;
- définition du périmètre ;
- tableau des responsabilités.

## 2. Livrables d’architecture

- architecture globale AWS ;
- architecture de la région principale ;
- architecture de la région secondaire ;
- schéma des flux de sauvegarde ;
- schéma du processus de restauration ;
- schéma du plan de reprise après sinistre.

## 3. Livrables Infrastructure as Code

- fichiers Terraform ;
- fichier `providers.tf` ;
- fichier `variables.tf` ;
- fichier `main.tf` ;
- fichier `outputs.tf` ;
- fichier `terraform.tfvars.example` ;
- modules Terraform si nécessaires ;
- documentation de déploiement ;
- procédure de destruction des ressources.

## 4. Livrables AWS Backup

- Backup Vault principal ;
- Backup Vault secondaire ;
- plan de sauvegarde ;
- règles de sauvegarde ;
- politique de rétention ;
- affectation des ressources ;
- copie interrégionale ;
- points de récupération ;
- preuves des sauvegardes réussies.

## 5. Livrables de sécurité

- MFA activée ;
- deux identités distinctes ;
- rôles et permissions IAM ;
- politique de moindre privilège ;
- chiffrement KMS ;
- blocage de l’accès public S3 ;
- Security Groups restrictifs ;
- audit CloudTrail ;
- convention de tags.

## 6. Livrables de supervision

- tableau de bord CloudWatch ;
- règles EventBridge ;
- topic SNS ;
- notifications par e-mail ;
- alertes de sauvegarde réussie ;
- alertes de sauvegarde échouée ;
- alertes de restauration.

## 7. Livrables d’automatisation

- script de listage des tâches de sauvegarde ;
- script de détection des tâches échouées ;
- script de listage des points de récupération ;
- script de génération de rapport ;
- script de restauration ou assistance à la restauration ;
- fichier `requirements.txt`.

## 8. Livrables DRP

- document de plan de reprise après sinistre ;
- ordre de restauration ;
- runbook de restauration EC2 ;
- runbook de restauration EBS ;
- runbook de restauration S3 ;
- runbook de restauration RDS ;
- runbook de restauration interrégionale ;
- matrice RPO/RTO ;
- procédures de validation.

## 9. Livrables de tests

- scénario de suppression accidentelle ;
- scénario de perte EBS ;
- scénario de perte EC2 ;
- scénario de corruption RDS ;
- scénario de suppression S3 ;
- scénario d’échec d’une sauvegarde ;
- scénario de tentative non autorisée ;
- scénario de perte régionale simulée ;
- rapport de chaque scénario ;
- preuves sous forme de captures et journaux.

## 10. Livrables académiques

- rapport final du PFA ;
- présentation PowerPoint ;
- démonstration fonctionnelle ;
- vidéo de secours ;
- dépôt GitHub documenté ;
- README final.