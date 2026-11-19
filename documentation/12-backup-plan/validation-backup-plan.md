\# Validation du Backup Plan — J13



\## Responsable



Ikram



\## Contrôles réalisés



| Contrôle | Résultat |

|---|---|

| Backup Plan créé | Oui |

| Règle quotidienne présente | Oui |

| Règle hebdomadaire présente | Oui |

| Coffre cible correct | Oui |

| Rétention quotidienne courte | Oui |

| Rétention hebdomadaire configurée | Oui |

| Sélection par tag `backup=daily` | Oui |

| Ressources taguées vérifiées | Oui |

| Pas de remplacement dangereux Terraform | Oui |



\## Commandes utilisées



```bash

aws backup list-backup-plans

aws backup get-backup-plan --backup-plan-id BACKUP\_PLAN\_ID

aws backup list-backup-selections --backup-plan-id BACKUP\_PLAN\_ID

aws backup get-backup-selection --backup-plan-id BACKUP\_PLAN\_ID --selection-id SELECTION\_ID

