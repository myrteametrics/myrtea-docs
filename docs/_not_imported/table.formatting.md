# Table formatting

## Inline hack for colspan

| Operator | Field  | Value | Value 2 | Comment |
|----------|--------|-------|---------|---------|
| `Between` | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | Check if a field value is between two values provided in input |
| `Script` | Special "free text input" for advanced script {colspan="3"} | {style="display:none;"} | {style="display:none;"} | Check if the script output is true |

Use `| text {colspan="2"}` followed by `| {style="display:none;"}` as many time as the colspan needs it ( `size_colspan - 1` )
