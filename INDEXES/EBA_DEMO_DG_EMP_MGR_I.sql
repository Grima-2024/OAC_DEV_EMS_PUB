--------------------------------------------------------
--  DDL for Index EBA_DEMO_DG_EMP_MGR_I
--------------------------------------------------------

  CREATE INDEX "INSTITUTE"."EBA_DEMO_DG_EMP_MGR_I" ON "INSTITUTE"."EBA_DEMO_DG_EMP" ("MGR") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
