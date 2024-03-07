--------------------------------------------------------
--  Ref Constraints for Table EMP_PAYROLL_DET
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMP_PAYROLL_DET" ADD CONSTRAINT "EMP_PAYROLL_DET_EMP_DET_FK" FOREIGN KEY ("EMPLOYEE_ID")
	  REFERENCES "INSTITUTE"."EMPLOYEE_DET" ("EMPLOYEE_ID") ENABLE;
