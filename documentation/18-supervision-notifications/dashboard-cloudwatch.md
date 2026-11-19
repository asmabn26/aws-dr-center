\# Dashboard CloudWatch — J19



\## Objectif



Créer un tableau de bord CloudWatch pour suivre l’état des sauvegardes, restaurations, copies DR et recovery points.



\## Indicateurs suivis



| Indicateur | Objectif |

|---|---|

| `NumberOfBackupJobsCompleted` | Suivre les sauvegardes réussies |

| `NumberOfBackupJobsFailed` | Détecter les sauvegardes échouées |

| `NumberOfRestoreJobsCompleted` | Suivre les restaurations réussies |

| `NumberOfRestoreJobsFailed` | Détecter les restaurations échouées |

| `NumberOfCopyJobsCompleted` | Suivre les copies DR réussies |

| `NumberOfCopyJobsFailed` | Détecter les copies DR échouées |

| `NumberOfRecoveryPointsCompleted` | Suivre les points de récupération créés |



\## Conclusion



Le dashboard permet de visualiser rapidement l’état opérationnel du dispositif de sauvegarde et de reprise après sinistre.

