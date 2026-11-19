\# Notifications SNS et EventBridge — J19



\## Objectif



Notifier Asma et Ikram lors des événements importants AWS Backup.



\## Composants



| Composant | Rôle |

|---|---|

| SNS Topic | Canal de notification |

| SNS Subscriptions | Abonnements e-mail Asma et Ikram |

| EventBridge Rule `backup-job-failed` | Alerte sur échec backup |

| EventBridge Rule `backup-job-completed` | Notification sur succès backup |

| EventBridge Rule `copy-job-state` | Notification sur copie DR |

| EventBridge Rule `restore-job-state` | Notification sur restauration |



\## Événements surveillés



\- Backup job `COMPLETED`

\- Backup job `FAILED`

\- Backup job `ABORTED`

\- Backup job `EXPIRED`

\- Copy job `COMPLETED` / `FAILED`

\- Restore job `COMPLETED` / `FAILED`



\## Conclusion



Les notifications permettent d’être alerté rapidement en cas d’échec ou de succès d’une opération critique.

