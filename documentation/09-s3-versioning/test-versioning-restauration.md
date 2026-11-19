\# Test versioning et restauration S3 — J10



\## Objectif



Tester la création de plusieurs versions d’un objet S3 et la restauration d’une ancienne version.



\## Fichier testé



`test-data/client-data-s3.txt`



\## Étapes



1\. Création de la version 1.

2\. Upload vers S3.

3\. Modification locale du fichier.

4\. Upload de la version 2.

5\. Liste des versions.

6\. Téléchargement de l’ancienne version.

7\. Restauration de l’ancienne version comme version actuelle.

8\. Vérification du contenu restauré.



\## Résultat attendu



| Test | Résultat |

|---|---|

| Version 1 créée | Oui |

| Version 2 créée | Oui |

| Deux VersionId visibles | Oui |

| Ancienne version récupérée | Oui |

| Restauration réussie | Oui |



\## Conclusion



La restauration d’objet S3 à partir d’une ancienne version est validée.

