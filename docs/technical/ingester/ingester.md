# Ingester API

## Ingester data format

!!! info
    Currently, in v4.0.0, **the only supported format is JSON.**


## BulkIngestRequest structure

```go tab="Go"
type BulkIngestRequest struct {
    UUID         string     `json:"uuid"`
    DocumentType string     `json:"documentType"`
    MergeConfig  []Config   `json:"merge"`
    Docs         []Document `json:"docs"`
}
```

## Document structure

```go tab="Go"
type Document struct {
    ID        string      `json:"id"`
    Index     string      `json:"index"`
    IndexType string      `json:"type"`
    Source    interface{} `json:"source"` // Most of the time a map[string]interface{}
}
```

## Merge config structure

```go tab="Go"
// Config wraps all rules for document merging
type Config struct {
    Mode             Mode    `json:"mode"`
    ExistingAsMaster bool    `json:"existingAsMaster"`
    Type             string  `json:"type,omitempty"`
    LinkKey          string  `json:"linkKey,omitempty"`
    Groups           []Group `json:"groups,omitempty"`
}

// Mode ...
type Mode int
const (
    Self Mode = iota + 1
    EnrichTo
    EnrichFrom
)
```

## Merge config group structure

```go tab="Go"
// Group allows to group un set of merge fields and to define an optional condition to applay the merge fields
type Group struct {
    Condition             string      `json:"condition,omitempty"`
    FieldReplace          []string    `json:"fieldReplace,omitempty"`
    FieldReplaceIfMissing []string    `json:"fieldReplaceIfMissing,omitempty"`
    FieldMerge            []string    `json:"fieldMerge,omitempty"`
    FieldKeepLatest       []string    `json:"fieldKeepLatest,omitempty"`
    FieldKeepEarliest     []string    `json:"fieldKeepEarliest,omitempty"`
    FieldMath             []FieldMath `json:"fieldMath,omitempty"`
}

// FieldMath specify a merge rule using a math expression
type FieldMath struct {
    Expression  string `json:"expression"`
    OutputField string `json:"outputField"`
}
```

## Examples

### Ingest a new project

```json tab="POST /api/v1/ingester/data"
{
    "uuid": 1,
    "document-type": "project",
    "merge": [
        {
            "mode": "self",
            "type": "project"
        },
    ],
    "docs": [
        {"id": "1", "source": {"id":"project-1", "label": "A"}}
        {"id": "2", "source": {"id":"project-2", "label": "B"}}
        {"id": "3", "source": {"id":"project-3", "label": "C"}}
    ]
}
```

### Update existing projects

```json tab="POST /api/v1/ingester/data"
{
    "uuid": 2,
    "document-type": "project",
    "merge": [
        {
            "mode": "self",
            "type": "project",
            "groups": [
                {
                    "condition": "true",
                    "fieldReplace": ["label"],
                    "FieldReplaceIfMissing": ["new_field"]
                }
            ]
        },
    ],
    "docs": [
        {"id": "2", "source": {"id":"project-2", "label": "New Label"}}
        {"id": "3", "source": {"id":"project-3", "new_field": "new field value"}}
    ]
}
```

## Merge configuration

General rules :

* In case "existing doc" is missing, no merge config is applied, the new document is sent "as is".
* In case a referenced field is missing in a function (`calendar_delay(..., ...)`, `calendar_add(..., ...)`, etc.), the function is skipped

| Existing Doc<br>(in Elasticsearch) | FieldReplace [ "a" ]<br>The field "a" is replaced | FieldReplaceIfMissing [ "a" ]<br>The field "a" is added only if missing | FieldReplace [ "a" ]<br>The field "a" is replaced | FieldReplaceIfMissing [ "a" ]<br>The field "a" is added only if missing |
|------------------------------------|----------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| | ExistingAsMaster = TRUE<br>The existing document is the master and is enriched by the new document {colspan="2"}|{style="display:none;"}|ExistingAsMaster = FALSE<br>The new document is the master and is enriched by the existing document {colspan="2"}|{style="display:none;"}|
| Nil               | a = 30<br>b = 50      | a = 30<br>b = 50      | a = 30<br>b = 50      | a = 30<br>b = 50      |
| a = 1<br>b = 2    | **a = 30**<br>b = 2   | a = 1<br>b = 2        | **a = 1**<br>b = 50   | a = 30<br>b = 50      |
| b = 2             | **a = 30**<br>b = 2   | **a = 30**<br>b = 2   | a = 30<br>b = 50      | a = 30<br>b = 50      |
| a = 1<br>b = 2    | a = 1<br>b = 2        | a = 1<br>b = 2        | **a = 1**<br>b = 50   | **a = 1**<br>b = 50   |
| b = 2             | b = 2                 | b = 2                 | b = 50                | b = 50                |

## Advanced merge configuration

| New Doc<br>(ingested) | Existing Doc<br>(in Elasticsearch) | FieldMath<br>calendar_delay(Existing.date1, New.date2) | FieldMath<br>calendar_delay(New.date1, Existing.date2) | FieldMath<br>calendar_delay(Existing.date1, New.date2) | FieldMath<br>calendar_delay(New.date1, Existing.date2) |
|---------------|------------------------------------|----------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|--------------------------------------------------------|--------------------------------------------------------|
| | | ExistingAsMaster = TRUE<br>The existing document is the master and is enriched by the new document {colspan="2"}|{style="display:none;"}|ExistingAsMaster = FALSE<br>The new document is the master and is enriched by the existing document {colspan="2"}|{style="display:none;"}|
| date1 = 2019-12-10<br>date2 = 2019-12-15 | Nil                   | Not applicable                                       | Not applicable                                       | Not applicable                                      | Not applicable |
| <br>date2 = 2019-12-15<br> | date1 = 2019-12-10<br><br>    | date1 = 2019-12-10<br>**delay = 5 Days**  | Not applicable                                       | date1 = 2019-12-10<br>**delay = 5 Days** | Not applicable |
| date1 = 2019-12-10<br>                        | <br>date2 = 2019-12-15    | Not applicable                                       | date2 = 2019-12-15<br>**delay = 5 Days**  | Not applicable                                      | date2 = 2019-12-15<br>**delay = 5 Days** |
