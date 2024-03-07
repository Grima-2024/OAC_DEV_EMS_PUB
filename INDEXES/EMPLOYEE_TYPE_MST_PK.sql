--------------------------------------------------------
--  DDL for Index EMPLOYEE_TYPE_MST_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "INSTITUTE"."EMPLOYEE_TYPE_MST_PK" ON "INSTITUTE"."EMPLOYEE_TYPE_MST" ("TYPE_ID") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;