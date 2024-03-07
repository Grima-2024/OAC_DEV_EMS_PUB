--------------------------------------------------------
--  DDL for Index LOGGER_APEX_ITEMS_IDX1
--------------------------------------------------------

  CREATE INDEX "INSTITUTE"."LOGGER_APEX_ITEMS_IDX1" ON "INSTITUTE"."LOGGER_LOGS_APEX_ITEMS" ("LOG_ID") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "DATA" ;
