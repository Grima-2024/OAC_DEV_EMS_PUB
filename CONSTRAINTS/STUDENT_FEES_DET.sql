--------------------------------------------------------
--  Constraints for Table STUDENT_FEES_DET
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."STUDENT_FEES_DET" MODIFY ("FEES_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."STUDENT_FEES_DET" MODIFY ("INSTITUTE_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."STUDENT_FEES_DET" MODIFY ("AC_YEAR_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."STUDENT_FEES_DET" MODIFY ("STUDENT_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."STUDENT_FEES_DET" ADD CONSTRAINT "STUD_FEES_DET_PK" PRIMARY KEY ("FEES_ID")
  USING INDEX "INSTITUTE"."STUD_FEES_DET_PK"  ENABLE;
