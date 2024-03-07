--------------------------------------------------------
--  Constraints for Table EMS_MODULE_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMS_MODULE_MST" MODIFY ("MODULE_NM" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."EMS_MODULE_MST" MODIFY ("MODULE_TYPE" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."EMS_MODULE_MST" ADD CONSTRAINT "EMS_MODULE_MST_PK" PRIMARY KEY ("MODULE_ID")
  USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA"  ENABLE;
