select * from trips limit 10;
drop table trips;
undrop table trips;
update trips set start_station_name = '100';
//find query id of the update operation
set query_id = 
(select query_id from 
table(information_schema.query_history_by_session (result_limit=>5)) 
where query_text like 'update%' order by start_time limit 1);
//restore table before execution of the update statement
create or replace table trips as
(select * from trips before (statement => $query_id));