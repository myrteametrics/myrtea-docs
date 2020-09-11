# Model settings

A model is used to describe the structure of the data stored in a business application. For most usage, it is mandatory to declare at least one model.

It is composed of the following options :

* Structures and types of all the datas, declared in the form of a tree
* Optional "natural language synonyms" for the assistant system
* Advanced options for the backend elasticsearch supporting the data storage (purge, indices rotation, ...)

[Facts](/settings/fact/fact) are the backbone of a Myrtea application, but they can only be attached to a single model.

Models must be built based on the target facts, using a top-down approach.

## Data structures and Datatypes

### Supported field types

| Type       | Category  | Comment                           |
| ---------- | --------- | --------------------------------- |
| `string`   | Primitive | Any alphanumeric chain            |
| `integer`  | Primitive | Round number                      |
| `float`    | Primitive | Floating-point number             |
| `datetime` | Primitive | Date and time                     |
| `object`   | Advanced  | Complex object with nested fields |

### Field Leaf

| Attribute  | JSON Type       | Comment                                  | Example              |
| ---------- | --------------- | ---------------------------------------- | -------------------- |
| `name`     | String          | Field name                               | `label`              |
| `type`     | String          | Field type (based on the previous table) | `string`             |
| `synonyms` | Array of String | Liste de synonymes métier pour le modèle | `["label", "title"]` |

### Field Object

| Attribut               | JSON            | Values                                   | Description                                       |
| ---------------------- | --------------- | ---------------------------------------- | ------------------------------------------------- |
| `name`                 | String          |                                          | Nom du champ                                      |
| `type`                 | String          | Object                                   | Décrit le type du champs                          |
| `synonyms`             | Array of String | Liste de synonymes métier pour le modèle | synonyms dans un field objet ? plutôt dans l’id ? |
| `fields`               | Array of Object |                                          | Liste de champs du modèle                         |
| `keepObjectSeparation` | Boolean         |                                          |                                                   |

## Elasticsearch Options

* `Rotation mode`
    * "Cron" is the only choice for now. The indices rotations is based on a cron expression.
    * It is advised to stay on a daily rotation for now (cron : `0 0 * * *`)
* `Purge activation`
    * Can be enabled or not
    * Based on a second parameter "Index count before purge" to specify how many indices must be kept before any purge.
* `Alias patch depth`
    * Used to specify the depth of a specific "Patch Alias" which target indices used for update on "old" data (stored in indices other than the current one)
* `Advanced options`
    * Any other elasticsearch index options (ie: number_of_shards, number_of_replicas, ...)
