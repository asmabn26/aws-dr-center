\# Validation de la copie DR — J16



\## Contrôles réalisés



| Contrôle | Responsable | Résultat |

|---|---|---|

| Région DR accessible | Asma | Oui / Non |

| KMS DR créé | Asma | Oui / Non |

| Coffre DR créé | Ikram | Oui / Non |

| Règle de copie ajoutée | Ikram | Oui / Non |

| Copy job lancé | Ikram | Oui / Non |

| Copy job suivi | Ikram | Oui / Non |

| Recovery point DR vérifié | Asma + Ikram | Oui / Non |

| Coûts/rétention vérifiés | Asma | Oui / Non |



\## Cohérence source vers DR



| Élément | Valeur |

|---|---|

| Région source | `eu-west-3` |

| Coffre source | `pfa-drp-aws-dev-backup-vault-primary` |

| Région DR | `eu-north-1` |

| Coffre DR | `pfa-drp-aws-dev-backup-vault-dr` |

| Ressource copiée | EBS / EC2 / RDS / S3 |

| CopyJobId | À compléter |

| Statut final | COMPLETED / FAILED |

| Recovery point DR obtenu | Oui / Non |



\## Conclusion



Le livrable J16 est validé si une copie interrégionale existe dans la région DR.

