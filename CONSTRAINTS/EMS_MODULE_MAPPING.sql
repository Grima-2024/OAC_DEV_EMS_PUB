--------------------------------------------------------
--  Constraints for Table EMS_MODULE_MAPPING
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMS_MODULE_MAPPING" ADD CONSTRAINT "EMS_MODULE_MAPPING_PK" PRIMARY KEY ("MOD_MAP_ID")
  USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA"  ENABLE;