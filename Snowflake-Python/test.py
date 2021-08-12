#!/usr/bin/env python
import snowflake.connector

# Gets the version
ctx = snowflake.connector.connect(
    user='piyushlnu',
    password='P08@csb31',
    account='qh73213.west-us-2.azure'
    )
cs = ctx.cursor()
try:
    cs.execute("use role sysadmin")
    cs.execute("use warehouse compute_wh")
    cs.execute("use database citibike")
    cs.execute("use schema public")
    cs.execute("select top 10 TRIPDURATION,STARTTIME,START_STATION_NAME from trips")
    for c in cs:
        print(c)

    #one_row = cs.fetchone()
    #print(one_row[0])
finally:
    cs.close()
ctx.close()