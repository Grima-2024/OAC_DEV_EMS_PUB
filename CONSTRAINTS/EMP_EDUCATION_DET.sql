--------------------------------------------------------
--  Constraints for Table EMP_EDUCATION_DET
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMP_EDUCATION_DET" MODIFY ("EDU_DET_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."EMP_EDUCATION_DET" MODIFY ("EMPLOYEE_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."EMP_EDUCATION_DET" ADD CONSTRAINT "EMP_EDUCATION_DET_PK" PRIMARY KEY ("EDU_DET_ID")
  USING INDEX "INSTITUTE"."EMP_EDUCATION_DET_PK"  ENABLE;
