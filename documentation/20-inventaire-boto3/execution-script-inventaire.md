\# Exécution du script d’inventaire Boto3 — J21



\## Objectif



Exécuter un script Python Boto3 afin d’inventorier les ressources AWS Backup du projet.



\## Commandes utilisées



\### Installation



```bash

python -m venv .venv

.venv\\Scripts\\activate

pip install boto3 botocore



Profil Asma

python scripts/inventory/aws\_backup\_inventory.py --profile asma-pfa

Profil Ikram

python scripts/inventory/aws\_backup\_inventory.py --profile ikram-pfa

Fichiers générés

Fichier	Rôle

reports/inventory/aws\_backup\_inventory\_\*.json	Rapport complet

reports/inventory/aws\_backup\_jobs\_\*.csv	Liste des jobs Backup

reports/inventory/aws\_recovery\_points\_\*.csv	Liste des recovery points

logs/aws\_backup\_inventory.log	Logs d’exécution

Résultat attendu



Le script doit lister les coffres, plans, jobs et recovery points pour la région principale et la région DR.



Conclusion



Le script est validé s’il produit les rapports JSON/CSV et s’il gère correctement les erreurs de permission.

