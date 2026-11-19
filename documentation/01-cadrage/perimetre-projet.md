# Périmètre du projet

## 1. Périmètre inclus

Le prototype comprendra les éléments suivants.

### Infrastructure

- un VPC ;
- un sous-réseau public ;
- un sous-réseau privé ;
- une Internet Gateway ;
- des tables de routage ;
- des Security Groups ;
- une instance EC2 ;
- un volume EBS ;
- un bucket S3 ;
- une base RDS.

### Sauvegarde

- AWS Backup ;
- Backup Vault principal ;
- Backup Vault secondaire ;
- plan de sauvegarde ;
- règle quotidienne ;
- règle hebdomadaire ;
- politique de rétention ;
- affectation des ressources ;
- copie interrégionale ;
- points de récupération.

### Sécurité

- MFA ;
- identités distinctes pour Asma et Ikram ;
- rôles et permissions IAM ;
- principe du moindre privilège ;
- chiffrement KMS ;
- blocage de l’accès public S3 ;
- versioning S3 ;
- Security Groups ;
- CloudTrail.

### Supervision

- CloudWatch ;
- EventBridge ;
- SNS ;
- notifications par e-mail ;
- journalisation des opérations.

### Automatisation

- Terraform ;
- AWS CLI ;
- Python ;
- Boto3 ;
- scripts de sauvegarde, restauration et reporting.

### Reprise après sinistre

- définition des RPO et RTO ;
- ordre de restauration ;
- runbooks ;
- scénarios de sinistre ;
- mesure des durées ;
- restauration interrégionale.

## 2. Éléments non prioritaires

Les éléments suivants ne sont pas obligatoires pendant la première version :

- Load Balancer ;
- Auto Scaling ;
- Amazon EKS ;
- Amazon ECS ;
- Route 53 ;
- architecture multi-comptes ;
- application web complexe ;
- réplication active-active ;
- architecture multi-région active ;
- haute disponibilité complète ;
- portail graphique personnalisé.

## 3. Limites du prototype

- les données utilisées seront fictives ;
- le volume des données sera limité ;
- les ressources AWS seront de petite taille ;
- certaines ressources seront créées uniquement pendant les tests ;
- la politique de rétention réelle sera courte pour réduire les coûts ;
- la panne d’une région sera simulée ;
- aucune attaque réelle ne sera réalisée ;
- aucune donnée personnelle réelle ne sera utilisée.

## 4. Politique cible et politique réelle

### Politique cible professionnelle

- sauvegardes quotidiennes conservées 30 jours ;
- sauvegardes hebdomadaires conservées 3 mois ;
- sauvegardes mensuelles conservées 12 mois ;
- copie interrégionale régulière ;
- tests de restauration périodiques.

### Politique appliquée au prototype

- sauvegardes conservées de 3 à 7 jours ;
- une ou deux copies interrégionales ;
- ressources restaurées supprimées après les tests ;
- données de faible volume ;
- surveillance quotidienne des coûts.

## 5. Critères de réussite

Le projet sera considéré comme réussi si :

1. l’infrastructure est déployable ;
2. les sauvegardes sont exécutées ;
3. les points de récupération sont disponibles ;
4. les restaurations sont fonctionnelles ;
5. la copie interrégionale fonctionne ;
6. les alertes sont reçues ;
7. les actions sont journalisées ;
8. les RPO et RTO sont mesurés ;
9. les procédures sont documentées ;
10. Asma et Ikram savent démontrer toutes les parties.