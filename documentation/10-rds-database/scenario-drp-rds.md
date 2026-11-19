\# Scénario DRP RDS — J11



\## Scénario



Perte, corruption ou indisponibilité de la base RDS principale.



\## Impact



\- Perte temporaire d’accès aux données applicatives.

\- Interruption possible du service dépendant de la base.

\- Risque de perte de données si aucune sauvegarde exploitable n’existe.



\## Preuve préparée au J11



\- Base témoin `pfadrpdb`.

\- Table `donnees\_temoin`.

\- Données de test insérées.

\- Dump SQL généré.

\- Hash SHA256 du dump calculé.



\## Méthode de reprise prévue



\- Sauvegarde RDS avec AWS Backup ou snapshot.

\- Restauration vers une nouvelle instance RDS.

\- Vérification de l’intégrité avec les données témoins.

\- Comparaison du contenu restauré avec les résultats attendus.

