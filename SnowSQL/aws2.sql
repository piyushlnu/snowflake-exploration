create database demo
drop database demo
create or replace table demo_table(
name varchar(50),
age int,
gender varchar(50)
)
CREATE or replace STORAGE INTEGRATION demo_int
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = ''
  STORAGE_ALLOWED_LOCATIONS = ('s3://snowflake-bucket1928/');
  
  desc integration demo_int;
  
  create or replace stage demo_stage url='s3://snowflake-bucket1928' storage_integration=demo_int   file_format = (type='CSV');
  
  create or replace pipe demo_pipe auto_ingest=true as 
  copy into demo_table from @demo_stage 
  on_error=continue ;
  
  
  show pipes;
  select * from demo_table;
  alter pipe demo_pipe refresh;