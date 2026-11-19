\# Requêtes d’audit CloudTrail — J20



\## Objectif



Définir les commandes utilisées pour rechercher les événements sensibles.



\## Requêtes principales



\### Rechercher une tentative de création VPC



```bash

aws cloudtrail lookup-events --lookup-attributes AttributeKey=EventName,AttributeValue=CreateVpc --profile asma-pfa --region eu-west-3 --max-results 10 --output table

```



\### Rechercher une tentative de suppression du coffre



```bash

aws cloudtrail lookup-events --lookup-attributes AttributeKey=EventName,AttributeValue=DeleteBackupVault --profile asma-pfa --region eu-west-3 --max-results 10 --output table

```



\### Rechercher les backups lancés



```bash

aws cloudtrail lookup-events --lookup-attributes AttributeKey=EventName,AttributeValue=StartBackupJob --profile asma-pfa --region eu-west-3 --max-results 10 --output table

```



\### Rechercher les restaurations lancées



```bash

aws cloudtrail lookup-events --lookup-attributes AttributeKey=EventName,AttributeValue=StartRestoreJob --profile asma-pfa --region eu-west-3 --max-results 10 --output table

```



\## Champs importants à vérifier



\- `eventTime`

\- `eventName`

\- `userIdentity`

\- `sourceIPAddress`

\- `awsRegion`

\- `errorCode`

\- `errorMessage`



\## Conclusion



Ces requêtes permettent de retrouver les événements sensibles et de les relier aux scénarios de test.

