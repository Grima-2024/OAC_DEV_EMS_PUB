--------------------------------------------------------
--  Ref Constraints for Table EMP_EDUCATION_DET
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMP_EDUCATION_DET" ADD CONSTRAINT "EMP_EDU_DET_EMP_DET_FK" FOREIGN KEY ("EMPLOYEE_ID")
	  REFERENCES "INSTITUTE"."EMPLOYEE_DET" ("EMPLOYEE_ID") ENABLE;
