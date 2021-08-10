drop database newdb;
create database newdb;
create table mytable (v variant);
create or replace stage snowstage url='s3://snowbucket1928'
  credentials=(aws_key_id='' aws_secret_key='')
  file_format = (type=json);
show stages;
create or replace pipe snowpipe auto_ingest=true as
copy into mytable from@snowstage file_format=(type=json);

show pipes;
alter pipe snowpipe refresh;
select * from mytable;