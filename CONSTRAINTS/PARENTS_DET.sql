--------------------------------------------------------
--  Constraints for Table PARENTS_DET
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."PARENTS_DET" MODIFY ("PARENTS_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."PARENTS_DET" MODIFY ("INSTITUTE_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."PARENTS_DET" ADD CONSTRAINT "PARENTS_DET_PK" PRIMARY KEY ("PARENTS_ID")
  USING INDEX "INSTITUTE"."PARENTS_DET_PK"  ENABLE;