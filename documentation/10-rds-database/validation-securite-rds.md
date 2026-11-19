\# Validation sécurité RDS — J11



\## Responsable



Asma



\## Contrôles réalisés



| Contrôle | Résultat |

|---|---|

| RDS en subnets privés | Oui / Non |

| PubliclyAccessible = false | Oui / Non |

| Chiffrement activé | Oui / Non |

| Accès 3306 limité au Security Group EC2 | Oui / Non |

| Accès direct depuis Internet interdit | Oui / Non |

| Aucun accès `0.0.0.0/0` vers RDS | Oui / Non |

| Tags projet appliqués | Oui / Non |



\## Conclusion



RDS est considérée sécurisée si elle n’est pas publique et si seul EC2 peut s’y connecter.

