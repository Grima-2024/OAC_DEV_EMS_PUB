--------------------------------------------------------
--  Constraints for Table SCHEDULE_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."SCHEDULE_MST" ADD CONSTRAINT "SCHEDULE_MST_CON" UNIQUE ("S_DATE", "S_DAY", "TIME_ID_FK") DISABLE;
  ALTER TABLE "INSTITUTE"."SCHEDULE_MST" MODIFY ("SCHEDULE_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."SCHEDULE_MST" MODIFY ("S_DATE" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."SCHEDULE_MST" MODIFY ("S_DAY" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."SCHEDULE_MST" MODIFY ("TIME_ID_FK" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."SCHEDULE_MST" MODIFY ("MED_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."SCHEDULE_MST" MODIFY ("STD_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."SCHEDULE_MST" MODIFY ("SUB_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."SCHEDULE_MST" MODIFY ("EMPLOYEE_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."SCHEDULE_MST" ADD CONSTRAINT "SCHEDULE_MST_PK" PRIMARY KEY ("SCHEDULE_ID")
  USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA"  ENABLE;