\# Validation IAM/KMS — J12



\## Responsable



Asma



\## Contrôles réalisés



| Contrôle | Résultat |

|---|---|

| Rôle AWS Backup créé | Oui |

| Trust policy vers `backup.amazonaws.com` | Oui |

| Politique AWS Backup attachée | Oui |

| Clé KMS créée | Oui |

| Rotation KMS activée | Oui |

| Alias KMS créé | Oui |

| Coffre chiffré avec KMS | Oui |

| Suppression du coffre refusée au rôle limité | Oui / Non |



\## Conclusion



La configuration IAM/KMS est validée si AWS Backup peut utiliser le rôle et si le coffre utilise la clé KMS prévue.

