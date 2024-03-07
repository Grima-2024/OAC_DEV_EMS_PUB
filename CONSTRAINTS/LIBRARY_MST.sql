--------------------------------------------------------
--  Constraints for Table LIBRARY_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."LIBRARY_MST" MODIFY ("LIB_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."LIBRARY_MST" MODIFY ("INSTITUTE_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."LIBRARY_MST" ADD CONSTRAINT "LIBRARY_MST_PK" PRIMARY KEY ("LIB_ID")
  USING INDEX "INSTITUTE"."LIBRARY_MST_PK"  ENABLE;
