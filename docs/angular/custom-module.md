# Custom module

!!! warning
    The `custom` module is dedicated to integration. This one and only module can be edited in the angular tree.
    **Other modules are strictly reserved to the editor to ensure proper version upgrade.**

## Tree

| Name | Type | Description |
|-------|------------|-----|
| components | folder | Contains custom's components |
| services | folder | Contains custom's services |
| models | folder | Contains custom's models |
| custom-routing.ts | file | Contains custom's routes |
| custom-module.ts | file | Carry the modifications to myrtea |
| custom.scss | file | Override myrtea-design-system, bootstrap or angular's comonents |

## Create component

```bash
ng g c custom/components/my-component
```

## Create service

```bash
ng g s custom/services/my-service
```
