\# Validation J22 — Script restauration EBS semi-automatique



\## Contrôles réalisés



| Contrôle | Résultat |

|---|---|

| Script Python créé | Oui |

| Configuration JSON créée | Oui |

| Dernier recovery point EBS détecté | Oui |

| Mode dry-run fonctionnel | Oui |

| Confirmation obligatoire testée | Oui |

| Restore job lancé après confirmation | Oui / Non |

| Statut suivi jusqu’à la fin | Oui / Non |

| Logs générés | Oui |

| Rapports JSON générés | Oui |

| Tests d’erreurs réalisés | Oui / Non |



\## Résultat du test réel



| Élément | Valeur |

|---|---|

| Recovery point utilisé | À compléter |

| RestoreJobId | À compléter |

| Statut final | COMPLETED / FAILED |

| Volume restauré | À compléter |

| Durée totale | À compléter |



\## Conclusion



Le livrable J22 est validé si le script restaure un volume EBS uniquement après confirmation, suit le statut et produit des logs exploitables.

\## Nettoyage du volume restauré



Après le test de restauration EBS, les restore jobs suivants ont été vérifiés :



| RestoreJobId | Statut | Volume restauré |

|---|---|---|

| `7260df58-b38b-4d64-8cfe-a03e815097b6` | `COMPLETED` | `vol-062be5923271aab49` |

| `da3f42f7-1c2c-4fc5-a0f7-b339300ea219` | `COMPLETED` | `vol-05cadaa3cc66a735e` |



Les commandes `describe-volumes` ont retourné `InvalidVolume.NotFound` pour les deux volumes restaurés. Cela confirme que ces volumes ne sont plus présents dans la région `eu-west-3`.



Le volume original `vol-0eeed11ad5bc73228` n’a pas été supprimé.



Conclusion : le nettoyage post-restauration est validé.

