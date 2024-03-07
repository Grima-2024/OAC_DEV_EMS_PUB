--------------------------------------------------------
--  Constraints for Table EBA_DEMO_DG_EMP
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EBA_DEMO_DG_EMP" MODIFY ("EMPNO" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."EBA_DEMO_DG_EMP" ADD CONSTRAINT "EBA_DEMO_DG_EMP_PK" PRIMARY KEY ("EMPNO")
  USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA"  ENABLE;
