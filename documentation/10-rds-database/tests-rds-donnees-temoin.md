\# Tests RDS et données témoins — J11



\## Objectif



Valider que l’instance EC2 peut accéder à RDS et que la base contient des données témoins.



\## Tests réalisés



| Test | Résultat |

|---|---|

| Connexion EC2 vers RDS | Succès / Échec |

| Connexion directe PC vers RDS | Interdite / Autorisée |

| Création table `donnees\_temoin` | Succès / Échec |

| Insertion des données | Succès / Échec |

| Lecture des données | Succès / Échec |

| Dump SQL généré | Succès / Échec |

| Hash SHA256 du dump créé | Succès / Échec |



\## Données témoins



| Client | Service | Criticité |

|---|---|---|

| Client-A | Sauvegarde EBS | high |

| Client-B | Versioning S3 | medium |

| Client-C | DRP AWS | critical |



\## Conclusion



Le livrable J11 est validé si les données témoins sont accessibles depuis EC2 et si RDS reste inaccessible directement depuis Internet.

