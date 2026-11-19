\# Validation J14 — Premières sauvegardes



\## Contrôles réalisés



| Contrôle | Résultat |

|---|---|

| Coffre AWS Backup accessible | Oui |

| Rôle AWS Backup utilisé | Oui |

| Sauvegarde EBS lancée | Oui / Non |

| Sauvegarde EC2 lancée | Oui / Non |

| Sauvegarde RDS lancée | Oui / Non |

| Sauvegarde S3 testée | Oui / Non |

| Jobs suivis dans la console | Oui / Non |

| Recovery points visibles | Oui / Non |

| Erreurs analysées | Oui / Non |

| Fiche incident créée si nécessaire | Oui / Non |



\## Preuves collectées



| Preuve | Fichier |

|---|---|

| Liste des backup jobs | `backup-jobs-j14.json` |

| Liste des recovery points | `recovery-points-j14.json` |

| Capture jobs AWS Backup | `J14\_Backup\_Jobs\_List.png` |

| Capture recovery points | `J14\_Recovery\_Points\_OK.png` |



\## Conclusion



J14 est validé si les premiers recovery points sont visibles dans le coffre AWS Backup principal.

