--------------------------------------------------------
--  Ref Constraints for Table EMP_DOCUMENTS_DET
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMP_DOCUMENTS_DET" ADD CONSTRAINT "EMP_DOC_DET_EMP_DET_FK" FOREIGN KEY ("EMPLOYEE_ID")
	  REFERENCES "INSTITUTE"."EMPLOYEE_DET" ("EMPLOYEE_ID") ENABLE;
