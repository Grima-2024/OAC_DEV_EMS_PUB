--------------------------------------------------------
--  Constraints for Table STUD_DOC_DET
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."STUD_DOC_DET" MODIFY ("DOC_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."STUD_DOC_DET" MODIFY ("STUDENT_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."STUD_DOC_DET" ADD CONSTRAINT "STUD_DOC_DET" PRIMARY KEY ("DOC_ID")
  USING INDEX "INSTITUTE"."STUD_DOC_DET"  ENABLE;
