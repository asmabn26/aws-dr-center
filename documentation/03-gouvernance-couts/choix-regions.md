# Choix des régions AWS

## Région réellement utilisée dans le laboratoire

| Rôle | Région | Code |
|---|---|---|
| Région principale réelle | Europe — Paris | `eu-west-3` |

## Architecture cible

| Rôle | Région | Code |
|---|---|---|
| Région principale cible | Europe — Paris | `eu-west-3` |
| Région secondaire cible | Europe — Stockholm | `eu-north-1` |

## Décision

La région réellement utilisée par Asma pour le laboratoire est `eu-west-3`.

Le projet conserve le Free account plan. Aucune mise à niveau vers un plan payant ne doit être effectuée sans validation du binôme.

La copie interrégionale vers `eu-north-1` reste prévue dans l’architecture cible. Elle sera testée uniquement si la région secondaire est accessible sans changement de plan.