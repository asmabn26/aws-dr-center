\# Validation encadrant — Durcissement du coffre J18



\## Configuration proposée



| Élément | Valeur |

|---|---|

| Coffre | `pfa-drp-aws-dev-backup-vault-primary` |

| Mode laboratoire | Governance |

| Rétention minimale | 7 jours |

| Rétention maximale | 30 jours |

| Chiffrement | KMS |

| Suppression recovery point limitée | Oui |

| Suppression coffre limitée | Oui |

| Compliance mode activé | Non |



\## Justification



Le mode Governance est retenu pour le laboratoire afin de tester les protections sans créer un verrouillage irréversible.



\## Décision attendue de l’encadrant



| Question | Réponse |

|---|---|

| La rétention 7/30 jours est-elle acceptable ? | Oui / Non |

| Le mode Governance est-il validé pour le prototype ? | Oui / Non |

| Peut-on tester Compliance mode plus tard ? | Oui / Non |

| Faut-il augmenter la rétention cible dans le rapport ? | Oui / Non |



\## Conclusion



Le verrouillage fort ne sera appliqué qu’après validation explicite.

