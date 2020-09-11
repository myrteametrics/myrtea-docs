# Business rule settings

## Parameters

### Parameters inheritance priority

From the most prioritized to the least prioritized :

* Situation template instance parameters
* Situation global parameters (template or not)
* Business rule default parameters

!!! Example
    With the following settings context :

    * Situation template instance
        * A = `1`
    * Situation (global)
        * A = `10`
        * B = `20`
    * Business rule (default)
        * A = `100`
        * B = `200`
        * C = `300`

    **Final parameters after resolution :**

    * A = `1` (from the situation template instance)
    * B = `20` (from the situation)
    * C = `300` (from the business rule)
