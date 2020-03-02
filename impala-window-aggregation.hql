select
type
, status_code
, count(1) as counts
# count(1) vs count(*): count(1) count the first column only, and it takes less resources and time
# counts:the counts of rows by type and status_code
, sum(count(1)) over() as total
# total: the count of all rows
, count(1)/sum(count(1)) over() as percent
# the counts per type per status_code accounts for #% of total counts
, sum(count(1)) over (order by count(1) desc ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
# accumulate sum of counts
from database.table
group by type
, status_code
order by counts desc;
