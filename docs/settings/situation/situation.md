# Situation settings

The notion of **situation** is one of the most important concept in Myrtea.

Every **facts** is scoped to a specific **model**, but situations are not. The situations provide the opportunity to regroup informations from multiple sources and types.

It is the main segregation mecanism between multiple business contexts. It allow to segregate access between user groups

## General attributes

A situation must have a `name` (avoid special characters and whitespaces)

## Facts selections

A situation is composed by multiple facts (and each fact can compose multiple situations).

Each fact in a situation will inherit all the situation parameters. This is the main mecanism used to calculate fact templates.

## Rules selections

A situation can be associated with multiple rules (and each rule can be associated with multiple situations).

Each rule in a situation will inherit all the situation parameters. See more in [Rule settings - Inheritance](../business-rule/business-rule.md#parameters-inheritance-priority)

## Parameters and templating

It is possible to flag a situation as **template**, in case multiple "identical" situations must be created, with only difference in parameters (but same facts, same rules, same groups)

Instead of creating multiple situations, only one template is created.

The template situation must be enriched with **situation instances"", which will describe each "variations" of the situations.

A **situation template instance** is composed of :

* A name (avoid special characters and whitespaces)
* A list of parameters (common key-value format)

Situation instance parameters always override the global situation parameters.
