\# Script restauration EBS semi-automatique — J22



\## Objectif



Créer un script Python/Boto3 capable de restaurer un volume EBS depuis le dernier recovery point AWS Backup disponible.



\## Fonctionnement



1\. Lecture du fichier `config/restore\_ebs\_config.json`.

2\. Connexion au profil AWS choisi.

3\. Liste des recovery points du coffre.

4\. Filtrage des recovery points EBS terminés.

5\. Sélection du plus récent recovery point.

6\. Génération d’un rapport de simulation.

7\. Confirmation humaine avant restauration réelle.

8\. Lancement du restore job via AWS Backup.

9\. Suivi du statut avec `describe\_restore\_job`.

10\. Export du résultat en JSON.



\## Sécurité



Le script ne lance pas de restauration si :



\- aucun recovery point n’est trouvé ;

\- le mode `--dry-run` est utilisé ;

\- l’utilisateur ne tape pas exactement `RESTORE` ;

\- une erreur AWS est détectée.



\## Commandes utilisées



\### Simulation



```bash

python scripts/restore/ebs\_restore\_semiauto.py --profile asma-pfa --dry-run

