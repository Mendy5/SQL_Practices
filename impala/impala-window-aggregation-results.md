**Query**
```
select
type
, status_code
, count(1) as counts
, sum(count(1)) over() as total
, count(1)/sum(count(1)) over() as percent
, sum(count(1)) over (order by count(1) desc ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as accum_counts
from database.table
group by type
, status_code
order by counts desc;
```

**Results**

type|status_code|counts|total|percent|accum_counts
--------|--------|--------|--------|--------|--------
ABC|ACTIVE|1061189|3297485|0.3218176883291357|1061189
ABD|ACTIVE|756621|3297485|0.22945396264122506|1817810
ACA|DISCONTINUED|298579|3297485|0.09054749301361492|2116389
BDE|PENDING|213713|3297485|0.06481090891997993|2330102

**Notes**
- count(1) vs count(*): count(1) count the first column only, and it takes less resources and time
- counts:the counts of rows by type and status_code
- sum(count(1)) over(): the count of all rows
- count(1)/sum(count(1)) over(): the counts per type per status_code accounts for #% of total counts
- sum(count(1)) over (order by count(1) desc ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW): accumulated sum of counts
