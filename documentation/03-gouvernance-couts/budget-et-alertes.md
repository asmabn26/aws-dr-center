\# Budget et alertes AWS



\## Budget du projet



| Élément | Valeur |

|---|---|

| Nom | `PFA-DRP-Monthly-Budget` |

| Période | Mensuelle |

| Renouvellement | Automatique |

| Montant maximal interne | 20 USD |

| Services suivis | Tous les services AWS |

| Responsable principal | Ikram |

| Copilote | Asma |



\## Alertes



| Seuil | Type | Destinataires |

|---:|---|---|

| 1 USD | Coût réel | Asma et Ikram |

| 5 USD | Coût réel | Asma et Ikram |

| 10 USD | Coût réel | Asma et Ikram |

| 80 % du budget | Coût prévisionnel | Asma et Ikram |

| 100 % du budget | Coût réel | Asma et Ikram |



\## Interprétation



Pour un budget mensuel de 20 USD :



\- 80 % correspond à 16 USD ;

\- 100 % correspond à 20 USD ;

\- les alertes sont uniquement informatives ;

\- aucune suppression automatique de ressource n'est configurée.



\## Règles



\- Vérifier le coût à la fin de chaque séance.

\- Ne pas laisser une instance EC2 active inutilement.

\- Supprimer les volumes temporaires non attachés.

\- Supprimer les restaurations après les tests.

\- Vérifier les deux régions AWS.

\- Documenter toute dépense inhabituelle.

\- Une alerte ne remplace pas le nettoyage manuel.

\- Ne jamais cliquer sur `Upgrade plan` sans validation du binôme.

