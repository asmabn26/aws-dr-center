\# Tests du coffre AWS Backup — J12



\## Responsable



Ikram



\## Objectif



Tester le coffre principal AWS Backup avec lecture, écriture et refus d’action non autorisée.



\## Tests réalisés



| Test | Commande | Résultat |

|---|---|---|

| Lecture du coffre | `describe-backup-vault` | Succès |

| Vérification KMS | `kms describe-key` | Succès |

| Vérification rôle | `iam get-role` | Succès |

| Écriture backup job | `start-backup-job` | Succès / Échec |

| Refus suppression | `delete-backup-vault` avec profil limité | Refusé / Autorisé |



\## Conclusion



Le coffre est validé s’il accepte les opérations autorisées et refuse les opérations interdites.

