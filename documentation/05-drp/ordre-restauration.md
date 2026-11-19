# Ordre de restauration du plan de reprise après sinistre

## Objectif

Définir l’ordre à suivre pour restaurer les ressources après un incident majeur.

## Ordre de restauration retenu

### 1. Vérifier et déclarer l’incident

- identifier le type d’incident ;
- déterminer les ressources touchées ;
- noter l’heure de début ;
- conserver les journaux et les preuves ;
- décider si le DRP doit être activé.

### 2. Vérifier les points de récupération

- ouvrir AWS Backup ;
- vérifier les derniers recovery points disponibles ;
- contrôler leur date, leur statut et leur région ;
- sélectionner le point compatible avec le RPO cible.

### 3. Recréer l’infrastructure réseau

- restaurer ou recréer le VPC ;
- recréer les sous-réseaux ;
- recréer les tables de routage ;
- recréer les Security Groups ;
- vérifier les rôles et permissions IAM ;
- utiliser Terraform lorsque cela est possible.

### 4. Restaurer Amazon RDS

- sélectionner le point de récupération RDS ;
- restaurer une nouvelle instance de base de données ;
- vérifier le réseau et le Security Group ;
- tester la connexion ;
- vérifier les tables et les données.

### 5. Restaurer le volume Amazon EBS

- sélectionner le recovery point EBS ;
- créer un nouveau volume ;
- vérifier la zone de disponibilité ;
- vérifier le chiffrement ;
- contrôler le statut du volume.

### 6. Recréer l’instance Amazon EC2

- recréer l’instance avec Terraform ou depuis une configuration documentée ;
- utiliser la même région et le même sous-réseau ;
- appliquer le Security Group ;
- associer le rôle IAM nécessaire.

### 7. Rattacher le volume EBS restauré

- attacher le volume à l’instance EC2 ;
- monter le système de fichiers ;
- vérifier les fichiers ;
- contrôler les droits d’accès ;
- comparer les hashes lorsque cela est prévu.

### 8. Restaurer les données Amazon S3

- restaurer les objets supprimés ou corrompus ;
- vérifier le versioning ;
- contrôler les permissions ;
- vérifier les documents et les rapports.

### 9. Tester l’application

- démarrer les services ;
- vérifier la connexion à RDS ;
- vérifier l’accès aux fichiers EBS ;
- vérifier l’accès aux objets S3 ;
- réaliser un test fonctionnel ;
- vérifier les journaux.

### 10. Remettre le service en fonctionnement

- confirmer que le RTO est respecté ;
- confirmer que le RPO est respecté ;
- informer les responsables ;
- conserver les preuves ;
- rédiger le rapport d’incident ;
- supprimer les ressources temporaires devenues inutiles.

## Résumé

```text
Incident
   ↓
Vérification des recovery points
   ↓
Reconstruction du réseau
   ↓
Restauration RDS
   ↓
Restauration EBS
   ↓
Recréation EC2
   ↓
Rattachement EBS
   ↓
Restauration S3
   ↓
Tests
   ↓
Remise en service
```
