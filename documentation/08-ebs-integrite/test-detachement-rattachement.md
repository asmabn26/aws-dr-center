\# Test de détachement/rattachement EBS — J9



\## Objectif



Tester qu’un volume EBS peut être détaché puis rattaché sans perte de données.



\## Étapes



1\. Démonter le volume dans Linux.

2\. Détacher le volume avec AWS CLI.

3\. Vérifier que le volume est `available`.

4\. Rattacher le volume à l’instance EC2.

5\. Remonter le volume.

6\. Vérifier les fichiers.

7\. Vérifier les hash SHA256.



\## Résultat attendu



\- Le volume est rattaché avec succès.

\- Les fichiers témoins sont toujours présents.

\- Les hash SHA256 sont identiques.

\- Aucune donnée n’est perdue.



\## Conclusion



Le volume EBS conserve les données après détachement/rattachement.

