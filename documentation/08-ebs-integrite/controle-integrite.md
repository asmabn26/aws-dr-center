\# Contrôle d’intégrité — J9



\## Objectif



Vérifier que les fichiers témoins stockés sur le volume EBS ne sont pas modifiés après détachement/rattachement.



\## Fichiers témoins



\- `client-data.txt`

\- `app-config.txt`

\- `transactions.log`

\- `random-sample.bin`

\- `SHA256SUMS.txt`



\## Commande de génération des hash



```bash

sha256sum \* > SHA256SUMS.txt

