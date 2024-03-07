--------------------------------------------------------
--  DDL for View LOGGER_LOGS_TERSE
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "INSTITUTE"."LOGGER_LOGS_TERSE" ("ID", "LOGGER_LEVEL", "TIME_AGO", "TEXT") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  select id, logger_level,  
        substr(logger.date_text_format(time_stamp),1,20) time_ago, 
        substr(text,1,200) text 
   from logger_logs 
  where time_stamp > systimestamp - (5/1440) 
  order by id asc 

;
