create database citibike;
create or replace table trips  
(tripduration integer,
  starttime timestamp,
  stoptime timestamp,
  start_station_id integer,
  start_station_name string,
  start_station_latitude float,
  start_station_longitude float,
  end_station_id integer,
  end_station_name string,
  end_station_latitude float,
  end_station_longitude float,
  bikeid integer,
  membership_type string,
  usertype string,
  birth_year integer,
  gender integer);
  
  create stage tripstage url = 's3://snowflake-workshop-lab/citibike-trips ';
  copy into trips from @tripstage file_format=CSV;
  select * from trips limit 10;
  drop table trips;