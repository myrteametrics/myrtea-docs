# list.component

List.component is a container that wraps a series of line items, this component waiting for two args:

| Name | Type | Description | optional |
|-------|------------|-----|-----------|
| headerList | string[] | List's header | false |
| rowsList | ListRowElement[] | A table of row | false |
| elementByPage | number | Nuimber of element by page | true |

```typescript
// all rows
interface ListRowElement {
    text?: string;
    level?: StatusLevel;
}
// row
interface ListRow {
    rowElement: ListRowElement[];
}
```

```typescript  tab="Typescript"

```

```html tab="HTML"
<app-list
    *ngIf="rowsList"
    class="myrtea-list-container"
    [headerList]="headerList"
    [rowsList]="rowsList">
</app-list>
```
