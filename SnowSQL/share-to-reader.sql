--Data Provider Account

create share share_citibike;

grant usage on database citibike to share share_citibike;

grant usage on schema citibike.public to share share_citibike;

grant select on table citibike.public.trips  to share share_citibike;

show grants to share share_citibike;

CREATE MANAGED ACCOUNT reader admin_name='temp_reader', admin_password='Reader1@sflake', type=reader, COMMENT='Temp Reader';

show managed accounts;

alter share share_citibike add accounts=OZ63552;

-- database is shared with the user. Login to the reader account, create a warehouse (if doesn't exist already) and create a database from the share as follows.

--Data Consumer Account

CREATE WAREHOUSE temp_wh WITH
WAREHOUSE_SIZE = 'SMALL' WAREHOUSE_TYPE = 'STANDARD'
AUTO_SUSPEND = 600 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 
MAX_CLUSTER_COUNT = 2 SCALING_POLICY = 'STANDARD';

CREATE ROLE "ROLE1";
GRANT ROLE "ROLE1" TO ROLE "USERADMIN";

CREATE DATABASE "imported_db" FROM SHARE QH73213."SHARE_CITIBIKE";
GRANT IMPORTED PRIVILEGES ON DATABASE "imported_db" TO ROLE "ROLE1";

GRANT IMPORTED PRIVILEGES ON DATABASE "imported_db" TO ROLE "ROLE1";
grant usage on warehouse temp_wh to role role1;

use role role1;
use warehouse temp_wh;

show tables;
select top 20 * from trips;



