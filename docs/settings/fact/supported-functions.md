# Tokens and functions

## Special tokens

| Token            | Description                                                              |
| ---------------- | ------------------------------------------------------------------------ |
| `now`            | Current date. Use internal API execution time.                           |
| `begin`          | `@Deprecated`. Still working for compatibility reason. Support timezone. |
| `startofday`     | Start of the current day. Support timezone.                              |
| `startofmonth`   | Start of the current month. Support timezone.                            |
| `startofnextday` | Start of the next day(End of the current day). Support timezone.         |

## Special functions

| Function                           | Description                                                                                             | Example                        |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------ |
| `length(<array>)`                  | Return the length of the array                                                                          |                                |
| `max(<array>)`                     | Return the max value of the array                                                                       |                                |
| `min(<array>)`                     | Return the min value of the array                                                                       |                                |
| `sum(<array>)`                     | Return the sum value of the array                                                                       |                                |
| `average(<array>)`                 | Return the average value of the array                                                                   |                                |
| `dayOfWeek(<date>)`                | Extract the day of week from a date (1 = monday, 7 = sunday)                                            | `dayOfWeek(now)`               |
| `day(<date>)`                      | Extract the day from a date                                                                             | `day(now)`                     |
| `month(<date>)`                    | Extract the month from a date                                                                           | `month(now)`                   |
| `year(<date>)`                     | Extract the year from a date                                                                            | `year(now)`                    |
| `startOf(<date>, <option>)`        | Return a transformed date base on the selection option. Support options are `"day"`, `"month"`,`"year"` | `startOf(now, "month")`        |
| `endOf(<date>, <option>)`          | Return a transformed date base on the selection option. Support options are `"day"`, `"month"`,`"year"` | `endOf(now, "day")`            |
| `datemillis(<date>)`               | Convert a date in milliseconds                                                                          | `datemillis(now)`              |
| `calendar_add(<date>, <duration>)` | Add a duration to a specific date.<br>Warning: `duration` only support Go duration format               | `calendar_add(now, "-48h")`    |
| `calendar_delay(<date>, <date>)`   | Compute the delay between two date, in milliseconds                                                     | `calendar_delay(date1, date2)` |
| `calendar_add_od(<date>, <duration> [, <calendar>])` | Add a duration to a specific date, taking account of open days.<br>Warning: `duration` only support Go duration | `calendar_add(now, "-48h")`       |
| `calendar_delay_od(<date>, <date> [, <calendar>])`   | Compute the delay between two date, in milliseconds, taking account of open days                                | `calendar_delay_od(date1, date2)` |
