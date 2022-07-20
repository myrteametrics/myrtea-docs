# Myrtea - Système de permission V2

Voir [internals/security/permissions/permission.go](internals/security/permissions/permission.go)

## Format d'une permission

Une permission se compose de trois paramètres `<resource_type> <resource_id> <action>` :

* `resource_type` : Type de ressource
* `resource_id` : Identifiant de la resource
* `action` : Action possible sur la resource

Exemples :

| resource_type | resource_id              | action   | resultat                                                                       |
| ---           | ---                      | ---      | ---                                                                            |
| `*`           | `*`                      | `*`      | Tous les droits, sur l'ensemble des ressources de tous les types               |
| `situation`   | `*`                      | `*`      | Tous les droits sur l'ensemble des situation                                   |
| `situation`   | `3`                      | `*`      | Tous les droits sur la situation 3                                             |
| `situation`   | `3`                      | `get`    | Droit en lecture sur la situation 3                                            |
| `situation`   | `*`                      | `get`    | Droit en lecture sur l'ensemble des situations                                 |
| `*`           | `*`                      | `get`    | Droit en lecture sur l'ensemble des ressources de tous les types               |

| resource_type | resource_id              | action   | resultat                                                                       |
| ---           | ---                      | ---      | ---                                                                            |
| `frontend`    | `settings`               | `access` | Spécifique au frontend, donnant la possibilité d'accéder à la resource `settings` (contenant l'ensemble du paramétrage métier) |
| `frontend`    | `supervision.perimetre1` | `access` | Spécifique au frontend, donnant la possibilité d'accéder à la resource `perimetre1`, contenu dans la resource `supervision`    |

## Type de ressources

* `*` : Tous les types de resources

### Types de ressources backend

* `user`
* `role`
* `permission`
* `model`
* `fact`
* `situation`
* `situation_instance`
* `situation_fact`
* `situation_rule`
* `situation_issue`
* `rule`
* `scheduler`
* `calendar`

### Types de ressources frontend

* `frontend` : Ressource spécifique pour les composants frontend

## ID

* `*` : Toutes les resources (du type associé)

### ID des ressources backend

* `1`, `2` : Identifiant unique de la ressource

### ID des ressources frontend

Les ressources frontend sont gérées dans la majorité des cas commes des resources hiérarchiques, un accès vers une ressource donne par défaut accès à tous les "sous-ressources" qu'elle contient.

| resource_id | Description |
| --- | --- |
| `user-settings`| Acces aux préférences utilisateurs |
| `settings`| Acces à l'ensemble des écrans de paramétrages métiers |
| ~~`settings.situation`~~ | ~~Acces à l'écran de paramétrage situation~~ (Not implemented, yet) |
| `administration`| Acces au paramétrage administrateur (utilisateurs, roles et permissions) |
| `supervision`| Acces "custom" à la resource "supervision" (ainsi qu'à tout ses sous-éléments) |
| `supervision.perimetre1`| Acces "custom" à la resource "perimetre1", contenue dans la resource "supervision" (ainsi qu'à tout ses sous-éléments) |
| `supervision.perimetre1.onglet3`| Acces "custom" à la resource "onglet3", contenue dans la resource "perimetre1", contenue dans la resource "supervision" (ainsi qu'à tout ses sous-éléments) |

## Action

* `*` : Toutes les actions

### Actions backend

| resource_id | Description |
| --- | --- |
| `list` | Récupération d'une liste d'objets, action utilisée en complément de (`get` `<id>` `<type>`) |
| `get` | Récupération d'un objet spécifique |
| `create` | Création d'un objet |
| `update` | Mise à jour d'un objet |
| `delete` | Suppression d'un objet |
| `search` | Recherche sur une situation |

### Actions frontend

* `access` : Acces à une ressource web (en complément du type `frontend`)
