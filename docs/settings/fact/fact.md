# Fact settings

A **fact** is what we most commonly call a key performance indicator (or KPI), but it can also represent some other kind of informations.

## General attributes

A **fact** must have a `name` (avoid special characters and whitespaces)

A **fact** is always scoped to a single **model**. It is mandatory to continue on the next part the settings process.

A fact is composed of three majors parts, which depends on the selected **model**:

* an **intent** (mandatory)
* some **dimensions** (optional)
* some **conditions** (optional)

## Intent

The intent guides how the fact should be calculated. The intent regroups two parameters :

* An **operator** : What operation do I want to do ? (A count, a sum, an average, etc.)
* A **term** : On what kind of data do I want to apply this operation ?

!!! Example
    * I want to **count** how many **breakdown** I have [...]
    * I want to calculate the **average** of all my **product prices** [...]

!!! warning
    Currently, in v4.0.0, there is no validation on the consistency between the **operator** and the **term** of intents.

    For example, "the **Sum** of all **breakdown date**" would be valid during the settings phase, but cannot be calculated

### Supported fact operators

Operators are pretty self explanatory :

* `Count`
* `Average`
* `Sum`
* `Min`
* `Max`

### Supported fact terms

* Any field of a model
* The selected model itself (which is only valid for the `count` operator)
* An advanced script

## Fact dimensions

In specific context, a fact can be broken down based on specific analysis axis.

As shown in the previous section, we can easily create a fact which `count` the number of `breakdown`.
If we want the same count, but for each "type" of breakdown, we can add a new `dimension` to the fact.

!!! Example
    Basic fact without dimension :

    * Result = `50`

    Same fact with a new dimension "type" :

    * Result
        * `type1` = `15`
        * `type2` = `25`
        * `type3` = `10`

A dimension is defined by :

* An **operator**
* A **term**
* Some options (which are optionnals)

!!! warning
    Currently, in v4.0.0, there is no validation on the consistency between the **operator** and the **term** of dimensions.

### Supported condition operators

| Operator types   | Corresponding Option                                                      | Comment                                   |
| ---------------- | ------------------------------------------------------------------------- | ----------------------------------------- |
| `By`             | `Size` (number of element in the dimension)                               | Based on an **alphanumeric** field        |
| `Histogram`      | `Interval` (numeric interval between each element in the dimension)       | Based on a **numeric** field              |
| `Date Histogram` | `Date interval` (Duration interval between each element in the dimension) | Based on a **date** or **datetime** field |

## Fact Condition

The condition describe how the data must be filtered before executing the intent operation.

It is build in the form of a condition tree based on :

* Group conditions (or structure conditions)
* Leaf conditions

### Fact group condition

A group condition is described by :

* a logic boolean operator
* some children conditions

| Operator | Comment                                                                                                                                                                                                                                               |
| -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `And`    | All children conditions must be met. Must have at least 2 children conditions                                                                                                                                                                         |
| `Or`     | Any children condition must be met. Must have at least 2 children conditions                                                                                                                                                                          |
| `Not`    | Behave like a standard logical NOT operator (reverse the result of the children condition). <br>If there are multiple children conditions under this operator, it behave exactly like a `Not` containing an `And`, which contains all children conditions |
| `If` | If the associated `expression` is evaluated as `true`, all children conditions are added to the condition tree. If not, children conditions are discarded. |

### Fact leaf condition

A Leaf condition is a terminal condition, which cannot have children condition.
Based on the condition type, it is described by the following parameters :

| Operator  | Field                                                       | Value                   | Value 2                 | Comment                                                          |
| --------- | ----------------------------------------------------------- | ----------------------- | ----------------------- | ---------------------------------------------------------------- |
| `Exists`  | :heavy_check_mark:                                          |                         |                         | Check if a field exists                                          |
| `For`     | :heavy_check_mark:                                          | :heavy_check_mark:      |                         | Check if a field value is equals to a value provided in input    |
| `From`    | :heavy_check_mark:                                          | :heavy_check_mark:      |                         | Check if a field value is greater than a value provided in input |
| `To`      | :heavy_check_mark:                                          | :heavy_check_mark:      |                         | Check if a field value is lower than a value provided in input   |
| `Between` | :heavy_check_mark:                                          | :heavy_check_mark:      | :heavy_check_mark:      | Check if a field value is between two values provided in input   |
| `Script`  | Special "free text input" for advanced script {colspan="3"} | {style="display:none;"} | {style="display:none;"} | Check if the script output is true                               |

!!! Example
    The data must have :

    * a `type` field,
    * a `label` not equals to `"type1"`
    * a `price` between `10` and `50`, or an `amount` greater than `25`

    Which lead to the following condition tree :

    * `And`
        * `Exists` ( `type` )
        * `Not`
            * `For` ( `label` : `"type1"` )
        * `Or`
            * `Between` ( `price` : `10` - `50`)
            * `From` ( `amount` : `25` )

!!! warning
    Currently, in v4.0.0, there is no validation on the consistency between the **operator**, the **field** and the **values** of leaf conditions.

### Special tokens

See [Tokens and functions](supported-functions.md#special-tokens)

### Special functions

See [Tokens and functions](supported-functions.md#special-functions)

### Special Elasticsearch date operators

!!! warning
    Support for this kind of operators will be deprecated in **v4.0.0**.

    Please use dedicated special function `calendar_add(<date>, <duration>)` (See [Tokens and functions](supported-functions.md#special-functions))

| Condition | Description |
| --------- | ----------- |
| `now + "               || -2d"` | Concatenate a date with a static elasticsearch math operation (here `" || -2d"`). <br>The double-quotes are required to concatenate the math operation to the date |

## Calculation depth

TODO:

## Templating and parameters

Imagine we want to create multiple variations of a single fact.

The way the calculations are done is the same between all the variations of the fact, with only a few filter changes.

!!! Example
    * I want to `count` the `breakdown` for the `component` = `bluetooth`.
    * I want to `count` the `breakdown` for the `component` = `wifi`.
    * I want to `count` the `breakdown` for the `component` = `screen`.

### Create a fact template

Instead, we would build a single template fact :

* I want to `count` the `breakdown` for the `component` = `X`, where `X` is a **parameter** (which can be substituted for any component name).

To build this fact, the following steps are required :

* The fact can must tagged as a **template** to indicate that the fact contains a parameter. Thus, the fact cannot be calculated anymore, without the required parameters values.
* The related condition must be changed :
    * From `for` ( `component` : `"wifi"` )
    * To `for` ( `component` : `component_name` )
        * with `component_name` the external parameter name.

!!! Note
    **Parameters** used in conditions must not wrapped with double-quotes.

    In this case, the filter is not done on the string `"component_name"`, but on the parameter `component_name`.

### Parameters inheritance

The parameters values are inherited from the parent situation.
