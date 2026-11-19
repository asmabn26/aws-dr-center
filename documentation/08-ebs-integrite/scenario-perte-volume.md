\# Scénario de perte du volume EBS — J9



\## Scénario



Le volume EBS contenant les données témoins est détaché accidentellement de l’instance EC2.



\## Impact



\- Le dossier `/data/pfa-ebs` devient vide ou inaccessible.

\- Les fichiers témoins ne sont plus disponibles.

\- Le service ou l’application qui dépend de ces données peut être impacté.



\## Méthode de vérification



\- Vérifier le montage avec `lsblk`.

\- Vérifier le point de montage avec `df -h`.

\- Vérifier les fichiers avec `ls -lh /data/pfa-ebs/jeu-donnees-temoin`.

\- Vérifier l’intégrité avec `sha256sum -c SHA256SUMS.txt`.



\## Méthode de reprise



\- Rattacher le volume EBS à l’instance.

\- Remonter le volume.

\- Vérifier les fichiers.

\- Comparer les hash SHA256.

