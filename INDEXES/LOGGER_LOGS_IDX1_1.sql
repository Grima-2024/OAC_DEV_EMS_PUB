--------------------------------------------------------
--  DDL for Index LOGGER_LOGS_IDX1
--------------------------------------------------------

  CREATE INDEX "INSTITUTE"."LOGGER_LOGS_IDX1" ON "INSTITUTE"."LOGGER_LOGS" ("TIME_STAMP", "LOGGER_LEVEL") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
