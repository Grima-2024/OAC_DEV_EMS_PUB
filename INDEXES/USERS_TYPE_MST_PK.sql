--------------------------------------------------------
--  DDL for Index USERS_TYPE_MST_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "INSTITUTE"."USERS_TYPE_MST_PK" ON "INSTITUTE"."USERS_TYPE_MST" ("USER_TYPE_ID") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
