--------------------------------------------------------
--  Constraints for Table EMS_DEMO_REQUEST_TBL
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMS_DEMO_REQUEST_TBL" MODIFY ("CONTACT_NO" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."EMS_DEMO_REQUEST_TBL" ADD CONSTRAINT "EMS_DEMO_REQUEST_TBL_PK" PRIMARY KEY ("REQUEST_ID")
  USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA"  ENABLE;