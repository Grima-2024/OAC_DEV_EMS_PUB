--------------------------------------------------------
--  DDL for Index SUBJECT_MASTER_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "INSTITUTE"."SUBJECT_MASTER_PK" ON "INSTITUTE"."SUBJECT_MST" ("SUB_ID") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;