# header.service

This service for manage header (header's title and visibility)

```typescript
constructor(
    private headerService: HeaderService
) { }
```

```typescript
// change the title
this.headerService.changeTitle('Your title');
```

```typescript
// change the visibility
this.headerService.changeVisibility(false);

// don't forget to set visibility true in onDestroy
ngOnDestroy() {
    this.headerService.changeVisibility(true);
}
```
