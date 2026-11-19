\# Test de copie interrégionale — J16



\## Objectif



Lancer une copie de sauvegarde depuis la région principale vers la région DR.



\## Informations du test



| Élément | Valeur |

|---|---|

| Région source | `eu-west-3` |

| Région destination | `eu-north-1` |

| Coffre source | `pfa-drp-aws-dev-backup-vault-primary` |

| Coffre destination | `pfa-drp-aws-dev-backup-vault-dr` |

| Ressource copiée | EBS |

| RecoveryPointArn source | À compléter |

| CopyJobId | À compléter |



\## Résultat



| Contrôle | Résultat |

|---|---|

| Copy job lancé | Oui / Non |

| Copy job terminé | COMPLETED / FAILED |

| Recovery point visible en région DR | Oui / Non |

| Rétention DR configurée | Oui / Non |

| KMS DR utilisé | Oui / Non |



\## Conclusion



La copie interrégionale est validée si un recovery point apparaît dans le coffre DR.

