--------------------------------------------------------
--  Constraints for Table XXX_USER_TYPE_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."XXX_USER_TYPE_MST" ADD CONSTRAINT "XXX_USER_TYPE_MST_PK" PRIMARY KEY ("USER_TYPE_ID")
  USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA"  ENABLE;
