--------------------------------------------------------
--  DDL for View LOGGER_LOGS_60_MIN
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "INSTITUTE"."LOGGER_LOGS_60_MIN" ("ID", "LOGGER_LEVEL", "TEXT", "TIME_STAMP", "SCOPE", "MODULE", "ACTION", "USER_NAME", "CLIENT_IDENTIFIER", "CALL_STACK", "UNIT_NAME", "LINE_NO", "SCN", "EXTRA", "SID", "CLIENT_INFO") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  select "ID","LOGGER_LEVEL","TEXT","TIME_STAMP","SCOPE","MODULE","ACTION","USER_NAME","CLIENT_IDENTIFIER","CALL_STACK","UNIT_NAME","LINE_NO","SCN","EXTRA","SID","CLIENT_INFO"  
      from logger_logs  
	 where time_stamp > systimestamp - (1/24) 

;
