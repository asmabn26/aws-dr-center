# Description des données à protéger

## 1. Amazon EC2 — Serveur applicatif

L’instance Amazon EC2 héberge le serveur Linux utilisé pour la démonstration du projet.

### Données et éléments à protéger

- la configuration du système Linux ;
- les paquets et dépendances installés ;
- la configuration réseau de l’instance ;
- l’application de démonstration ;
- les scripts d’installation et de démarrage ;
- les scripts d’administration ;
- les fichiers de configuration de l’application ;
- les journaux système et applicatifs ;
- les fichiers temporaires nécessaires aux tests.

### Exemple de structure

```text
/opt/pfa-app/
├── app/
├── config/
├── scripts/
└── logs/
```

### Justification

La perte de l’instance EC2 interrompt l’accès à l’application. Cependant, l’instance peut être recréée avec Terraform si les données et les configurations sont sauvegardées.

---

## 2. Amazon EBS — Volume de données

Le volume Amazon EBS contient les données utilisées par l’application et les fichiers nécessaires aux scénarios de sauvegarde et de restauration.

### Données à protéger

- les fichiers de test ;
- les fichiers de configuration ;
- les répertoires applicatifs ;
- les rapports générés ;
- les journaux applicatifs ;
- les données produites par l’application ;
- les fichiers utilisés pendant les tests de suppression ou de corruption.

### Exemple de structure

```text
/data/
├── clients_test.csv
├── commandes_test.csv
├── configuration.txt
├── rapports/
└── logs/
```

### Justification

EBS est un actif critique, car il contient les données nécessaires au fonctionnement de l’application. Sa perte ou sa corruption peut rendre le service indisponible.

---

## 3. Amazon S3 — Stockage des documents

Le bucket Amazon S3 contient les documents et les objets utilisés dans le prototype.

### Données à protéger

- les documents PDF ;
- les rapports de tests ;
- les fichiers importés ;
- les journaux exportés ;
- les captures techniques ;
- les fichiers de configuration non sensibles ;
- les résultats produits par les scripts ;
- les objets versionnés.

### Exemple de structure logique

```text
s3://pfa-drp-documents/
├── documents/
├── rapports/
├── logs/
├── imports/
└── tests/
```

### Justification

S3 contient les preuves et documents du projet. La suppression d’un objet peut affecter la traçabilité et les tests. Le versioning et la sauvegarde permettent de restaurer les versions précédentes.

---

## 4. Amazon RDS — Base de données

La base Amazon RDS contient uniquement des données fictives utilisées pour la démonstration.

### Données à protéger

- les clients fictifs ;
- les commandes fictives ;
- les événements fictifs ;
- les incidents fictifs ;
- les données nécessaires aux tests de restauration ;
- la structure des tables ;
- les contraintes et relations entre les tables.

### Exemple de tables

```text
clients_test
commandes_test
incidents_test
evenements_test
```

### Justification

RDS est un actif critique, car la perte ou la corruption de la base peut bloquer l’application et empêcher l’accès aux données structurées.

---

## 5. Règle importante

Aucune donnée personnelle réelle ne doit être utilisée dans le prototype. Toutes les données doivent être fictives et créées uniquement pour les tests du PFA.
