--------------------------------------------------------
--  Constraints for Table MEDIUM_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."MEDIUM_MST" MODIFY ("MED_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."MEDIUM_MST" MODIFY ("MED_SHORT_NAME" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."MEDIUM_MST" MODIFY ("INSTITUTE_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."MEDIUM_MST" MODIFY ("AC_YEAR_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."MEDIUM_MST" ADD CONSTRAINT "MEDIUM_MAST_PK" PRIMARY KEY ("MED_ID")
  USING INDEX "INSTITUTE"."MEDIUM_MAST_PK"  ENABLE;