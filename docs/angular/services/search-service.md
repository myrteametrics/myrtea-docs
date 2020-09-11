# Search Service

This service may help you doing some researches on about situations but also to formate the obtained results depending on its needs.

```typescript
import { SearchService } from '@shared/search/services/search.service';

constructor(
    private searchService: SearchService
) { }
```

## Search

In order ta make a search use a search function wich wait for a SearchRequestBody object.

| Name | Type | Description | optional |
|-------|------------|-----|-----------|
| situationId | number | Situation id  | false |
| situationInstanceId | number | Situation instance id  | true |
| time | string | Time to search | true |
| start | string | Date of the begin of the results | true |
| end | string | Date of the end of the results  | true |
| facts | string boolean string[] | Filters | true |
| metaDatas | string boolean string[] | Filters  | true |
| parameters | string boolean string[] | Filters | true |

```typescript
// searchBody instance of SearchRequestBody
this.searchService.search(searchBody).subscribe((searchResults: SearchResult[]) => {
     // your logic with result
});
```

## Transform result

### Transform result to use in List component

You can transform SituationHistoryRecord into ListRowElement in ordre to use it in List-component.

```typescript
public transformElement(
    situationHistoryRecord: SituationHistoryRecord,
    situationValueSearch: SituationValueSearch
): ListRowElement
```

Example:

```typescript
let rowElement: ListRowElement = this.searchService.transformElement(
    situationHistoryRecord,
    {
        // For example we extract parameters value who has name flux
        type: SituationValueType.PARAMETERS, key: 'flux'
    }
);
```
