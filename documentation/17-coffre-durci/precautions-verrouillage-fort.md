\# Précautions avant verrouillage fort — J18



\## Objectif



Définir les précautions à respecter avant d’activer un verrouillage fort du coffre AWS Backup.



\## Mode utilisé en laboratoire



Le laboratoire utilise un verrouillage de type Governance afin de démontrer la protection du coffre sans bloquer définitivement l’environnement.



\## Pourquoi ne pas activer directement Compliance mode ?



Le mode Compliance est conçu pour empêcher la suppression ou la modification des sauvegardes jusqu’à la fin de leur rétention. Il peut devenir irréversible après la période de grâce. Il ne doit donc pas être activé sans validation formelle.



\## Points à valider avant Compliance mode



\- Validation de l’encadrant.

\- Validation de la durée minimale de rétention.

\- Validation de la durée maximale de rétention.

\- Vérification des coûts.

\- Vérification que les recovery points existants sont corrects.

\- Vérification des permissions IAM.

\- Vérification de la clé KMS.

\- Vérification de la procédure de restauration.

\- Existence d’une procédure de suppression contrôlée en laboratoire.

\- Confirmation que le coffre n’a plus besoin d’être supprimé rapidement.



\## Conclusion



Le verrouillage fort doit être appliqué uniquement après validation, car il peut empêcher la suppression ou la modification des sauvegardes pendant la durée de rétention.

