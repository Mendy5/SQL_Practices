--apply lateral view explode array to key and value columns
select distinct
col1
, col2
, expl_tbl
, expl_tbl_2
, `date`
from
database.table_name
lateral view explode(array_col) exploded_table as expl_tbl, expl_tbl_2
