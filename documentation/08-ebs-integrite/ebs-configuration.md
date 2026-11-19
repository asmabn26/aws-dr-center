# Configuration EBS — J9

## Objectif

Créer un volume EBS de données, l’attacher à l’instance EC2 et l’utiliser comme espace de stockage persistant.

## Ressources créées

| Ressource | Rôle |
|---|---|
| `aws_ebs_volume.data` | Volume de données |
| `aws_volume_attachment.data` | Attachement du volume à l’EC2 |

## Configuration

| Élément | Valeur |
|---|---|
| Région | `eu-west-3` |
| Volume type | `gp3` |
| Taille | `1 GiB` |
| Chiffrement | Activé |
| Point de montage | `/data/pfa-ebs` |
| Fichier fstab | Configuré avec UUID et `nofail` |

## Conclusion

Le volume EBS est attaché, formaté, monté et persistant.