\# Critères d’alerte — J19



\## Objectif



Définir les événements AWS Backup à surveiller pour le projet AWS Backup \& DRP.



\## Critères



| Événement | Gravité | Notification |

|---|---|---|

| Backup job FAILED | Critique | Oui |

| Restore job FAILED | Critique | Oui |

| Copy job FAILED | Critique | Oui |

| Backup job COMPLETED | Information | Oui |

| Copy job COMPLETED | Information | Oui |

| Recovery point absent après un test | Critique | Analyse manuelle |



\## Justification



Les échecs de sauvegarde, restauration ou copie DR doivent être signalés immédiatement car ils impactent la capacité de reprise après sinistre.



\## Conclusion



Les alertes J19 couvrent les principaux événements opérationnels du DRP : sauvegarde, restauration, copie interrégionale et suivi des recovery points.

