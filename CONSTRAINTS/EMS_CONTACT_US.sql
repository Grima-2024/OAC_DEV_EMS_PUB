--------------------------------------------------------
--  Constraints for Table EMS_CONTACT_US
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMS_CONTACT_US" MODIFY ("CONTACT_NO" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."EMS_CONTACT_US" ADD CONSTRAINT "EMS_CONTACT_US_PK" PRIMARY KEY ("CONTACT_ID")
  USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA"  ENABLE;