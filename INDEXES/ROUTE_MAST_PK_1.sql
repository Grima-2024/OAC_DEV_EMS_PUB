--------------------------------------------------------
--  DDL for Index ROUTE_MAST_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "INSTITUTE"."ROUTE_MAST_PK" ON "INSTITUTE"."ROUTE_MST" ("ROUTE_ID") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
