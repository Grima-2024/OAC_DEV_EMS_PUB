--------------------------------------------------------
--  Constraints for Table EMP_DOCUMENTS_DET
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMP_DOCUMENTS_DET" MODIFY ("DOC_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."EMP_DOCUMENTS_DET" MODIFY ("EMPLOYEE_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."EMP_DOCUMENTS_DET" ADD CONSTRAINT "EMP_DOCUMENTS_DET_PK" PRIMARY KEY ("DOC_ID")
  USING INDEX "INSTITUTE"."EMP_DOCUMENTS_DET_PK"  ENABLE;