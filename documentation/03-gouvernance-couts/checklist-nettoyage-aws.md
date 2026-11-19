\# Checklist de nettoyage AWS



\## Informations de contrôle



\- Date :

\- Membre ayant effectué le contrôle :

\- Région principale vérifiée :

\- Région secondaire vérifiée :

\- Coût affiché :

\- Solde des crédits :

\- Anomalie détectée :



\## Après chaque séance



\### Région principale — Paris `eu-west-3`



\- \[ ] Vérifier les instances EC2

\- \[ ] Arrêter les instances EC2 inutilisées

\- \[ ] Supprimer les instances temporaires

\- \[ ] Vérifier les volumes EBS

\- \[ ] Identifier les volumes EBS non attachés

\- \[ ] Supprimer les volumes temporaires non attachés

\- \[ ] Vérifier les snapshots

\- \[ ] Supprimer les snapshots de test inutiles

\- \[ ] Vérifier les bases RDS

\- \[ ] Arrêter ou supprimer RDS si nécessaire

\- \[ ] Vérifier les adresses IPv4 publiques

\- \[ ] Libérer les adresses inutilisées

\- \[ ] Vérifier les buckets S3

\- \[ ] Supprimer uniquement les fichiers de test devenus inutiles

\- \[ ] Vérifier les clés KMS éventuellement créées

\- \[ ] Vérifier les ressources CloudWatch temporaires



\### AWS Backup



\- \[ ] Vérifier les tâches de sauvegarde

\- \[ ] Vérifier le statut des tâches

\- \[ ] Vérifier les points de récupération

\- \[ ] Identifier les sauvegardes de test inutiles

\- \[ ] Vérifier les périodes de rétention

\- \[ ] Vérifier les tâches de copie

\- \[ ] Vérifier les tâches de restauration

\- \[ ] Supprimer les ressources restaurées temporaires

\- \[ ] Vérifier les deux Backup Vaults

\- \[ ] Vérifier qu'aucune sauvegarde n'est conservée sans raison



\### Région secondaire — Stockholm `eu-north-1`



\- \[ ] Sélectionner la région Stockholm dans la console

\- \[ ] Vérifier le Backup Vault secondaire

\- \[ ] Vérifier les copies interrégionales

\- \[ ] Vérifier les instances EC2 temporaires

\- \[ ] Supprimer les ressources de restauration temporaires

\- \[ ] Vérifier les volumes EBS restaurés

\- \[ ] Supprimer les volumes temporaires inutiles

\- \[ ] Vérifier qu'aucune instance ne reste active

\- \[ ] Vérifier qu'aucune adresse IPv4 publique ne reste allouée



\### Facturation



\- \[ ] Ouvrir Billing and Cost Management

\- \[ ] Vérifier le coût du mois

\- \[ ] Vérifier le détail des services

\- \[ ] Vérifier les crédits restants

\- \[ ] Vérifier le Free account plan

\- \[ ] Vérifier `PFA-DRP-Monthly-Budget`

\- \[ ] Vérifier les cinq alertes

\- \[ ] Noter le coût dans le journal du projet

\- \[ ] Signaler toute dépense inhabituelle à Asma

\- \[ ] Vérifier que le plan n'a pas été mis à niveau



\## Validation



\- \[ ] Nettoyage effectué par Ikram

\- \[ ] Vérification croisée effectuée par Asma

\- \[ ] Coût final enregistré

\- \[ ] Aucune ressource inattendue restante

