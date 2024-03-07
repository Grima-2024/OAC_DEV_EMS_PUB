--------------------------------------------------------
--  Ref Constraints for Table EMPLOYEE_DET
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMPLOYEE_DET" ADD CONSTRAINT "EMPLOYEE_DET_INSTITTE_DET_FK" FOREIGN KEY ("INSTITUTE_ID")
	  REFERENCES "INSTITUTE"."INSTITUTE_MST" ("INSTITUTE_ID") ENABLE;
