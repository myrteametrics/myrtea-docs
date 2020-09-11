# Shared components

## Confirmation-pop-up.component

This component for display confirmation window to user, this component waiting for a title and a content. You can find more informations on [Material Dialog API](https://material.angular.io/components/dialog/api)

```typescript
// import MatDialog service
constructor(
    private dialog: MatDialog
) { }
```

```typescript
// instantiate confirmation window
this.dialog.open(ConfirmationPopUpComponent, {
    width: '30%',
    data: {
        title: 'your title',
        content: 'your content'
    }
}).afterClosed().subscribe((validation: boolean) => {
    // Your logic after user response
});
```

## Input-with-suggestions

Input-with-suggestions component is a simple input container who display suggestions depends to user's input, this component waiting for two args:

| Name | Type | Description | optional |
|-------|------------|-----|-----------|
| data | InputWithSuggestionsData | Suggestions data | false |
| selectEmitter | (id: number) => void | function who catch user's selection | true |

```typescript
// one suggestion
interface InputWithSuggestionsElement {
    // if you want specif icon before element's name
    icon?: string;
    // name of the element
    content: string;
    // id of the element
    objectId: number;
}

interface InputWithSuggestionsData  {
    // label of input
    label: string;
    elements: InputWithSuggestionsElement[];
}
```

```typescript tab="Typescript"

```

```html tab="HTML"
<app-input-with-suggestions
    [data]="inputWithSuggestionsData"
    (selectEmitter)="addUserById($event)">
</app-input-with-suggestions>
```

## Settings-control-bar.component

```html tab="HTML"
<app-settings-control-bar
    class="myrtea-settings-page-control-bar"
    controlTitle="your title"
    [noMoreOptions]="creationMode"
    [updateModifiedState]="factEditForm && factEditForm.dirty"
    (return)="return()"
    (save)="save()"
    (cancel)="cancel()"
    (delete)="delete()">
</app-settings-control-bar>
```

## list.component

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

```html
  <app-list
    *ngIf="rowsList"
    class="myrtea-list-container"
    [headerList]="headerList"
    [rowsList]="rowsList">
  </app-list>
```

## Input-with-suggestions

Input-with-suggestions component is a simple input container who display suggestions depends to user's input, this component waiting for two args: 

| Name | Type | Description | optional |
|-------|------------|-----|-----------|
| data | InputWithSuggestionsData | Suggestions data | false |
| selectEmitter | (id: number) => void | function who catch user's selection | true |

```typescript
// one suggestion
interface InputWithSuggestionsElement {
  // if you want specif icon before element's name
  icon?: string;
  // name of the element
  content: string;
  // id of the element
  objectId: number;
}

interface InputWithSuggestionsData  {
  // label of input
  label: string;
  elements: InputWithSuggestionsElement[];
}
```

```html
  <app-input-with-suggestions
    [data]="inputWithSuggestionsData"
    (selectEmitter)="addUserById($event)">
  </app-input-with-suggestions>
```

## Settings-control-bar.component

```html
  <app-settings-control-bar
    class="myrtea-settings-page-control-bar"
    controlTitle="your title"
    [noMoreOptions]="creationMode"
    [updateModifiedState]="factEditForm && factEditForm.dirty"
    (return)="return()"
    (save)="save()"
    (cancel)="cancel()"
    (delete)="delete()">
  </app-settings-control-bar>
```
